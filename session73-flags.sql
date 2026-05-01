-- session73-flags.sql
-- trending/featured flags for tools-batch-59 (AI Construction / Architecture)

-- Trending: autodesk-forma (generative urban design, strong brand), openspace (site capture momentum),
--           buildots (schedule intelligence, high commercial adoption)
UPDATE tools SET trending = true  WHERE slug IN ('autodesk-forma', 'openspace', 'buildots');
UPDATE tools SET trending = false WHERE slug IN ('testfit', 'archistar', 'togal-ai', 'disperse', 'join-build', 'trunk-tools', 'spacemaker');

-- Featured: autodesk-forma (strongest brand recognition and Autodesk ecosystem) + openspace (broadest
--           construction use case with Procore integration and clear ROI)
UPDATE tools SET featured = true  WHERE slug IN ('autodesk-forma', 'openspace');
UPDATE tools SET featured = false WHERE slug IN (
  'testfit', 'archistar', 'togal-ai', 'disperse', 'join-build', 'trunk-tools', 'spacemaker', 'buildots'
);

-- Verify
SELECT slug, name, trending, featured FROM tools WHERE slug IN (
  'autodesk-forma', 'testfit', 'archistar', 'openspace', 'buildots',
  'togal-ai', 'disperse', 'join-build', 'trunk-tools', 'spacemaker'
) ORDER BY slug;
