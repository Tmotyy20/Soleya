/// <reference types="astro/client" />

interface ImportMetaEnv {
  readonly PUBLIC_SUPABASE_URL: string;
  readonly PUBLIC_SUPABASE_ANON_KEY: string;
  readonly CLOUDFLARE_DEPLOY_HOOK_URL?: string;
}
interface ImportMeta {
  readonly env: ImportMetaEnv;
}

declare namespace App {
  interface Locals {
    supabase: import("@supabase/supabase-js").SupabaseClient<
      import("./lib/database.types").Database
    >;
    user: import("@supabase/supabase-js").User | null;
  }
}
