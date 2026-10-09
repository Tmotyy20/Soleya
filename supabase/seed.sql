-- Textes initiaux des pages. Les contenus "TODO" sont à remplacer depuis /admin.
insert into public.page_sections (page, key, label, content, multiline, position) values
  ('home', 'home.hero.kicker',   'Accueil · sur-titre',      'Communication · Marketing · Création graphique', false, 10),
  ('home', 'home.hero.title',    'Accueil · titre principal', 'TODO : accroche principale', false, 20),
  ('home', 'home.hero.subtitle', 'Accueil · sous-titre',      'TODO : une phrase qui présente Soleya et ce qu''elle apporte à ses clients.', true, 30),
  ('home', 'home.hero.cta',      'Accueil · bouton',          'Démarrons un projet', false, 40),
  ('home', 'home.services.title','Accueil · titre services',  'Ce que je fais pour vous', false, 50),
  ('home', 'home.work.title',    'Accueil · titre projets',   'Projets récents', false, 60),
  ('home', 'home.clients.title', 'Accueil · titre clients',   'Elles et ils m''ont fait confiance', false, 70),
  ('home', 'home.cta.title',     'Accueil · titre appel final','Un projet en tête ?', false, 80),
  ('home', 'home.cta.text',      'Accueil · texte appel final','TODO : invitation à prendre contact.', true, 90),
  ('services', 'services.graphisme.title', 'Service 1 · titre', 'Création graphique', false, 10),
  ('services', 'services.graphisme.text',  'Service 1 · texte', 'TODO : logos, chartes graphiques, affiches, flyers…', true, 20),
  ('services', 'services.cm.title',        'Service 2 · titre', 'Community management', false, 30),
  ('services', 'services.cm.text',         'Service 2 · texte', 'TODO : gestion de vos réseaux sociaux, ligne éditoriale, contenus…', true, 40),
  ('services', 'services.ugc.title',       'Service 3 · titre', 'Création de contenu UGC', false, 50),
  ('services', 'services.ugc.text',        'Service 3 · texte', 'TODO : vidéos et photos authentiques pour les marques.', true, 60),
  ('about', 'about.title', 'À propos · titre', 'TODO : titre à propos', false, 10),
  ('about', 'about.text',  'À propos · texte', 'TODO : parcours, valeurs, façon de travailler.', true, 20)
on conflict (key) do nothing;
