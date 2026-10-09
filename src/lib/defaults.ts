// Textes de repli quand Supabase n'est pas configuré (dev local sans .env).
// Source : src/content/default-content.json (même fichier que supabase/seed.sql).
import content from "@/content/default-content.json";
import type { ServicePack, SiteSettings } from "./database.types";

export const defaultSections: Record<string, string> = Object.fromEntries(
  content.sections.map((s) => [s.key, s.content]),
);

export const defaultSettings: Partial<SiteSettings> = content.settings;

export const defaultPacks: ServicePack[] = content.packs.map((p, i) => ({
  ...p,
  id: i + 1,
  theme: p.theme as ServicePack["theme"],
  position: i,
  published: true,
  updated_at: "",
}));

/** Logos clients embarqués dans le repo (src/assets/clients/<type>), utilisés sans Supabase. */
export const defaultLogos: Record<
  "cm" | "ugc",
  { file: string; name: string }[]
> = content.logos;

/** Visuels de projets embarqués (src/assets/gallery/), utilisés sans projets publiés. */
export const defaultGalleries: Record<
  "identite_visuelle" | "print",
  { file: string; title: string }[]
> = content.galleries;
