// Déclenche un rebuild Cloudflare Pages après une modification dans /admin.
// Le deploy hook se crée dans Cloudflare : Pages > soleya > Settings > Builds > Deploy hooks.
export async function triggerRebuild(
  env: { CLOUDFLARE_DEPLOY_HOOK_URL?: string } | undefined,
) {
  const hook =
    env?.CLOUDFLARE_DEPLOY_HOOK_URL ??
    import.meta.env.CLOUDFLARE_DEPLOY_HOOK_URL;
  if (!hook) {
    console.warn(
      "CLOUDFLARE_DEPLOY_HOOK_URL absent : pas de rebuild déclenché.",
    );
    return false;
  }
  const res = await fetch(hook, { method: "POST" });
  return res.ok;
}
