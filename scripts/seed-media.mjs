#!/usr/bin/env node
// Importe les images fournies par la cliente dans Supabase (Storage + tables).
//
// Usage :
//   node --env-file=.env scripts/seed-media.mjs "/chemin/vers/Soleya/Dossier"
//
// Nécessite SUPABASE_SERVICE_ROLE_KEY dans .env (jamais committé).
// Idempotent : les fichiers existants sont écrasés, les lignes existantes (même slug / même chemin) ignorées.
// Les projets sont importés en BROUILLON : la cliente les relit et les publie depuis /admin.

import { readFile } from "node:fs/promises";
import { join, extname } from "node:path";
import { createClient } from "@supabase/supabase-js";

const root = process.argv[2];
const url = process.env.PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!root || !url || !key) {
  console.error(
    'Usage : node --env-file=.env scripts/seed-media.mjs "/chemin/vers/Dossier"',
  );
  console.error(
    "Variables requises : PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY",
  );
  process.exit(1);
}
const supabase = createClient(url, key, { auth: { persistSession: false } });

// [fichier source, slug, titre, catégorie]
const projects = [
  [
    "affiche /affiche 2.png",
    "affiche-cours-gratuit",
    "Affiche cours gratuit",
    "print",
  ],
  [
    "affiche /affiche sport.png",
    "affiche-en-famille",
    "Affiche « En famille avec nos coachs »",
    "print",
  ],
  [
    "affiche /affiche armissan.png",
    "affiche-armissan",
    "Affiche fête locale d'Armissan",
    "print",
  ],
  [
    "affiche /affiche darnis.png",
    "affiche-laetitia-darnis",
    "Affiche Laetitia Darnis",
    "print",
  ],
  ["affiche /affiche moveen.png", "affiche-moveen", "Affiche Moveen", "print"],
  [
    "affiche /affiche sampietro.png",
    "affiche-maison-sampietro",
    "Affiche Maison Sampietro",
    "print",
  ],
  [
    "affiche /affiche tcrigraphie.png",
    "affiche-tcrigraphie",
    "Affiche Tcrigraphie",
    "print",
  ],
  [
    "affiche /design oca.png",
    "design-origin-creative-agency",
    "Origin Creative Agency",
    "print",
  ],
  [
    "affiche /flyer utx.png",
    "flyer-under-the-wave",
    "Flyer Under The Wave",
    "print",
  ],
  [
    "affiche /flyers utw 2.png",
    "flyer-under-the-wave-tropicale",
    "Flyer Under The Wave · Tropicale collection",
    "print",
  ],
  [
    "logo : charte/charte graphique moveen.png",
    "charte-moveen",
    "Charte graphique Moveen",
    "identite_visuelle",
  ],
  [
    "logo : charte/charte graphique don du sang.png",
    "charte-don-du-sang",
    "Charte graphique Don du sang",
    "identite_visuelle",
  ],
  [
    "logo : charte/logo horizon visuel.png",
    "logo-horizon-visuel",
    "Logo Horizon Visuel",
    "identite_visuelle",
  ],
  [
    "logo : charte/logo moveen.png",
    "logo-moveen",
    "Logo Moveen",
    "identite_visuelle",
  ],
];

// [fichier source, nom affiché, type]
const logos = [
  ["logo client cm/bistro serano.png", "Bistro Serano", "cm"],
  ["logo client cm/gbr.png", "Gruissan Beach Rugby", "cm"],
  ["logo client cm/gruissan tourisme.png", "Gruissan Tourisme", "cm"],
  ["logo client cm/l'houstalet.png", "L'Houstalet", "cm"],
  ["logo client cm/le versant.png", "Le Versant", "cm"],
  ["logo client cm/maison sampietro.png", "Maison Sampietro", "cm"],
  ["logo client cm/opaisible.png", "Ô Paisible", "cm"],
  ["logo client cm/thebeauty.png", "The Beauty", "cm"],
  ["logo client cm/tipolino.png", "Tipolino", "cm"],
  ["logo client cm/underthewave.png", "Under The Wave", "cm"],
  ["logo UGC/armany beauty.png", "Armani beauty", "ugc"],
  ["logo UGC/azzaro.png", "Azzaro", "ugc"],
  ["logo UGC/benefit.png", "Benefit", "ugc"],
  ["logo UGC/biotherm.png", "Biotherm", "ugc"],
  ["logo UGC/cacharel.png", "Cacharel", "ugc"],
  ["logo UGC/emma.png", "Emma", "ugc"],
  ["logo UGC/it cosmetics.png", "IT Cosmetics", "ugc"],
  ["logo UGC/kerastase.png", "Kérastase", "ugc"],
  ["logo UGC/l'oreal.png", "L'Oréal Paris", "ugc"],
  ["logo UGC/lancôme.png", "Lancôme", "ugc"],
  ["logo UGC/larocheposay.png", "La Roche-Posay", "ugc"],
  ["logo UGC/luxeol.png", "Luxéol", "ugc"],
  ["logo UGC/maybelline.png", "Maybelline New York", "ugc"],
  ["logo UGC/mixa.png", "Mixa", "ugc"],
  ["logo UGC/mugler.png", "Mugler", "ugc"],
  ["logo UGC/nyx.png", "NYX Professional Makeup", "ugc"],
  ["logo UGC/prada.png", "Prada", "ugc"],
  ["logo UGC/redken.png", "Redken", "ugc"],
  ["logo UGC/respire.png", "Respire", "ugc"],
  ["logo UGC/vivhy.png", "Vichy", "ugc"],
];

const slugify = (s) =>
  s
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");

const mime = {
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".webp": "image/webp",
};

async function upload(src, dest) {
  const body = await readFile(join(root, src));
  const contentType = mime[extname(src).toLowerCase()];
  const { error } = await supabase.storage
    .from("media")
    .upload(dest, body, { contentType, upsert: true });
  if (error) throw new Error(`${src} → ${dest} : ${error.message}`);
  return dest;
}

let position = 0;
for (const [src, slug, title, category] of projects) {
  const path = await upload(
    src,
    `projects/${slug}${extname(src).toLowerCase()}`,
  );
  const { error } = await supabase
    .from("projects")
    .upsert(
      {
        slug,
        title,
        category,
        cover_image: path,
        cover_alt: title,
        position: position++,
        published: false,
      },
      { onConflict: "slug", ignoreDuplicates: true },
    );
  if (error) throw error;
  console.log("projet", slug);
}

position = 0;
for (const [src, name, type] of logos) {
  const path = `logos/${type}/${slugify(name)}${extname(src).toLowerCase()}`;
  await upload(src, path);
  const { data: existing } = await supabase
    .from("client_logos")
    .select("id")
    .eq("image_path", path)
    .maybeSingle();
  if (!existing) {
    const { error } = await supabase
      .from("client_logos")
      .insert({ name, type, image_path: path, position: position });
    if (error) throw error;
  }
  position++;
  console.log("logo", name);
}

console.log("\nTerminé. Relisez et publiez les projets depuis /admin/projets.");
