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
| Token         | Nom           | Hex       | Usage                                      |
|---------------|---------------|-----------|--------------------------------------------|
| `brown`       | Dark Brown    | `#462E23` | Texte principal, header, boutons           |
| `brown-light` | (maquette)    | `#745144` | Cartes secondaires, survols                |
| `butter`      | Butter Yellow | `#FEF1B6` | Rayures, boutons secondaires, footer       |
| `nebula`      | Nebula        | `#BFDDDC` | Rayures, fonds de section                  |
| `seashell`    | Seashell      | `#F1F1F1` | Fonds de cartes photo                      |
| `cream`       | (maquette)    | `#FCFDF6` | Fond principal, cartes, formulaires        |

Contraste : la maquette met du texte blanc sur `nebula` (titre « Ce que je propose », coordonnées). Ce contraste est insuffisant (AA non atteint) : à valider avec la cliente.

### Typographie (confirmée)
- **Titres** : Montserrat **Bold**, en **majuscules** (utilitaire `title`)
- **Textes** : Poppins Regular
- Logotype "SOLEYA" du header : image (`src/assets/brand/logotype-soleya.png`)
- Polices auto-hébergées (`@fontsource`) : pas d'appel à Google Fonts (RGPD)

### Motifs et ambiance
- **Rayures verticales** alternées Nebula / Butter (utilitaire `stripes`), largeur calée sur la maquette (152 px pour 1366 px, soit ~11,1vw)
- Boutons en pilule (utilitaire `btn`), cartes arrondies (`--radius-card`)
- Logo : soleil stylisé avec un "S" central. Version marron (fonds clairs), version bleu/jaune (header marron)
- Ambiance : Méditerranée, été, rétro chic, lumineux, doux
- L'admin reprend la charte, en plus sobre et fonctionnel

### Maquettes
- Accueil : `design/maquette-accueil.png` (référence pour toute modification de la page d'accueil)

## Arborescence du site public
Navigation (maquette) : Accueil · À propos · Projets · Contact

1. **Accueil** (fait) : hero rayé, « Ce que je propose » (6 services), à propos, mes projets, mes valeurs, formulaire de contact
2. **À propos** (`/a-propos`) : page détaillée (lien « En savoir plus sur moi »)
3. **Projets** (`/projets`) : grille filtrable (Identité visuelle, Print, Community management, Création de contenu, Création textiles) + page détail projet
4. **Blog** : liste + page article (pas encore dans la navigation de la maquette)
5. **Contact** : section en bas de l'accueil (`/#contact`) ; les messages sont enregistrés dans `contact_messages`
6. Mentions légales et politique de confidentialité (obligatoires, liens dans le footer)

Textes de l'accueil : clés `home.*` de `page_sections`. Source unique des valeurs par défaut : `src/content/default-content.json` ; régénérer `supabase/seed.sql` avec `npm run seed:sql` après modification.

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
