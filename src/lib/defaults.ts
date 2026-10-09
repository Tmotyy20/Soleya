// Textes de repli quand Supabase n'est pas configuré (dev local sans .env).
// Source : src/content/default-content.json (même fichier que supabase/seed.sql).
import content from "@/content/default-content.json";
import type { SiteSettings } from "./database.types";

export const defaultSections: Record<string, string> = Object.fromEntries(
  content.sections.map((s) => [s.key, s.content]),
);

export const defaultSettings: Partial<SiteSettings> = content.settings;
