-- Add missing columns to tools table
alter table tools
  add column if not exists pros text[] default '{}',
  add column if not exists cons text[] default '{}',
  add column if not exists use_cases text[] default '{}';

-- Update descriptions and pros/cons for 6 tools
update tools set
  description = 'Claude is Anthropic''s flagship AI assistant, built with a focus on safety, helpfulness, and honesty. It excels at long-form writing, complex reasoning, coding, and nuanced analysis. Claude supports extremely long context windows (up to 200k tokens), making it ideal for reading full documents, codebases, or research papers in a single session.',
  pros = ARRAY['Best-in-class reasoning and analysis', 'Largest context window (200k tokens)', 'Excellent at following complex instructions', 'Honest about limitations', 'Strong coding and debugging skills'],
  cons = ARRAY['No image generation', 'No real-time web browsing on free tier', 'Slower than some competitors on simple tasks'],
  use_cases = ARRAY['Long document analysis and summarization', 'Complex coding projects', 'Research and writing', 'Data analysis']
where slug = 'claude';

update tools set
  description = 'Midjourney is the leading AI image generation platform, known for producing strikingly artistic, high-quality visuals. It runs via Discord and a web interface, offering fine-grained style controls. Midjourney consistently outperforms competitors on aesthetic quality and is the go-to tool for designers, marketers, and creatives who need professional-grade imagery.',
  pros = ARRAY['Unmatched aesthetic quality', 'Highly customizable style parameters', 'Active community and inspiration gallery', 'Consistent and reliable results'],
  cons = ARRAY['No free tier', 'Requires Discord account', 'Less control over exact compositions compared to Stable Diffusion'],
  use_cases = ARRAY['Marketing and brand visuals', 'Concept art and illustrations', 'Social media content', 'Product mockups']
where slug = 'midjourney';

update tools set
  description = 'Notion AI integrates directly into the Notion workspace, bringing AI-powered writing, summarization, and organization to one of the world''s most popular productivity tools. It can generate content, translate text, fix grammar, summarize pages, and even extract action items from meeting notes — all without leaving your existing workflow.',
  pros = ARRAY['Seamlessly integrated into Notion', 'Great for summarizing existing notes', 'No context switching needed', 'Supports multiple languages'],
  cons = ARRAY['Requires Notion subscription', 'Less powerful than standalone AI tools', 'Limited to Notion ecosystem'],
  use_cases = ARRAY['Summarizing meeting notes', 'Drafting documents and wikis', 'Extracting action items', 'Translating content']
where slug = 'notion-ai';

update tools set
  description = 'ChatGPT is OpenAI''s conversational AI, the most widely used AI assistant in the world. GPT-4o offers multimodal capabilities including text, image, and voice. With plugins, web browsing, and code interpreter, ChatGPT Plus provides a versatile toolkit for everyday tasks. The free tier with GPT-4o mini is generous and suitable for most users.',
  pros = ARRAY['Largest user base and ecosystem', 'Multimodal: text, image, voice', 'Strong plugin and tool ecosystem', 'Generous free tier'],
  cons = ARRAY['Can be inconsistent on complex reasoning', 'Rate limits on free tier', 'Occasional hallucinations on factual queries'],
  use_cases = ARRAY['Everyday writing and editing', 'Quick research and Q&A', 'Code generation', 'Image analysis']
where slug = 'chatgpt';

update tools set
  description = 'GitHub Copilot is the most widely adopted AI coding assistant, integrated directly into VS Code, JetBrains, and other major IDEs. Powered by OpenAI models, it provides real-time code completions, whole-function generation, and chat-based coding assistance. Copilot Business adds organization-wide policies and audit logs for teams.',
  pros = ARRAY['Deep IDE integration', 'Real-time autocomplete as you type', 'Supports 20+ programming languages', 'Business tier with team controls'],
  cons = ARRAY['No completely free tier (student/OS exceptions)', 'Can suggest outdated or insecure code patterns', 'Requires constant review of suggestions'],
  use_cases = ARRAY['Real-time code completion', 'Boilerplate generation', 'Writing tests', 'Code explanation and refactoring']
where slug = 'github-copilot';

update tools set
  description = 'Gemini is Google''s multimodal AI model, available for free with a generous daily limit. Gemini Advanced (paid) uses the most capable Ultra model and integrates deeply with Google Workspace — Docs, Gmail, Sheets, and more. It excels at tasks involving Google''s ecosystem and offers strong image understanding capabilities.',
  pros = ARRAY['Free tier with generous limits', 'Deep Google Workspace integration', 'Strong multimodal capabilities', 'Real-time Google Search grounding'],
  cons = ARRAY['Weaker reasoning than Claude or GPT-4 on complex tasks', 'Workspace integration requires paid tier', 'Less consistent tone in creative writing'],
  use_cases = ARRAY['Google Workspace productivity', 'Research with web grounding', 'Image understanding', 'Summarizing emails and documents']
where slug = 'gemini';
