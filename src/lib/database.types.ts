// Types écrits à la main à partir de supabase/migrations.
// À régénérer une fois le projet Supabase créé :
//   npx supabase gen types typescript --project-id <id> > src/lib/database.types.ts

export type ProjectCategory =
  "identite_visuelle" | "print" | "community_management" | "ugc" | "textile";
export type LogoType = "cm" | "ugc";

type Table<Row, Insert = Partial<Row>> = {
  Row: Row;
  Insert: Insert;
  Update: Partial<Row>;
  Relationships: [];
};

export type PageSection = {
  id: number;
  page: string;
  key: string;
  label: string;
  content: string;
  multiline: boolean;
  position: number;
  updated_at: string;
};

export type Project = {
  id: number;
  title: string;
  slug: string;
  category: ProjectCategory;
  client_name: string | null;
  description: string;
  cover_image: string | null;
  cover_alt: string;
  position: number;
  featured: boolean;
  published: boolean;
  created_at: string;
  updated_at: string;
};

export type ProjectImage = {
  id: number;
  project_id: number;
  image_path: string;
  alt: string;
  position: number;
};

export type ClientLogo = {
  id: number;
  name: string;
  type: LogoType;
  image_path: string;
  url: string | null;
  position: number;
  published: boolean;
  updated_at: string;
};

export type Post = {
  id: number;
  title: string;
  slug: string;
  excerpt: string;
  content: string;
  cover_image: string | null;
  cover_alt: string;
  published: boolean;
  published_at: string | null;
  created_at: string;
  updated_at: string;
};

export type SiteSettings = {
  id: 1;
  contact_email: string | null;
  phone: string | null;
  instagram_handle: string | null;
  instagram_url: string | null;
  linkedin_url: string | null;
  tiktok_url: string | null;
  updated_at: string;
};

export type ContactMessage = {
  id: number;
  last_name: string;
  first_name: string;
  email: string;
  phone: string | null;
  message: string;
  read: boolean;
  created_at: string;
};

export type PackTheme = "butter" | "brown" | "nebula";

export type ServicePack = {
  id: number;
  service: string;
  slug: string;
  name: string;
  price_eur: number | null;
  price_note: string;
  features: string[];
  highlighted: boolean;
  theme: PackTheme;
  position: number;
  published: boolean;
  updated_at: string;
};

export type Database = {
  public: {
    Tables: {
      admins: Table<{ user_id: string; created_at: string }>;
      page_sections: Table<PageSection>;
      projects: Table<Project>;
      project_images: Table<ProjectImage>;
      client_logos: Table<ClientLogo>;
      posts: Table<Post>;
      site_settings: Table<SiteSettings>;
      contact_messages: Table<ContactMessage>;
      service_packs: Table<ServicePack>;
    };
    Views: Record<string, never>;
    Functions: { is_admin: { Args: Record<string, never>; Returns: boolean } };
    Enums: { project_category: ProjectCategory; logo_type: LogoType };
    CompositeTypes: Record<string, never>;
  };
};
