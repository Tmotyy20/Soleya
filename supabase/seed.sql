-- Fichier généré par scripts/generate-seed.mjs : ne pas modifier à la main.
-- Textes initiaux du site (issus de la maquette), modifiables ensuite depuis /admin.
insert into public.page_sections (page, key, label, content, multiline, position) values
  ('home', 'home.hero.title', 'Accueil · Titre principal', 'Freelance
communication
créative & stratégique', true, 10),
  ('home', 'home.hero.cta_primary', 'Accueil · Bouton principal', 'Discutons de votre projet', false, 20),
  ('home', 'home.hero.cta_secondary', 'Accueil · Bouton secondaire', 'Découvrir les projets', false, 30),
  ('home', 'home.services.title', 'Services · Titre', 'Ce que je propose', false, 40),
  ('home', 'home.services.subtitle', 'Services · Sous-titre', 'Une communication à 360° pour garantir une cohérence', false, 50),
  ('home', 'home.services.1', 'Services · Carte 1', 'Community management', false, 60),
  ('home', 'home.services.2', 'Services · Carte 2', 'Création textiles', false, 70),
  ('home', 'home.services.3', 'Services · Carte 3', 'Flyers,
affiches, cartes', true, 80),
  ('home', 'home.services.4', 'Services · Carte 4', 'Création contenu', false, 90),
  ('home', 'home.services.5', 'Services · Carte 5', 'Logo / charte graphique', false, 100),
  ('home', 'home.services.6', 'Services · Carte 6', 'Stratégie
marketing', true, 110),
  ('home', 'home.services.cta', 'Services · Bouton', 'Travaillons ensemble', false, 120),
  ('home', 'home.about.title', 'À propos · Titre', 'À propos de moi', false, 130),
  ('home', 'home.about.text', 'À propos · Texte', 'Derrière SOLEYA, c’est moi, Elsa. ☀️
Passionnée par la communication, la création de contenu et tout ce qui permet de donner vie à une idée, j’ai créé SOLEYA avec une envie simple : aider les marques et les entreprises à construire une communication qui leur ressemble.

J’ai une approche à la fois créative et stratégique : une belle image, c’est bien, mais une communication qui a du sens et qui parle vraiment à votre audience, c’est encore mieux.

Avec SOLEYA, je vous accompagne selon vos besoins, que vous ayez simplement besoin de quelques contenus, d’un coup de frais sur votre identité visuelle ou d’un accompagnement plus global sur votre communication.

Mon objectif ? Faire de votre communication un véritable reflet de votre projet : professionnelle, singulière et surtout, pleine de vie.
Alors, on fait rayonner votre projet ? ☀️', true, 140),
  ('home', 'home.about.cta', 'À propos · Bouton', 'En savoir plus sur moi', false, 150),
  ('home', 'home.projects.title', 'Projets · Titre', 'Mes projets', false, 160),
  ('home', 'home.projects.1', 'Projets · Carte 1', 'Community management', false, 170),
  ('home', 'home.projects.2', 'Projets · Carte 2', 'Création textiles', false, 180),
  ('home', 'home.projects.3', 'Projets · Carte 3', 'Logo / charte graphique', false, 190),
  ('home', 'home.values.title', 'Valeurs · Titre', 'Mes valeurs', false, 200),
  ('home', 'home.values.1', 'Valeurs · 1', 'Créativité & audace', false, 210),
  ('home', 'home.values.2', 'Valeurs · 2', 'Authenticité', false, 220),
  ('home', 'home.values.3', 'Valeurs · 3', 'Rigueur', false, 230),
  ('home', 'home.values.4', 'Valeurs · 4', 'Passion', false, 240),
  ('home', 'home.contact.title', 'Contact · Titre', 'Un projet en tête ?
Révélons ensemble votre potentiel', true, 250),
  ('home', 'home.contact.subtitle', 'Contact · Sous-titre', 'Envoyez-moi un message et voyons ensemble comment je peux vous aider', false, 260),
  ('community-management', 'cm.hero.title', 'Community management · Titre', 'Community management', false, 270),
  ('community-management', 'cm.intro.title', 'Community management · Titre « Qu''est-ce que c''est ? »', 'Qu’est-ce que c’est ?', false, 280),
  ('community-management', 'cm.intro.lead', 'Community management · Accroche', 'Le Community Management : le moteur de votre croissance en ligne', false, 290),
  ('community-management', 'cm.intro.text', 'Community management · Texte', 'Le community management ne se résume pas à publier des photos : c''est l''art de développer, d''animer et d''engager une communauté qualifiée autour de votre image de marque.

Aujourd''hui, une présence passive ne suffit plus. Intégrer une véritable stratégie digitale sur les réseaux sociaux (Instagram, LinkedIn, Facebook, TikTok) est devenu indispensable pour votre entreprise afin de :', true, 300),
  ('community-management', 'cm.intro.bullets', 'Community management · Liste (une ligne par point)', 'Booster votre visibilité en ligne : attirez l''attention de vos prospects là où ils passent le plus de temps.
Stimuler l''engagement client : créez un lien de confiance, répondez aux besoins de votre audience et humanisez votre entreprise.
Générer de la conversion et de la fidélisation : transformez vos simples abonnés en ambassadeurs et en clients fidèles.', true, 310),
  ('community-management', 'cm.intro.cta', 'Community management · Bouton', 'Discutons de votre projet', false, 320),
  ('community-management', 'cm.packs.title', 'Community management · Titre packs', 'Les différents packs', false, 330),
  ('community-management', 'cm.packs.cta', 'Community management · Bouton des packs', 'En savoir plus', false, 340),
  ('community-management', 'cm.clients.title', 'Community management · Titre clients', 'J’ai déjà géré les comptes de :', false, 350),
  ('community-management', 'cm.clients.note', 'Community management · Note à côté des logos', 'Il me reste de la
place pour vous', true, 360)
on conflict (key) do nothing;

update public.site_settings set
  contact_email = coalesce(contact_email, 'soleya-communication@gmail.com'),
  instagram_handle = coalesce(instagram_handle, 'soleya'),
  instagram_url = coalesce(instagram_url, 'https://www.instagram.com/soleya/')
where id = 1;

-- Packs tarifaires
insert into public.service_packs (service, slug, name, price_eur, price_note, features, highlighted, theme, position) values
  ('community-management', 'rayon-de-soleil', 'Pack Rayon de soleil', 450, 'par mois*', array['Création & publication de 1 post/semaine', 'Gestion de 1 réseau social (IG)', 'Reporting trimestriel simplifié', 'Audit initial unique', 'Conseil stratégique de base']::text[], false, 'butter', 10),
  ('community-management', 'plein-soleil', 'Pack Plein soleil', 700, 'par mois*', array['Création & publication de 3 posts/semaine', 'Gestion de 2 réseaux sociaux (FB, IG)', 'Reporting mensuel détaillé', 'Réponse aux commentaires', 'Audit initial mensuel', 'Stratégie de contenu personnalisée']::text[], true, 'brown', 20),
  ('community-management', 'eclipse', 'Pack Éclipse', 850, 'par mois*', array['Création & publication de 5 posts/semaine', 'Gestion de 3 réseaux sociaux (FB, IG, LinkedIn)', 'Reporting mensuel détaillé', 'Community management 7j/7', 'Stratégie multi-canaux']::text[], false, 'nebula', 30)
on conflict (service, slug) do nothing;
