// Lecture des contenus au moment du build (pages publiques statiques).
// Sans Supabase configuré (ex. premier `npm run dev`), on retombe sur les textes par défaut.
import { createPublicClient } from "./supabase";
import { defaultPacks, defaultSections, defaultSettings } from "./defaults";
import type {
  ClientLogo,
  LogoType,
  Project,
  ServicePack,
  SiteSettings,
} from "./database.types";

export async function getSections(page?: string) {
  const sections: Record<string, string> = { ...defaultSections };
  const supabase = createPublicClient();
  if (!supabase) return sections;

  let query = supabase.from("page_sections").select("key, content");
  if (page) query = query.eq("page", page);
  const { data, error } = await query;
  if (error) throw new Error(`Supabase page_sections : ${error.message}`);
  for (const row of data) sections[row.key] = row.content;
  return sections;
}

export async function getFeaturedProjects(limit = 6): Promise<Project[]> {
  const supabase = createPublicClient();
  if (!supabase) return [];
  const { data, error } = await supabase
    .from("projects")
    .select("*")
    .eq("published", true)
    .order("featured", { ascending: false })
    .order("position")
    .limit(limit);
  if (error) throw new Error(`Supabase projects : ${error.message}`);
  return data;
}

export async function getClientLogos(type?: LogoType): Promise<ClientLogo[]> {
  const supabase = createPublicClient();
  if (!supabase) return [];
  let query = supabase.from("client_logos").select("*").eq("published", true);
  if (type) query = query.eq("type", type);
  const { data, error } = await query.order("position");
  if (error) throw new Error(`Supabase client_logos : ${error.message}`);
  return data;
}

export async function getSiteSettings(): Promise<Partial<SiteSettings>> {
  const supabase = createPublicClient();
  if (!supabase) return defaultSettings;
  const { data, error } = await supabase
    .from("site_settings")
    .select("*")
    .eq("id", 1)
    .maybeSingle();
  if (error) throw new Error(`Supabase site_settings : ${error.message}`);
  return data ?? defaultSettings;
}

export const categoryLabels: Record<Project["category"], string> = {
  identite_visuelle: "Identité visuelle",
  print: "Print",
  community_management: "Community management",
  ugc: "Création de contenu (UGC)",
  textile: "Création textiles",
};

export async function getPacks(service: string): Promise<ServicePack[]> {
  const supabase = createPublicClient();
  if (!supabase) return defaultPacks.filter((p) => p.service === service);
  const { data, error } = await supabase
    .from("service_packs")
    .select("*")
    .eq("service", service)
    .eq("published", true)
    .order("position");
  if (error) throw new Error(`Supabase service_packs : ${error.message}`);
  return data;
}
