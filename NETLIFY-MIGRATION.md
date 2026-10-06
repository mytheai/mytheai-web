# Netlify Migration Guide

Hướng dẫn chuyển MytheAi từ Vercel (bị bắt upgrade Pro $20/tháng) sang Netlify (free tier cho phép commercial use).

Created: 2026-10-06. Last tested with: Next.js 16.2.4, React 19.2.4.

---

## Trạng thái hiện tại (trước khi migrate)

- **DNS**: mytheai.com → Hostinger (213.210.57.3, 147.93.77.115) - sai, cert hết hạn
- **Vercel**: deployment DISABLED (HTTP 402 Payment Required) - do affiliate = commercial, Hobby plan không cho
- **Hostinger**: serve bản prototype cũ (last-modified 2026-04-23) - không phải site thật
- **Github repo**: `mytheai/mytheai-web` master branch - OK, không cần đổi

## Những gì đã làm sẵn ở Phase 1

- `netlify.toml` tạo mới (pin Node 20, publish `.next`)
- `.gitignore` thêm `.netlify/` để không commit nhầm
- Verified: không có custom middleware (tránh Edge Runtime pino bug trong Netlify forum)
- Verified: tất cả `redirects()` + `headers()` trong `next.config.ts` là static, Netlify auto-convert được
- `@netlify/plugin-nextjs` KHÔNG pin trong package.json - Netlify tự install bản mới nhất tương thích (theo khuyến nghị official của Netlify)

---

## Phase 2: Việc bạn phải tự làm (~15 phút)

### Bước 1 - Đăng ký Netlify account

1. Mở https://app.netlify.com/signup
2. Chọn **"Sign up with GitHub"** (nhanh nhất, dùng OAuth, không cần password mới)
3. Approve OAuth: cho phép Netlify đọc public + private repos (chỉ cần `mytheai-web`)

### Bước 2 - Connect GitHub repo

1. Trong Netlify Dashboard → **"Add new site"** → **"Import an existing project"**
2. Chọn **GitHub** → tìm repo `mytheai/mytheai-web` → click
3. Branch: **`master`**
4. Build settings sẽ auto-detect từ `netlify.toml`:
   - Base directory: *(để trống)* - repo root chính là Next.js app
   - Build command: `npm run build`
   - Publish directory: `.next`
5. **KHÔNG click "Deploy site" ngay** - cần add env vars trước (bước 3). Click vào mũi tên xuống bên nút Deploy → chọn **"Deploy site without adding environment variables"** NẾU không có option tạm pause, hoặc đi tới Step 3 cấu hình env trước rồi quay lại trigger deploy.

### Bước 3 - Add environment variables

Site Settings → **Environment variables** → **Add a variable** cho mỗi dòng dưới đây.

**Required (6 vars) - thiếu là build fail hoặc runtime error:**

| Name | Lấy value ở đâu |
|------|------------------|
| `NEXT_PUBLIC_SUPABASE_URL` | Vercel Dashboard → mytheai-web → Settings → Env Vars → copy value. HOẶC file `.env.local` dòng 1. HOẶC Supabase dashboard → Project Settings → API → Project URL |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Same như trên, hoặc Supabase dashboard → API keys → `anon public` |
| `SUPABASE_SERVICE_ROLE_KEY` | Vercel env vars hoặc Supabase dashboard → API keys → `service_role` (CRITICAL - bypass RLS, không được leak) |
| `NEXT_PUBLIC_YANDEX_VERIFICATION` | Vercel env vars. Value là `722d60f730528abe` theo CLAUDE.md S163 - không đổi. Thiếu thì mất Yandex verification nhưng site vẫn chạy |
| `NEXT_PUBLIC_CLARITY_PROJECT_ID` | Vercel env vars. Value là `wrjcddzlg9` theo CLAUDE.md S163. Thiếu thì mất Microsoft Clarity analytics |
| `IP_HASH_SALT` | Nếu đã có trong Vercel thì copy. Nếu chưa, tự tạo random 32-char: `node -e "console.log(require('crypto').randomBytes(16).toString('hex'))"` - dùng cho hash IP ở review API chống spam |

