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

/** Logos CM embarqués dans le repo, utilisés seulement sans Supabase. */
export const defaultCmLogos = content.cm_logos;
