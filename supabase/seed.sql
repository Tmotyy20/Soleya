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
place pour vous', true, 360),
  ('creation-textile', 'tx.hero.title', 'Création textile · Titre', 'Création textile', false, 370),
  ('creation-textile', 'tx.intro.title', 'Création textile · Titre « Qu''est-ce que c''est ? »', 'Qu’est-ce que c’est ?', false, 380),
  ('creation-textile', 'tx.intro.text', 'Création textile · Texte', 'Vous souhaitez marquer les esprits lors de votre prochain salon, lancer une collection capsule ou simplement fédérer votre équipe ? La création textile est un atout redoutable et tangible pour diffuser votre image de marque.

Je vous accompagne dans la création de vos vêtements professionnels personnalisés (t-shirts, sweats, tote bags) pour tous vos événements d''entreprise ou vos besoins en goodies :', true, 390),
  ('creation-textile', 'tx.intro.bullets', 'Création textile · Liste (une ligne par point)', 'Design de t-shirt sur-mesure : je conçois des visuels uniques, modernes et parfaitement alignés avec votre identité visuelle.
Accompagnement à la production : fini le casse-tête logistique. Une fois le design validé, je vous confie mes meilleurs contacts de fournisseurs textiles et d''imprimeurs de confiance pour lancer la fabrication en toute sérénité.', true, 400),
  ('creation-textile', 'tx.intro.cta', 'Création textile · Bouton', 'Discutons de votre projet', false, 410),
  ('creation-textile', 'tx.visual.text', 'Création textile · Texte sur le t-shirt', 'Votre
logo', true, 420),
  ('logo-charte-graphique', 'lg.hero.title', 'Logo & charte · Titre', 'Logo & charte graphique', false, 430),
  ('logo-charte-graphique', 'lg.intro.title', 'Logo & charte · Titre « À quoi ça sert ? »', 'À quoi ça sert ?', false, 440),
  ('logo-charte-graphique', 'lg.intro.text', 'Logo & charte · Texte', 'Logo & charte graphique : marquer les esprits et inspirer confiance
Ton identité visuelle est le premier levier de crédibilité de ton projet. Une charte graphique bien pensée pose des fondations solides :', true, 450),
  ('logo-charte-graphique', 'lg.intro.bullets', 'Logo & charte · Liste (une ligne par point)', 'Image pro : tu inspires immédiatement confiance à tes prospects.
Impact visuel : tu te démarques nettement de tes concurrents.
Cohérence : un univers harmonieux sur tous tes supports (web, print, réseaux).', true, 460),
  ('logo-charte-graphique', 'lg.intro.outro', 'Logo & charte · Conclusion', 'Je conçois pour vous un univers sur-mesure et stratégique, pensé pour captiver vos clients et valoriser votre offre.', true, 470),
  ('logo-charte-graphique', 'lg.intro.cta', 'Logo & charte · Bouton', 'Discutons de votre projet', false, 480),
  ('logo-charte-graphique', 'lg.gallery.title', 'Logo & charte · Titre galerie', 'Quelques projets', false, 490),
  ('logo-charte-graphique', 'lg.gallery.subtitle', 'Logo & charte · Sous-titre galerie', 'Certains sont fictifs et viennent de projets d''école*', false, 500),
  ('creation-contenu-ugc', 'ugc.hero.title', 'UGC · Titre', 'Création de contenu
UGC', true, 510),
  ('creation-contenu-ugc', 'ugc.intro.title', 'UGC · Titre « Qu''est-ce que c''est ? »', 'Qu’est-ce que c’est ?', false, 520),
  ('creation-contenu-ugc', 'ugc.intro.text', 'UGC · Texte', 'Le contenu UGC (User-Generated Content) désigne des visuels et vidéos créés dans un style spontané, naturel et immersif, à l''image des publications de vrais utilisateurs. Loin des publicités traditionnelles très léchées et parfois perçues comme impersonnelles, l''UGC mise sur la preuve sociale et la sincérité.

Voici pourquoi ce format est devenu un levier majeur dans une stratégie digitale :', true, 530),
  ('creation-contenu-ugc', 'ugc.intro.bullets', 'UGC · Liste (une ligne par point)', 'Inspirer une confiance immédiate : vos prospects s''identifient bien plus facilement à une démonstration concrète et humaine qu''à un discours commercial classique.
Capter l''attention sur les réseaux : taillés pour les formats verticaux (Instagram Reels, TikTok, Shorts), ces contenus courts et dynamiques stoppent le scroll dès les premières secondes.
Booster les conversions : intégré dans vos campagnes publicitaires (Meta Ads, TikTok Ads) ou sur vos fiches produits, l''UGC lève les freins à l''achat et améliore nettement votre rendement.', true, 540),
  ('creation-contenu-ugc', 'ugc.intro.cta', 'UGC · Bouton', 'Discutons de votre projet', false, 550),
  ('creation-contenu-ugc', 'ugc.clients.title', 'UGC · Titre marques', 'J’ai déjà créé du contenu pour :', false, 560),
  ('creation-contenu-ugc', 'ugc.clients.note', 'UGC · Note à côté des logos', 'Il me reste de la
place pour vous', true, 570),
  ('flyers-affiches', 'fl.hero.title', 'Flyers · Titre', 'Flyers & affiches', false, 580),
  ('flyers-affiches', 'fl.intro.title', 'Flyers · Titre « Quel est l''intérêt ? »', 'Quel est l’intérêt ?', false, 590),
  ('flyers-affiches', 'fl.intro.text', 'Flyers · Texte', 'À l''ère du tout-numérique, on sous-estime souvent la puissance d''un flyer bien pensé ou d''une affiche percutante. Pourtant, pour promouvoir un événement, le support physique offre une présence concrète que le web ne peut pas remplacer à lui seul.

Voici ce qu''une création print apporte à votre stratégie :', true, 600),
  ('flyers-affiches', 'fl.intro.bullets', 'Flyers · Liste (une ligne par point)', 'Ancrage local et visibilité directe : vous touchez votre cible là où elle vit et se déplace. Une affiche bien conçue attire l''œil instantanément dans l''espace public ou chez les commerçants partenaires.
Impact mémoriel et toucher : un support physique crée un lien émotionnel plus fort qu''une simple publication éphémère. Un bel imprimé ne se scrolle pas : il se garde, se transmet et reste sous les yeux.
Passerelle vers le digital : en y intégrant un QR code ou un lien court, votre flyer devient le pont parfait entre le monde réel et vos réseaux sociaux, votre billetterie ou votre site web.', true, 610),
  ('flyers-affiches', 'fl.intro.outro', 'Flyers · Conclusion', 'Associer le print au digital, c''est doubler vos chances de capter l''attention et de marquer durablement les esprits.', true, 620),
  ('flyers-affiches', 'fl.intro.cta', 'Flyers · Bouton', 'Discutons de votre projet', false, 630),
  ('flyers-affiches', 'fl.gallery.title', 'Flyers · Titre galerie', 'Quelques réalisations', false, 640)
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