**Optional (newsletter double opt-in, nếu đang dùng Resend):**

| Name | Note |
|------|------|
| `RESEND_API_KEY` | Nếu dùng Resend cho newsletter. Thiếu thì newsletter vẫn write Supabase OK, chỉ không gửi welcome email |
| `RESEND_AUDIENCE_ID` | Nếu dùng Resend audience |

**KHÔNG cần thêm trên Netlify (dùng ở nơi khác):**
- `DATABASE_URL` - chỉ cho local scripts
- `INDEXNOW_KEY` - GitHub Actions repo secret (đã có, không đổi)
- `PLAUSIBLE_API_KEY` - chỉ cho local dashboard tool

**Scope setting cho mỗi var:**
- Chọn **"All scopes"** hoặc tick cả `Production` + `Deploy previews` + `Branch deploys` - đảm bảo build + runtime đều có.
- `NEXT_PUBLIC_*` vars sẽ được inline vào JS bundle lúc build (public), các var khác chỉ ở server runtime.

### Bước 4 - Trigger first build

Deploys tab → **Trigger deploy** → **Deploy site**. Build log sẽ chạy ~5-10 phút cho ~1700 pages.

Build log thành công sẽ kết thúc bằng:
```
Site is live ✨
```
và cho URL dạng `https://[random-name].netlify.app`.

### Bước 5 - Smoke test production URL

Trước khi đổi DNS, verify Netlify URL hoạt động bằng mở các path này trong browser:

- `https://[random].netlify.app` → homepage render với 588 tools
- `https://[random].netlify.app/tools/claude` → tool detail có TrustStack + hands-on
- `https://[random].netlify.app/best/coding` → money page có 9 picks
- `https://[random].netlify.app/compare/claude-vs-chatgpt` → compare page
- `https://[random].netlify.app/go/claude` → redirect 307 ra claude.ai (affiliate route)

**Nếu bất kỳ path nào fail**, báo lại tôi với log hoặc screenshot - đừng đổi DNS vội.

---

## Phase 3: Đổi DNS tại Hostinger (~5 phút)

**Chỉ làm sau khi smoke test Netlify URL thành công hoàn toàn.**

### Bước 1 - Lấy Netlify DNS values

Netlify Dashboard → Site → **Domain settings** → **Add custom domain** → nhập `mytheai.com` → Netlify sẽ hiện 2 options:
- **Option A**: trỏ nameservers về Netlify (dễ nhất, Netlify quản lý toàn bộ DNS)
- **Option B**: giữ nameservers Hostinger, chỉ update A records (an toàn hơn - email và DNS khác không bị ảnh hưởng)

**Khuyến nghị: Option B** - vì Hostinger có thể còn email forward hoặc records khác bạn cần giữ.

Netlify sẽ cho bạn:
- **A record for apex** (`mytheai.com`): một IP Netlify (ví dụ `75.2.60.5` - lấy chính xác từ Netlify UI vì có thể đổi theo thời gian)
- **CNAME for www** (`www.mytheai.com`): `[your-site-name].netlify.app`

### Bước 2 - Update tại Hostinger DNS

1. Hostinger panel → **Domains** → `mytheai.com` → **DNS / Nameservers** → **Manage DNS Records**
2. Trong bảng records:
   - **XOÁ** tất cả A records trỏ về `213.210.57.3` và `147.93.77.115` (Hostinger hosting IPs cũ)
   - **XOÁ** tất cả AAAA records IPv6 `2a02:4780:*`
   - **THÊM** 1 A record mới:
     - Name/Host: `@` (= apex, tức `mytheai.com`)
     - Points to: *(IP Netlify cho ở bước 1)*
     - TTL: `3600` (hoặc default)
   - **THÊM** 1 CNAME record:
     - Name/Host: `www`
     - Points to: `[your-site-name].netlify.app`
     - TTL: `3600`
