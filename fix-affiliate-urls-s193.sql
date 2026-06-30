-- S193: Inject real affiliate tracking URLs into capcut + elevenlabs
-- impact.com (CapCut/Bytedance) + PartnerStack (ElevenLabs) approved 2026-06-16
-- After this UPDATE, all /go/capcut and /go/elevenlabs site-wide auto-route through these tracking URLs
-- Idempotency: WHERE slug = ... single row updates, safe to re-run

UPDATE tools
SET affiliate_url = 'https://www.capcut.com/activities/subscribe/?irclickid=Utoz7uSOjxycUXDQf5V6x14LUkuQtPy9YSKE3k0&sharedid=&irpid=7414988&irgwc=1&afsrc=1'
WHERE slug = 'capcut';

UPDATE tools
SET affiliate_url = 'https://elevenlabs.io/?pscd=try.elevenlabs.io&ps_partner_key=ZGFlZjhlYWIzNDc5&ps_xid=UjJSpchIxkPHeH&gsxid=UjJSpchIxkPHeH&gspk=ZGFlZjhlYWIzNDc5'
WHERE slug = 'elevenlabs';

-- Verify the 2 rows updated
SELECT slug, name, affiliate_url FROM tools WHERE slug IN ('capcut','elevenlabs') ORDER BY slug;
