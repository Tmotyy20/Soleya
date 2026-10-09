// @ts-check
import { defineConfig } from "astro/config";
import cloudflare from "@astrojs/cloudflare";
import tailwindcss from "@tailwindcss/vite";

// Pages publiques prérendues (statiques). /admin et /api sont rendues à la demande.
export default defineConfig({
  site: "https://soleya.fr", // TODO: domaine définitif
  output: "static",
  // URLs sans barre finale (/services/creation-textile) servies sans redirection par Cloudflare
  trailingSlash: "never",
  build: { format: "file" },
  adapter: cloudflare({ imageService: "compile" }),
  // Pas de sessions Astro : l'admin utilise les cookies Supabase (évite un KV Cloudflare inutile)
  session: false,
  vite: { plugins: [tailwindcss()] },
});
