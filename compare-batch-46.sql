-- compare-batch-46.sql
-- 5 AI Design tool comparison pairs
-- All tools from tools-batch-46 (confirmed in DB)
-- Run AFTER tools-batch-46 confirmed in Supabase
-- Actual slugs: framer, galileo-ai, locofy, uizard, visily, relume, subframe, penpot, diagram, magician

-- 1. framer-vs-relume
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'framer-vs-relume', 'framer', 'relume',
  'Framer and Relume both use AI to accelerate website creation, but they solve different problems in the workflow. Relume is a planning tool - it generates sitemaps and wireframes to help designers and agencies figure out site structure before any real design work begins, then exports that structure to Figma or Webflow. Framer is an execution tool - it generates a complete, live, hosted website from a text description, handling design, code, and deployment in one platform. Relume wins for web designers and agencies who use Figma or Webflow and need a fast way to plan site architecture for client projects. Framer wins for founders, small businesses, and solo creators who want a complete production website without hiring a designer or developer.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'framer-vs-relume');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'framer-vs-relume', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Generation Quality', 5, 4, 'Framer generates complete production-ready websites with real layouts, components, and CSS. Relume generates wireframes and site structures that serve as a planning scaffold rather than final output.'),
  ('Output Type', 5, 3, 'Framer output is a live, hosted website with real React components. Relume output is wireframes and sitemaps that export to Figma or Webflow for further design work.'),
  ('Hosting and Deployment', 5, 1, 'Framer includes hosting, CDN, custom domains, and CMS in one platform. Relume has no hosting - it is a planning tool only, not a complete website solution.'),
  ('Figma and Webflow Integration', 2, 5, 'Relume exports directly to Figma as editable frames and to Webflow as components - designed for professional design team workflows. Framer has limited Figma integration.'),
  ('Site Structure Planning', 2, 5, 'Relume AI generates complete sitemaps with recommended pages based on business type and goals. Framer generates a single design, not a strategic site architecture.'),
  ('Non-Designer Accessibility', 5, 2, 'Framer requires no design knowledge - it generates, hosts, and publishes a complete site. Relume is built for designers and agencies who know Figma and Webflow workflows.'),
  ('Free Plan', 4, 3, 'Framer free plan supports one project with a Framer subdomain - enough to evaluate the full product. Relume free plan is more limited in component access and exports.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'framer-vs-relume')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'framer-vs-relume');

-- 2. galileo-ai-vs-uizard
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'galileo-ai-vs-uizard', 'galileo-ai', 'uizard',
  'Galileo AI and Uizard both generate UI designs from text prompts, but they target different stages of the design process and different types of users. Galileo AI is built for designers who want to explore multiple polished directions quickly - it generates convention-following UI screens that export to Figma for professional refinement. Uizard is built for non-designers - product managers, founders, and startup teams - who need to communicate interface ideas without design experience. Its sketch-to-wireframe conversion and screenshot-to-design features are particularly useful at the very beginning of a project. Galileo AI wins for design teams who need fast, polished starting points. Uizard wins for non-designers who need to turn rough ideas into communicable wireframes quickly.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'galileo-ai-vs-uizard');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'galileo-ai-vs-uizard', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Output Visual Polish', 5, 3, 'Galileo AI produces design-convention-following screens with proper component hierarchy, spacing, and type. Uizard output is clean but aimed at wireframe quality rather than production-ready UI.'),
  ('Figma Export', 5, 2, 'Galileo AI exports directly to Figma as editable components - designed for professional designer workflows. Uizard has Figma export but it is not the primary workflow focus.'),
  ('Sketch-to-Wireframe', 1, 5, 'Uizard converts a photo of a hand-drawn sketch into a digital wireframe - genuinely useful at the earliest idea stage. Galileo AI has no sketch input capability.'),
  ('Non-Designer Accessibility', 2, 5, 'Uizard is explicitly designed for product managers, founders, and startup teams with no design background. Galileo AI output is polished but assumes design context awareness.'),
  ('Clickable Prototyping', 1, 5, 'Uizard produces clickable prototypes ready for user testing or stakeholder review with minimal setup. Galileo AI generates static screens without built-in prototyping flows.'),
  ('Speed of Direction Exploration', 5, 4, 'Galileo AI generates multiple polished full-screen UI designs in seconds, ideal for design direction exploration at project start. Uizard is also fast but focuses on individual screens rather than systematic exploration.'),
  ('Pricing', 3, 4, 'Uizard free plan includes 3 projects. Galileo AI has no free tier, starting at $19/month - a meaningful difference for individuals evaluating before committing.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'galileo-ai-vs-uizard')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'galileo-ai-vs-uizard');

-- 3. locofy-vs-subframe
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'locofy-vs-subframe', 'locofy', 'subframe',
  'Locofy and Subframe are both tools that bridge design and frontend development, but they approach the problem from opposite directions. Locofy starts with an existing Figma design and converts it to code - it is a design-to-code handoff tool for teams that already have a designer producing Figma files. Subframe starts with a component library and lets you build application UIs visually before exporting clean React and Tailwind CSS code - it is a UI builder for teams that want to go directly from concept to code without a separate design tool. Locofy wins for design teams handing off finished Figma files to developers. Subframe wins for product teams and developers who want to build application interfaces visually without a separate design phase.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'locofy-vs-subframe');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'locofy-vs-subframe', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Figma Input', 5, 1, 'Locofy works as a Figma plugin and converts existing Figma designs to code - directly integrated into the designer workflow. Subframe is a standalone builder that does not import from Figma.'),
  ('Code Quality', 4, 5, 'Subframe generates genuinely clean, maintainable React and Tailwind CSS that follows real development conventions. Locofy output is good but may require more developer cleanup depending on how the Figma file is structured.'),
  ('Application Component Library', 2, 5, 'Subframe includes a focused library of application UI patterns - data tables, dashboards, forms, sidebars - designed for building product interfaces. Locofy converts whatever components are in the Figma file.'),
  ('Accessibility by Default', 2, 5, 'Subframe components are accessible and responsive by default. Locofy accessibility depends entirely on how the original Figma design was built.'),
  ('Workflow Starting Point', 5, 2, 'Locofy fits teams that already have a designer producing Figma files and need to accelerate the handoff to development. Subframe fits teams that want to build UI directly without a design step.'),
  ('Framework Support', 4, 3, 'Locofy generates React, Vue, Next.js, and HTML/CSS depending on the project setup. Subframe generates React with Tailwind CSS specifically.'),
  ('Pricing', 4, 4, 'Both tools offer free tiers for initial evaluation. Locofy pricing scales with project volume; Subframe pricing is team-focused with per-seat pricing for advanced features.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'locofy-vs-subframe')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'locofy-vs-subframe');

-- 4. penpot-vs-uizard
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'penpot-vs-uizard', 'penpot', 'uizard',
  'Penpot and Uizard are both free alternatives to Figma, but they serve fundamentally different audiences. Penpot is a professional open-source design tool with auto-layout, components, a developer inspection panel, and self-hosting options - it is designed for design teams who want Figma-level capability without per-seat pricing. Uizard is a simplified AI-powered prototyping tool for non-designers - product managers, founders, and startup teams who need to wireframe quickly without design training. Penpot wins for design teams that need a professional tool at zero cost with data sovereignty. Uizard wins for non-designers who need to communicate interface ideas quickly without learning a professional design tool.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'penpot-vs-uizard');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'penpot-vs-uizard', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Professional Design Capability', 5, 2, 'Penpot offers auto-layout, reusable components, design tokens, prototyping, and a developer inspection panel - comparable to Figma in core functionality. Uizard is a simplified tool focused on fast wireframing, not professional design.'),
  ('Non-Designer Accessibility', 2, 5, 'Uizard is explicitly built for product managers and founders with no design experience - AI generation removes the blank canvas problem. Penpot has a learning curve comparable to Figma.'),
  ('AI Generation Features', 1, 4, 'Uizard includes AI wireframe generation from text, sketch conversion, and screenshot-to-design. Penpot is adding AI features but remains primarily a professional design tool without AI content generation at the core.'),
  ('Self-Hosting', 5, 1, 'Penpot can be self-hosted on your own infrastructure - critical for teams with data residency requirements. Uizard is a cloud-only SaaS tool.'),
  ('Developer Handoff', 5, 2, 'Penpot has a dedicated developer panel showing CSS properties, dimensions, and export options directly from the design. Uizard handoff is basic - useful for communication but not production-grade spec delivery.'),
  ('Collaborative Features', 4, 4, 'Both tools support real-time collaboration. Penpot is mature in team design workflows; Uizard is strong for product team reviews and stakeholder alignment sessions.'),
  ('Pricing', 5, 4, 'Penpot is completely free with unlimited seats on the cloud version and self-hosting at no cost. Uizard free plan is limited to 3 projects; paid plans start at $12/month.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'penpot-vs-uizard')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'penpot-vs-uizard');

-- 5. visily-vs-diagram
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'visily-vs-diagram', 'visily', 'diagram',
  'Visily and Diagram are both AI design tools that reduce friction in the early stages of interface design, but they solve different problems in different contexts. Visily is a standalone wireframing platform that lets non-designers produce AI-generated wireframes from a text description, collaborate with team members, and export to Figma when ready. Diagram is a collection of AI plugins that work inside Figma - adding generative UI, automated layer cleanup, and UX copy generation to an existing Figma workflow. Visily wins for teams without a dedicated designer who need a standalone tool anyone can use. Diagram wins for existing Figma users who want to add AI capabilities without switching to a new platform.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'visily-vs-diagram');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'visily-vs-diagram', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Standalone vs Plugin', 5, 2, 'Visily is a complete standalone platform - no other tools required. Diagram requires an active Figma subscription and is only useful to existing Figma users.'),
  ('Non-Designer Accessibility', 5, 2, 'Visily is designed for product teams without a dedicated designer - the AI removes the blank canvas problem. Diagram is designed for designers already using Figma who want to work faster.'),
  ('Figma Workflow Integration', 1, 5, 'Diagram works as Figma plugins with no context switch - AI features appear directly in the design file. Visily requires working outside Figma and exporting when ready.'),
  ('Automated Layer Cleanup', 1, 5, 'Diagram Automator batch-renames layers, applies naming conventions, and cleans up messy Figma files. Visily has no equivalent for managing design file hygiene.'),
  ('UX Copy Generation', 2, 5, 'Diagram UX Writer generates placeholder headlines, button labels, and error messages in context within Figma. Visily does not have a UX copy generation feature.'),
  ('Team Collaboration', 5, 2, 'Visily includes real-time team commenting and annotation for collaborative wireframe review. Diagram plugins run per-user within Figma and do not add team collaboration features beyond what Figma already provides.'),
  ('Pricing', 4, 4, 'Visily free plan is available for individuals; team pricing from $13/user/month. Diagram plugins have individual free tiers; some features require a paid subscription.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'visily-vs-diagram')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'visily-vs-diagram');
