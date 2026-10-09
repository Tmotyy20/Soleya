#!/usr/bin/env node
// Génère supabase/seed.sql à partir de src/content/default-content.json.
// Usage : npm run seed:sql
import { readFile, writeFile } from "node:fs/promises";

const data = JSON.parse(
  await readFile(
    new URL("../src/content/default-content.json", import.meta.url),
    "utf8",
  ),
);
const q = (v) => (v == null ? "null" : `'${String(v).replaceAll("'", "''")}'`);

const rows = data.sections.map(
  (s, i) =>
    `  (${q(s.page)}, ${q(s.key)}, ${q(s.label)}, ${q(s.content)}, ${s.multiline ? "true" : "false"}, ${(i + 1) * 10})`,
);

const sql = `-- Fichier généré par scripts/generate-seed.mjs : ne pas modifier à la main.
-- Textes initiaux du site (issus de la maquette), modifiables ensuite depuis /admin.
insert into public.page_sections (page, key, label, content, multiline, position) values
${rows.join(",\n")}
on conflict (key) do nothing;

update public.site_settings set
  contact_email = coalesce(contact_email, ${q(data.settings.contact_email)}),
  instagram_handle = coalesce(instagram_handle, ${q(data.settings.instagram_handle)}),
  instagram_url = coalesce(instagram_url, ${q(data.settings.instagram_url)})
where id = 1;
`;

await writeFile(new URL("../supabase/seed.sql", import.meta.url), sql);
console.log(`supabase/seed.sql : ${rows.length} sections`);
