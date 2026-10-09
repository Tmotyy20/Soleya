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

## Déployer sur Cloudflare Workers

Depuis Astro 7 / `@astrojs/cloudflare` v14, le site se déploie comme un **Worker avec assets statiques**
(et non plus comme un projet Cloudflare Pages). L'adaptateur génère lui-même le point d'entrée et le binding `ASSETS`.

1. Workers & Pages → Create → **Import a repository** → ce repo. Build : `npm run build`, déploiement : `npx wrangler deploy`.
2. Variables : `PUBLIC_SUPABASE_URL`, `PUBLIC_SUPABASE_ANON_KEY` (au build), `CLOUDFLARE_DEPLOY_HOOK_URL` (secret du Worker).
3. `CLOUDFLARE_DEPLOY_HOOK_URL` : une URL qui relance un build quand la cliente modifie un contenu dans `/admin`.
   TODO : vérifier dans le tableau de bord si les deploy hooks sont disponibles pour Workers Builds ;
   sinon, utiliser un workflow GitHub Actions déclenché par `repository_dispatch`.

Test local du runtime Cloudflare : `npm run build && npm run preview`.

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
