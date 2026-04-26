-- session18-patch.sql
-- Adds google-meet + microsoft-teams tools, then fixes comparison slugs
-- Safe to re-run (ON CONFLICT DO NOTHING + UPDATE only changes what's wrong)
-- Run in Supabase SQL Editor

-- 1. Add missing tools referenced by compare-batch-3.sql
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'google-meet',
  'Google Meet',
  'Video conferencing built into Google Workspace with no download required',
  E'Google Meet is Google''s video conferencing platform, included with every Google account and deeply integrated into Google Workspace. It requires no software download for participants — joining a call is as simple as clicking a calendar invite link, which opens directly in the browser. This frictionless entry point has made Meet the dominant choice for organisations already using Google Workspace, where meetings appear automatically in Google Calendar and participants can join in a single click from Gmail or the Calendar event. For free personal accounts, Meet supports up to 100 participants per call with no time limit on standard calls.\n\nMeet''s AI features have expanded significantly since 2024. Gemini-powered meeting notes generate automatic summaries and action items, noise cancellation runs locally to reduce background disruption, and live translation captions support over 70 languages in real time. Meet works across all major devices and operating systems without installation, and recordings save directly to Google Drive. Paid Google Workspace plans extend capabilities to larger meeting capacities, advanced moderation controls, attendance tracking, and Q&A features for all-hands sessions. For organisations within the Google ecosystem, Meet is the most cost-effective and frictionless video conferencing solution available.',
  'https://www.google.com/s2/favicons?domain=meet.google.com&sz=64',
  'https://meet.google.com',
  'https://meet.google.com',
  ARRAY['productivity'],
  'freemium', true, 0,
  4.4, 2800, false, false, false,
  ARRAY['No download required — join from any browser in one click', 'Included free with every Google account', 'Native integration with Google Calendar and Gmail', 'Gemini AI meeting notes and live translation captions'],
  ARRAY['Webinar features require paid Workspace upgrade', 'Video quality slightly behind Zoom at high participant counts', 'Recording and transcription require paid plan'],
  ARRAY['Team meetings and standups for Google Workspace users', 'Client calls and external video meetings', 'All-hands and company-wide broadcasts', 'Educational classes and tutoring sessions']
),

(
  'microsoft-teams',
  'Microsoft Teams',
  'The collaboration hub for chat, calls, and file sharing in Microsoft 365',
  E'Microsoft Teams is the workplace communication and collaboration platform embedded within Microsoft 365, used by more than 320 million monthly active users globally. Teams combines persistent chat, video meetings, file storage, and application integrations into a single hub. Each team has dedicated channels for organised topic-based conversations, and files shared in a channel are automatically stored in SharePoint, making them accessible to the whole group. The deep integration with Word, Excel, PowerPoint, and OneNote means documents can be opened, edited collaboratively, and discussed in the same window, reducing context switching during projects.\n\nTeams'' AI features are powered by Microsoft Copilot, which summarises missed conversations, drafts responses, generates meeting notes, and answers questions about a team''s shared files and chat history. The free version of Teams supports unlimited chat and 60-minute group video calls. Most Teams capabilities are accessed through Microsoft 365 Business subscriptions starting at $6 per user per month, where Teams is included alongside the full Office suite, making it effectively zero marginal cost for organisations already on Microsoft 365. For enterprises standardised on Microsoft infrastructure, Teams is the natural and often mandatory choice.',
  'https://www.google.com/s2/favicons?domain=teams.microsoft.com&sz=64',
  'https://teams.microsoft.com',
  'https://teams.microsoft.com',
  ARRAY['productivity'],
  'freemium', true, 6,
  4.2, 3200, false, false, false,
  ARRAY['Included in Microsoft 365 — zero extra cost for existing subscribers', 'Deep integration with Word, Excel, SharePoint, and OneDrive', 'Microsoft Copilot AI summarises threads and generates meeting notes', 'Mature video calling with large meeting capacity'],
  ARRAY['Interface is heavier and less intuitive than Slack', 'Performance can slow on older hardware', 'Notification management requires significant configuration'],
  ARRAY['Organisation-wide communication for Microsoft 365 users', 'Project collaboration with shared Office documents', 'Video meetings and company all-hands', 'Connecting remote and hybrid teams across time zones']
)

ON CONFLICT (slug) DO NOTHING;

-- 2. Fix comparison tool_b_slug values (if compare-batch-3.sql was run before this patch)
UPDATE comparisons
SET tool_b_slug = 'google-meet'
WHERE slug = 'zoom-vs-google-meet' AND tool_b_slug = 'gemini';

UPDATE comparisons
SET tool_b_slug = 'microsoft-teams'
WHERE slug = 'slack-vs-teams' AND tool_b_slug = 'monday';
