-- Soleya : schéma initial
-- Contenus éditables depuis /admin + RLS.
-- Lecture publique : uniquement les contenus publiés. Écriture : administrateurs uniquement.

-- ---------------------------------------------------------------------------
-- Administrateurs
-- ---------------------------------------------------------------------------
create table public.admins (
  user_id uuid primary key references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);
alter table public.admins enable row level security;

-- security definer : évite la récursion RLS lors de la vérification
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from public.admins where user_id = auth.uid());
$$;

create policy "admins: lecture de sa propre ligne"
  on public.admins for select
  to authenticated
  using (user_id = auth.uid());

-- ---------------------------------------------------------------------------
-- Utilitaires
-- ---------------------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create type public.project_category as enum (
  'identite_visuelle',
  'print',
  'community_management',
  'ugc',
  'textile'
);

create type public.logo_type as enum ('cm', 'ugc');

-- ---------------------------------------------------------------------------
-- Textes des pages (clé/valeur) : ex. key = 'home.hero.title'
-- ---------------------------------------------------------------------------
create table public.page_sections (
  id bigint generated always as identity primary key,
  page text not null,
  key text not null unique,
  label text not null,               -- libellé affiché dans l'admin
  content text not null default '',
  multiline boolean not null default false,
  position int not null default 0,
  updated_at timestamptz not null default now()
);
create index on public.page_sections (page, position);

-- ---------------------------------------------------------------------------
-- Portfolio
-- ---------------------------------------------------------------------------
create table public.projects (
  id bigint generated always as identity primary key,
  title text not null,
  slug text not null unique check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  category public.project_category not null,
  client_name text,
  description text not null default '',
  cover_image text,                  -- chemin dans le bucket "media"
  cover_alt text not null default '',
  position int not null default 0,
  featured boolean not null default false, -- affiché sur l'accueil
  published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index on public.projects (published, category, position);

create table public.project_images (
  id bigint generated always as identity primary key,
  project_id bigint not null references public.projects (id) on delete cascade,
  image_path text not null,
  alt text not null default '',
  position int not null default 0
);
create index on public.project_images (project_id, position);

-- ---------------------------------------------------------------------------
-- Logos clients
-- ---------------------------------------------------------------------------
create table public.client_logos (
  id bigint generated always as identity primary key,
  name text not null,
  type public.logo_type not null,
  image_path text not null,
  url text,
  position int not null default 0,
  published boolean not null default true,
  updated_at timestamptz not null default now()
);
create index on public.client_logos (type, position);

-- ---------------------------------------------------------------------------
-- Blog
-- ---------------------------------------------------------------------------
create table public.posts (
  id bigint generated always as identity primary key,
  title text not null,
  slug text not null unique check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  excerpt text not null default '',
  content text not null default '',   -- HTML assaini côté serveur avant enregistrement
  cover_image text,
  cover_alt text not null default '',
  published boolean not null default false,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index on public.posts (published, published_at desc);

-- ---------------------------------------------------------------------------
-- Réglages du site (une seule ligne)
-- ---------------------------------------------------------------------------
create table public.site_settings (
  id int primary key default 1 check (id = 1),
  contact_email text,
  phone text,
  instagram_handle text,
  instagram_url text,
  linkedin_url text,
  tiktok_url text,
  updated_at timestamptz not null default now()
);
insert into public.site_settings (id) values (1);

-- ---------------------------------------------------------------------------
-- Messages du formulaire de contact
-- ---------------------------------------------------------------------------
create table public.contact_messages (
  id bigint generated always as identity primary key,
  last_name text not null check (char_length(last_name) between 1 and 120),
  first_name text not null check (char_length(first_name) between 1 and 120),
  email text not null check (char_length(email) between 3 and 254 and email like '%@%'),
  phone text check (char_length(phone) <= 30),
  message text not null check (char_length(message) between 1 and 5000),
  read boolean not null default false,
  created_at timestamptz not null default now()
);
create index on public.contact_messages (created_at desc);

-- ---------------------------------------------------------------------------
-- Triggers updated_at
-- ---------------------------------------------------------------------------
create trigger set_updated_at before update on public.page_sections
  for each row execute function public.set_updated_at();
create trigger set_updated_at before update on public.projects
  for each row execute function public.set_updated_at();
create trigger set_updated_at before update on public.client_logos
  for each row execute function public.set_updated_at();
create trigger set_updated_at before update on public.posts
  for each row execute function public.set_updated_at();
create trigger set_updated_at before update on public.site_settings
  for each row execute function public.set_updated_at();

-- ---------------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------------
alter table public.page_sections    enable row level security;
alter table public.projects         enable row level security;
alter table public.project_images   enable row level security;
alter table public.client_logos     enable row level security;
alter table public.posts            enable row level security;
alter table public.site_settings    enable row level security;
alter table public.contact_messages enable row level security;

-- Lecture publique
create policy "public: lecture" on public.page_sections
  for select to anon, authenticated using (true);
create policy "public: lecture" on public.site_settings
  for select to anon, authenticated using (true);
create policy "public: projets publiés" on public.projects
  for select to anon, authenticated using (published or public.is_admin());
create policy "public: images des projets publiés" on public.project_images
  for select to anon, authenticated
  using (exists (
    select 1 from public.projects p
    where p.id = project_id and (p.published or public.is_admin())
  ));
create policy "public: logos publiés" on public.client_logos
  for select to anon, authenticated using (published or public.is_admin());
create policy "public: articles publiés" on public.posts
  for select to anon, authenticated
  using ((published and published_at <= now()) or public.is_admin());

-- Écriture admin
create policy "admin: écriture" on public.page_sections
  for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin: écriture" on public.site_settings
  for update to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin: écriture" on public.projects
  for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin: écriture" on public.project_images
  for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin: écriture" on public.client_logos
  for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin: écriture" on public.posts
  for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- Messages de contact : tout le monde peut écrire, seul l'admin lit / gère
create policy "public: envoi d'un message" on public.contact_messages
  for insert to anon, authenticated with check (read = false);
create policy "admin: lecture" on public.contact_messages
  for select to authenticated using (public.is_admin());
create policy "admin: mise à jour" on public.contact_messages
  for update to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "admin: suppression" on public.contact_messages
  for delete to authenticated using (public.is_admin());

-- ---------------------------------------------------------------------------
-- Storage : bucket public "media" (images), upload réservé à l'admin
-- ---------------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 5242880, array['image/jpeg', 'image/png', 'image/webp', 'image/avif'])
on conflict (id) do nothing;

create policy "media: upload admin" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'media' and public.is_admin());
create policy "media: modification admin" on storage.objects
  for update to authenticated
  using (bucket_id = 'media' and public.is_admin());
create policy "media: suppression admin" on storage.objects
  for delete to authenticated
  using (bucket_id = 'media' and public.is_admin());
