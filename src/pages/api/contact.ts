import type { APIRoute } from "astro";
import { createPublicClient } from "@/lib/supabase";

export const prerender = false;

const back = (status: string) => `/?contact=${status}#contact`;

export const POST: APIRoute = async ({ request, redirect }) => {
  const form = await request.formData();
  const get = (k: string) => String(form.get(k) ?? "").trim();

  // Piège à robots rempli : on fait comme si tout allait bien.
  if (get("website")) return redirect(back("ok"), 303);

  const message = {
    last_name: get("last_name"),
    first_name: get("first_name"),
    email: get("email"),
    phone: get("phone") || null,
    message: get("message"),
  };

  const valid =
    message.last_name.length > 0 &&
    message.last_name.length <= 120 &&
    message.first_name.length > 0 &&
    message.first_name.length <= 120 &&
    /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(message.email) &&
    message.email.length <= 254 &&
    (message.phone ?? "").length <= 30 &&
    message.message.length > 0 &&
    message.message.length <= 5000;
  if (!valid) return redirect(back("invalid"), 303);

  const supabase = createPublicClient();
  if (!supabase) return redirect(back("error"), 303);

  const { error } = await supabase.from("contact_messages").insert(message);
  if (error) {
    console.error("contact_messages insert", error.message);
    return redirect(back("error"), 303);
  }
  return redirect(back("ok"), 303);
};