3. Save

### Bước 3 - SSL certificate

Về Netlify Dashboard → Site → Domain settings → `mytheai.com` → sẽ hiện "**Verify DNS configuration**". Click. Netlify tự verify + tự cấp Let's Encrypt SSL miễn phí trong 5-30 phút.

### Bước 4 - DNS propagation

Chờ 5-60 phút. Verify bằng:
```bash
nslookup mytheai.com 8.8.8.8
```
Phải thấy IP Netlify (không còn `213.210.57.3`).

Rồi test:
```bash
curl -sI https://mytheai.com/
```
Phải thấy:
```
HTTP/2 200
server: Netlify
```

**Nếu sau 60 phút vẫn thấy IP cũ**, có thể cache local - thử trong incognito mode hoặc dùng `nslookup ... 1.1.1.1` để query Cloudflare DNS.

---

## Phase 4: Verify production (sau DNS propagation)

Test tất cả path quan trọng với domain thật:

- `https://mytheai.com/` → 200
- `https://mytheai.com/tools/claude` → 200
- `https://mytheai.com/best/coding` → 200
- `https://mytheai.com/compare/claude-vs-chatgpt` → 200
- `https://mytheai.com/go/claude` → 307 redirect
- `https://mytheai.com/sitemap.xml` → 200 + 1684 URLs
- `https://mytheai.com/robots.txt` → 200

Submit `https://mytheai.com/sitemap.xml` lại tại:
- Bing Webmaster Tools (optional, nếu đã có từ S163)
- Google Search Console (bắt buộc)

---

## Rollback plan (nếu Netlify fail)

Netlify không ảnh hưởng Vercel - 2 nền tảng độc lập. Fallback options:

1. **Giữ nguyên DNS Hostinger** chưa đổi: Netlify fail cũng không ảnh hưởng ai (vì DNS chưa trỏ về Netlify)
2. **Nếu đã đổi DNS mà Netlify sập**: revert DNS về `A @ 76.76.21.21` + `CNAME www cname.vercel-dns.com` → Vercel (vẫn disabled nhưng Vercel sẽ show error page thay vì DNS fail), hoặc trả tiền Vercel Pro để enable lại
3. **Nếu muốn thử free alternative khác**: Cloudflare Pages (unlimited bandwidth, cần adapter khác)

Toàn bộ code đổi trên Netlify (`netlify.toml`, `.gitignore`) không conflict với Vercel - có thể giữ cả hai config song song.

---

## Troubleshooting thường gặp

### Build fail: "Module not found: Can't resolve '...'"
Node version mismatch. Verify `netlify.toml` có `NODE_VERSION = "20"` + xoá cache: Site settings → Build & deploy → Build settings → **Clear cache and deploy site**.

### Build fail: "supabaseUrl is required"
Env var `NEXT_PUBLIC_SUPABASE_URL` chưa add hoặc scope không đúng. Verify Site settings → Environment variables.

### Build timeout (>15 min)
Free tier có limit 15min build. Giải pháp:
- Convert một số `generateStaticParams()` sang ISR (revalidate at runtime, không SSG hết lúc build)
- Hoặc upgrade Netlify Pro $19/mo (vẫn rẻ hơn Vercel Pro)

### Site live nhưng image không load
`next/image` optimization không chạy. Verify netlify.toml không có `[images]` override + plugin version mới nhất (clear cache + redeploy).

### Review API 500 error
Thiếu `SUPABASE_SERVICE_ROLE_KEY`. Check env var scope đúng cho runtime (All scopes).

---

## Sau khi migration xong

1. Update `RUNBOOK.md` → đổi "Vercel" references → "Netlify"
2. Update `.github/workflows/indexnow-on-deploy.yml` comment line 10 "wait 3 minutes for Vercel deploy" → "Netlify deploy"
3. Pause Vercel billing (nếu còn active) để không mất tiền hậu kỳ
4. Lưu Netlify dashboard URL vào bookmark cho RUNBOOK scenarios
