# Soleya

Site vitrine de Soleya (communication, marketing, création graphique) avec une administration pour modifier les contenus.

**Stack :** Astro · Tailwind CSS · Supabase (Postgres, Auth, Storage) · Cloudflare Pages
Voir [`CLAUDE.md`](./CLAUDE.md) pour l'architecture, la charte et les conventions.

## Démarrer en local

```bash
npm install
cp .env.example .env   # renseigner les clés Supabase
npm run dev
```

Sans `.env`, le site démarre avec les textes par défaut (`src/lib/defaults.ts`) et sans projets.

## Mettre en place Supabase

1. Créer un projet sur [supabase.com](https://supabase.com) (région UE).
2. Appliquer le schéma : SQL Editor → coller `supabase/migrations/20261009000000_init.sql`, puis `supabase/seed.sql`.
   (ou avec la CLI : `npx supabase link` puis `npx supabase db push`)
3. Authentication → Providers : désactiver les inscriptions publiques (« Allow new users to sign up »).
4. Authentication → Users : créer le compte de la cliente, puis dans SQL Editor :
   ```sql
   insert into public.admins (user_id) select id from auth.users where email = 'email@cliente.fr';
   ```
5. Importer les images du dossier fourni :
   ```bash
   node --env-file=.env scripts/seed-media.mjs "/chemin/vers/Soleya/Dossier"
   ```

## Déployer sur Cloudflare Pages

1. Pages → Create → connecter le repo GitHub, preset **Astro**, build `npm run build`, output `dist`.
2. Variables : `PUBLIC_SUPABASE_URL`, `PUBLIC_SUPABASE_ANON_KEY`, `CLOUDFLARE_DEPLOY_HOOK_URL`.
3. Settings → Builds → **Deploy hooks** : créer un hook, coller son URL dans `CLOUDFLARE_DEPLOY_HOOK_URL`.
   Chaque modification dans `/admin` déclenche ce hook et le site est reconstruit (environ 1 min).

## Structure

```
src/
  pages/            pages publiques (statiques) + admin/ et api/ (rendues côté serveur)
  layouts/          BaseLayout (site) et AdminLayout
  components/       composants du site (admin/ pour l'administration)
  lib/              client Supabase, lecture des contenus, rebuild
  middleware.ts     protection de /admin
supabase/           migrations SQL + seed
scripts/            import des images dans Supabase
```
