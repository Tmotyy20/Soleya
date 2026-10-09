# Soleya : site vitrine + administration

Site vitrine de Soleya, activité freelance en **communication, marketing et création graphique**.
Objectifs : présenter les services, valoriser le portfolio, convertir les visiteurs en clients (prise de contact).
La cliente doit pouvoir **modifier elle-même** les contenus via une page `/admin`.

## Stack (validée)
- **Astro** + adaptateur **@astrojs/cloudflare**
  - Pages publiques **prérendues en statique** (`export const prerender = true`)
  - `/admin` et routes API rendues **côté serveur** (Cloudflare Workers)
- **Tailwind CSS** pour le style
- **Supabase** (offre gratuite)
  - Postgres : contenus du site
  - Auth : connexion de la cliente à `/admin` (email + mot de passe, pas d'inscription publique)
  - Storage : images du portfolio, logos, images d'articles
- **Cloudflare Pages** : hébergement + nom de domaine
- Îlots interactifs de l'admin : à choisir au moment du développement (React ou Svelte), seulement dans `/admin`

## Flux de publication
1. La cliente modifie un contenu dans `/admin`
2. Écriture dans Supabase
3. Appel du **deploy hook Cloudflare** : rebuild du site statique (environ 1 min)
4. Le site public est à jour

Pourquoi : performance et SEO maximum, et le site public **ne dépend pas de Supabase à l'exécution**. L'offre gratuite Supabase met en pause les projets inactifs, mais le site reste en ligne.

## Contenus éditables depuis /admin
- **Textes des pages** : accroches, services, à propos, coordonnées
- **Portfolio** : projets (titre, catégorie, description, images, ordre, publié/brouillon)
- **Logos clients** : community management et UGC (nom, image, ordre)
- **Blog / actualités** : articles (titre, slug, extrait, contenu riche, image de couverture, date, publié/brouillon)

## Sécurité
- **RLS activé sur toutes les tables** : lecture publique uniquement des contenus publiés ; écriture réservée aux utilisateurs authentifiés admin
- La clé `service_role` Supabase **ne doit jamais** aller côté client ni dans le repo
- Secrets en variables d'environnement (`.env` local ignoré par git, secrets Cloudflare en prod)
- `/admin` protégé par un middleware Astro qui vérifie la session Supabase
- Uploads : limiter les types (jpg, png, webp, svg exclu) et la taille

## Commandes
- `npm run dev` : serveur local
- `npm run build` : build de production
- `npm run preview` : prévisualiser le build (runtime Cloudflare)

## Identité visuelle

### Couleurs
| Token      | Nom           | Hex       | Usage                              |
|------------|---------------|-----------|------------------------------------|
| `brown`    | Dark Brown    | `#462E23` | Texte principal, logo, boutons     |
| `butter`   | Butter Yellow | `#FEF1B6` | Fonds de section, rayures          |
| `nebula`   | Nebula        | `#BFDDDC` | Fonds de section, rayures, accents |
| `seashell` | Seashell      | `#F1F1F1` | Fond principal                     |

Le texte est toujours en `brown` sur les fonds clairs. Jamais de texte blanc ou jaune sur `nebula` ou `butter`.

### Typographie (identifiée visuellement, à confirmer)
- Logotype "SOLEYA" : sans-serif géométrique, capitales très espacées (proche de **Montserrat**)
- Titres : serif élégante (proche de **Cormorant Garamond**)
- Texte courant : sans-serif (proche de **Poppins**)
- Polices auto-hébergées (`@fontsource`) : pas d'appel à Google Fonts (RGPD)

### Motifs et ambiance
- **Rayures verticales** alternées Nebula / Butter, façon parasol ou transat. C'est la signature de la marque, à faire en CSS (`repeating-linear-gradient`).
- Logo : soleil stylisé avec un "S" central. Version marron (fonds clairs), version bleu/jaune (fond marron).
- Ambiance : Méditerranée, été, rétro chic, lumineux, doux.
- L'admin reprend la charte, en plus sobre et fonctionnel.

## Arborescence du site public
1. **Accueil** : hero rayé + logo + accroche, aperçu des services, sélection de projets, bandeau logos clients, CTA contact
2. **Services** : Création graphique (logo, charte, affiches, flyers), Community management, UGC
3. **Portfolio** : grille filtrable (Identité visuelle, Print, Community management, UGC) + page détail projet
4. **Blog** : liste + page article
5. **À propos** : photo, parcours, valeurs
6. **Contact** : formulaire, coordonnées, réseaux sociaux
7. Mentions légales et politique de confidentialité (obligatoires)

## Assets initiaux
Source : dossier fourni par la cliente (affiches, chartes, logos clients CM, logos UGC, portrait).
Ils seront importés dans Supabase Storage via un script de seed. Seuls le logo Soleya et les éléments de charte restent dans le repo (`src/assets/brand/`).

## Conventions
- TypeScript strict
- Fichiers : minuscules, sans espaces ni accents, avec tirets
- Un composant par fichier, en PascalCase, dans `src/components/` (public) et `src/components/admin/` (admin)
- Images publiques via `astro:assets` quand c'est possible, toujours un `alt` descriptif (champ obligatoire dans l'admin)
- Couleurs et polices uniquement via les tokens Tailwind, jamais de hex en dur
- Mobile first ; accessibilité AA ; `prefers-reduced-motion` respecté
- Migrations SQL Supabase versionnées dans `supabase/migrations/`
- Commits courts en français : `feat: section hero accueil`

## À ne pas faire
- Ne pas changer de stack ni ajouter de dépendance lourde sans demander
- Ne jamais inventer de textes clients, témoignages ou chiffres : laisser un `TODO` visible
- Ne jamais committer de secret ou de fichier `.env`
