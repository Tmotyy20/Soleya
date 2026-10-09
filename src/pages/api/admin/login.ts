import type { APIRoute } from "astro";

export const prerender = false;

export const POST: APIRoute = async ({ request, locals, redirect }) => {
  const form = await request.formData();
  const email = String(form.get("email") ?? "").trim();
  const password = String(form.get("password") ?? "");
  if (!email || !password) return redirect("/admin/login?error=missing", 303);

  const { error } = await locals.supabase.auth.signInWithPassword({
    email,
    password,
  });
  if (error) return redirect("/admin/login?error=invalid", 303);

  // Le middleware vérifiera le rôle admin à la requête suivante.
  return redirect("/admin", 303);
};
