-- Packs tarifaires affichés sur les pages de services (ex. community management).
create table public.service_packs (
  id bigint generated always as identity primary key,
  service text not null check (service ~ '^[a-z0-9]+(-[a-z0-9]+)*$'), -- slug de la page, ex. 'community-management'
  slug text not null check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  name text not null,
  price_eur int check (price_eur >= 0),
  price_note text not null default 'par mois',
  features text[] not null default '{}',
  highlighted boolean not null default false, -- pack mis en avant (carte centrale)
  theme text not null default 'butter' check (theme in ('butter', 'brown', 'nebula')),
  position int not null default 0,
  published boolean not null default true,
  updated_at timestamptz not null default now(),
  unique (service, slug)
);
create index on public.service_packs (service, position);

create trigger set_updated_at before update on public.service_packs
  for each row execute function public.set_updated_at();

alter table public.service_packs enable row level security;

create policy "public: packs publiés" on public.service_packs
  for select to anon, authenticated using (published or public.is_admin());
create policy "admin: écriture" on public.service_packs
  for all to authenticated using (public.is_admin()) with check (public.is_admin());
