// @ts-check
import { defineConfig } from "astro/config";
import cloudflare from "@astrojs/cloudflare";
import tailwindcss from "@tailwindcss/vite";

// Pages publiques prérendues (statiques). /admin et /api sont rendues à la demande.
export default defineConfig({
  site: "https://soleya.fr", // TODO: domaine définitif
  output: "static",
  adapter: cloudflare({ imageService: "compile" }),
  // Cast : @tailwindcss/vite embarque un Vite plus récent qu'Astro 5 (types incompatibles, runtime OK).
  vite: { plugins: [/** @type {any} */ (tailwindcss())] },
});
