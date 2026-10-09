import { defineMiddleware } from "astro:middleware";
import { createSessionClient, isSupabaseConfigured } from "./lib/supabase";

const PUBLIC_ADMIN_ROUTES = new Set(["/admin/login", "/api/admin/login"]);

export const onRequest = defineMiddleware(async (context, next) => {
  const { pathname } = context.url;
  const isAdminArea =
    pathname.startsWith("/admin") || pathname.startsWith("/api/admin");

  // Les pages publiques sont statiques : rien à faire.
  if (!isAdminArea) return next();

  if (!isSupabaseConfigured) {
    return new Response(
      "Administration indisponible : configurez Supabase dans .env (voir README).",
      {
        status: 503,
        headers: { "Content-Type": "text/plain; charset=utf-8" },
      },
    );
  }

  const supabase = createSessionClient(context.request, context.cookies);
  context.locals.supabase = supabase;

  // getUser() valide le jeton auprès de Supabase (contrairement à getSession()).
  const { data } = await supabase.auth.getUser();
  context.locals.user = data.user;

  if (PUBLIC_ADMIN_ROUTES.has(pathname)) return next();

  if (!data.user) {
    return pathname.startsWith("/api/")
      ? new Response("Non authentifié", { status: 401 })
      : context.redirect("/admin/login");
  }

  const { data: isAdmin } = await supabase.rpc("is_admin");
  if (!isAdmin) {
    await supabase.auth.signOut();
    return pathname.startsWith("/api/")
      ? new Response("Accès refusé", { status: 403 })
      : context.redirect("/admin/login?error=forbidden");
  }

  return next();
});
