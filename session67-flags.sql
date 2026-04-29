-- session67-flags.sql
-- trending/featured flags for tools-batch-53 (AI CRM / Sales tools)

-- Trending: AI-native CRM tools gaining traction in 2026
UPDATE tools SET trending = true  WHERE slug IN ('freshsales', 'folk', 'smartlead', 'amplemarket');
UPDATE tools SET trending = false WHERE slug IN ('salesforce-einstein', 'zoho-crm', 'close', 'streak', 'clari', 'kommo');

-- Featured: none from this batch - Editor's Picks unchanged
UPDATE tools SET featured = false WHERE slug IN (
  'salesforce-einstein', 'freshsales', 'zoho-crm', 'folk',
  'close', 'streak', 'smartlead', 'clari', 'amplemarket', 'kommo'
);

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'salesforce-einstein', 'freshsales', 'zoho-crm', 'folk',
  'close', 'streak', 'smartlead', 'clari', 'amplemarket', 'kommo'
)
ORDER BY slug;
