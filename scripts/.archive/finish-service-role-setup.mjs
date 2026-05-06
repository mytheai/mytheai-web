#!/usr/bin/env node
/**
 * One-shot script to finish service-role key setup after `supabase login`.
 *
 * Steps:
 *  1. Fetch service_role key from Supabase project via `supabase projects api-keys`
 *  2. Replace or append SUPABASE_SERVICE_ROLE_KEY in web/.env.local
 *  3. If .vercel/project.json exists, push the env var to Vercel production+preview
 *  4. Never print the key value
 *
 * Usage:
 *   node scripts/finish-service-role-setup.mjs
 *
 * Pre-reqs:
 *   - `supabase login` completed
 *   - (optional) `vercel link` to enable Vercel push
 */

import { execSync, spawn } from 'node:child_process';
import { readFileSync, writeFileSync, existsSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const WEB_DIR = resolve(__dirname, '..');
const ENV_FILE = resolve(WEB_DIR, '.env.local');
const VERCEL_PROJECT_FILE = resolve(WEB_DIR, '.vercel', 'project.json');
const PROJECT_REF = 'amonzprhauwjndymeiua';
const ENV_VAR_NAME = 'SUPABASE_SERVICE_ROLE_KEY';

function fail(msg) {
  console.error(`ERROR: ${msg}`);
  process.exit(1);
}

function fetchServiceRoleKey() {
  let raw;
  try {
    raw = execSync(
      `supabase projects api-keys --project-ref ${PROJECT_REF} --output json`,
      { encoding: 'utf8', stdio: ['pipe', 'pipe', 'pipe'] }
    );
  } catch (err) {
    const stderr = err.stderr ? err.stderr.toString() : '';
    fail(
      `supabase api-keys command failed. Did you run 'supabase login'?\n${stderr.trim()}`
    );
  }

  let parsed;
  try {
    parsed = JSON.parse(raw);
  } catch (err) {
    fail(`Could not parse supabase output as JSON: ${err.message}`);
  }

  if (!Array.isArray(parsed)) {
    fail('Expected an array from supabase api-keys output.');
  }

  const entry = parsed.find((k) => k && k.name === 'service_role');
  if (!entry || !entry.api_key) {
    fail('No service_role key found in supabase api-keys response.');
  }

  return entry.api_key;
}

function writeEnvLocal(key) {
  let mode = 'append';
  let lines = [];

  if (existsSync(ENV_FILE)) {
    const content = readFileSync(ENV_FILE, 'utf8');
    lines = content.split(/\r?\n/);
    const idx = lines.findIndex((l) => l.startsWith(`${ENV_VAR_NAME}=`));
    if (idx >= 0) {
      lines[idx] = `${ENV_VAR_NAME}=${key}`;
      mode = 'replace';
    } else {
      // strip trailing empty line, then append
      while (lines.length && lines[lines.length - 1] === '') lines.pop();
      lines.push(`${ENV_VAR_NAME}=${key}`);
      lines.push('');
    }
  } else {
    lines = [`${ENV_VAR_NAME}=${key}`, ''];
  }

  writeFileSync(ENV_FILE, lines.join('\n'), 'utf8');
  return mode;
}

function pushToVercel(key, environment) {
  return new Promise((resolvePromise, rejectPromise) => {
    const isWindows = process.platform === 'win32';
    const child = spawn(
      'vercel',
      ['env', 'add', ENV_VAR_NAME, environment],
      {
        cwd: WEB_DIR,
        stdio: ['pipe', 'pipe', 'pipe'],
        shell: isWindows,
      }
    );

    let stderr = '';
    let stdout = '';
    child.stdout.on('data', (d) => {
      stdout += d.toString();
    });
    child.stderr.on('data', (d) => {
      stderr += d.toString();
    });

    // Vercel CLI prompts for the value on stdin.
    child.stdin.write(`${key}\n`);
    child.stdin.end();

    child.on('error', (err) => rejectPromise(err));
    child.on('close', (code) => {
      if (code === 0) {
        resolvePromise();
      } else {
        const combined = `${stdout}\n${stderr}`.trim();
        // If env var already exists, treat as soft-success
        if (/already exists/i.test(combined)) {
          console.log(
            `note: ${ENV_VAR_NAME} already exists on Vercel ${environment} - leaving as-is`
          );
          resolvePromise();
        } else {
          rejectPromise(new Error(`vercel env add ${environment} exited ${code}: ${combined}`));
        }
      }
    });
  });
}

async function main() {
  const key = fetchServiceRoleKey();
  console.log(`service role key fetched, length=${key.length}`);

  const mode = writeEnvLocal(key);
  console.log(`wrote to .env.local (${mode})`);

  if (!existsSync(VERCEL_PROJECT_FILE)) {
    console.log(
      'WARN: .vercel/project.json not found. Run `vercel link` to enable auto-push to Vercel.'
    );
    console.log('DONE');
    return;
  }

  for (const env of ['production', 'preview']) {
    try {
      await pushToVercel(key, env);
      console.log(`pushed to Vercel ${env}`);
    } catch (err) {
      fail(err.message);
    }
  }

  console.log('DONE');
}

main().catch((err) => fail(err.message || String(err)));
