import { createClient } from "@supabase/supabase-js";
import { createServerClient, parseCookieHeader } from "@supabase/ssr";
import type { AstroCookies } from "astro";
import type { Database } from "./database.types";

const url = import.meta.env.PUBLIC_SUPABASE_URL;
const anonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

export const isSupabaseConfigured = Boolean(url && anonKey);

/** Client anonyme, utilisé au build pour générer les pages publiques. */
export function createPublicClient() {
  if (!isSupabaseConfigured) return null;
  return createClient<Database>(url, anonKey, {
    auth: { persistSession: false },
  });
}

/** Client lié à la session (cookies), utilisé dans /admin et /api. */
export function createSessionClient(request: Request, cookies: AstroCookies) {
  return createServerClient<Database>(url, anonKey, {
    cookies: {
      getAll() {
        return parseCookieHeader(request.headers.get("Cookie") ?? "").map(
          ({ name, value }) => ({
            name,
            value: value ?? "",
          }),
        );
      },
      setAll(toSet) {
        for (const { name, value, options } of toSet) {
          cookies.set(name, value, {
            ...options,
            path: "/",
            httpOnly: true,
            secure: true,
            sameSite: "lax",
          });
        }
      },
    },
  });
}

/** URL publique d'une image du bucket "media". */
export function mediaUrl(path: string | null | undefined) {
  if (!path || !url) return null;
  return `${url}/storage/v1/object/public/media/${path}`;
}
