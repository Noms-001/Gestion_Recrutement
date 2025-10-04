-- =========================
-- Genres
-- =========================
INSERT INTO genre (libelle) VALUES
('Homme'),
('Femme'),
('Autre');

-- =========================
-- Utilisateurs (employés, candidats)
-- =========================
INSERT INTO utilisateur (nom, prenom, email, id_genre, mot_de_passe)
VALUES
('Durand', 'Paul', 'paul.durand@example.com', 1, 'pwd1'),
('Martin', 'Sophie', 'sophie.martin@example.com', 2, 'pwd2'),
('Nguyen', 'Alex', 'alex.nguyen@example.com', 3, 'pwd3'),
('Dupont', 'Claire', 'claire.dupont@example.com', 2, 'pwd4');

-- =========================
-- Départements
-- =========================
INSERT INTO departement (nom) VALUES
('Informatique'),
('Ressources Humaines'),
('Marketing'),
('Finance');

-- =========================
-- Postes
-- =========================
INSERT INTO poste (libelle, id_departement) VALUES
('Développeur Web', 1),
('Administrateur Systèmes', 1),
('Chargé de recrutement', 2),
('Contrôleur de gestion', 4);

-- =========================
-- Villes
-- =========================
INSERT INTO ville (nom) VALUES
('Paris'),
('Lyon'),
('Marseille'),
('Bordeaux');

-- =========================
-- Diplômes
-- =========================
INSERT INTO diplome (libelle, niveau) VALUES
('Licence Informatique', 3.00),
('Master Informatique', 5.00),
('MBA Management', 5.00),
('BTS Comptabilité', 2.00);

-- =========================
-- Filières
-- =========================
INSERT INTO filiere (libelle) VALUES
('Développement'),
('Réseaux & Systèmes'),
('Gestion'),
('Communication');

-- =========================
-- Compétences
-- =========================
INSERT INTO competence (libelle) VALUES
('Java'),
('SQL'),
('Communication'),
('Gestion de projet'),
('Linux'),
('Excel');

-- =========================
-- Candidats
-- =========================
INSERT INTO candidat (date_naissance, photo, adresse, telephone, id_ville, id_utilisateur)
VALUES
('1990-05-12', 'paul.jpg', '12 rue République, Paris', '0612345678', 1, 1),
('1995-11-03', 'sophie.jpg', '8 avenue Lumière, Lyon', '0698765432', 2, 2),
('1988-07-21', 'alex.jpg', '45 rue Nationale, Marseille', '0655443322', 3, 3);

-- =========================
-- Employés
-- =========================
INSERT INTO employe (id_poste, id_utilisateur, date_embauche)
VALUES
(3, 4, '2020-02-01'); -- Claire = Chargée de recrutement

-- =========================
-- Expériences
-- =========================
INSERT INTO experience (description, debut_mois, debut_annee, fin_mois, fin_annee, lieu, id_filiere, id_candidat)
VALUES
('Développeur backend chez TechCorp', 1, 2015, 6, 2018, 'Paris', 1, 1),
('Stage en RH chez HRPartners', 3, 2017, 8, 2017, 'Lyon', 3, 2),
('Administrateur systèmes freelance', 5, 2014, 12, 2019, 'Marseille', 2, 3);

-- =========================
-- Éducation
-- =========================
INSERT INTO education (id_filiere, id_candidat, id_diplome, annee_debut, annee_fin, lieu)
VALUES
(1, 1, 2, 2010, 2015, 'Université Paris-Saclay'),
(3, 2, 3, 2013, 2018, 'Université Lyon 3'),
(2, 3, 1, 2007, 2010, 'Université Aix-Marseille');

-- =========================
-- Candidat_Compétence
-- =========================
INSERT INTO candidat_competence (id_candidat, id_competence) VALUES
(1, 1), -- Paul connaît Java
(1, 2), -- Paul connaît SQL
(1, 4), -- Gestion projet
(2, 3), -- Sophie communication
(2, 4), -- Sophie gestion projet
(3, 5), -- Alex Linux
(3, 6); -- Alex Excel

-- =========================
-- Langues
-- =========================
INSERT INTO langue (libelle) VALUES
('Anglais'),
('Français'),
('Espagnol');

-- =========================
-- Candidat_Langue
-- =========================
INSERT INTO candidat_langue (id_candidat, id_langue) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 2),
(3, 3);

-- =========================
-- Tests
-- =========================
INSERT INTO test (titre, temps, score_min) VALUES
('Test Logique et Raisonnement', '00:30:00', 3),
('Test Connaissances en Informatique', '00:40:00', 3);

-- =========================
-- Questions du Test 1
-- =========================
INSERT INTO question (enonce, point) VALUES
('Si Pierre est plus grand que Marie, et Marie est plus grande que Paul, qui est le plus petit ?', 1),
('Quelle est la suite logique : 2, 4, 8, 16, ... ?', 1),
('Un train met 2h pour parcourir 120 km. Quelle est sa vitesse moyenne ?', 1),
('Dans un groupe de 5 personnes, chacun serre la main de tous les autres. Combien de poignées de main au total ?', 1),
('Si un carré a un périmètre de 20 cm, quelle est la longueur d''un côté ?', 1);

-- =========================
-- Réponses du Test 1
-- =========================
INSERT INTO reponse (valeur) VALUES
('Paul'), ('Marie'), ('Pierre'), ('Impossible à dire'), -- Q1
('24'), ('18'), ('32'), ('20'),                         -- Q2
('50 km/h'), ('60 km/h'), ('30 km/h'), ('80 km/h'),     -- Q3
('10'), ('12'), ('20'), ('15'),                         -- Q4
('4 cm'), ('5 cm'), ('10 cm'), ('20 cm');               -- Q5

-- =========================
-- Mapping Question -> Réponse (Test 1)
-- =========================
INSERT INTO question_reponse VALUES 
(1,1,1),(1,2,0),(1,3,0),(1,4,0),   -- Q1
(2,5,0),(2,6,0),(2,7,1),(2,8,0),   -- Q2
(3,9,0),(3,10,1),(3,11,0),(3,12,0),-- Q3
(4,13,1),(4,14,0),(4,15,0),(4,16,0),-- Q4
(5,17,0),(5,18,1),(5,19,0),(5,20,0);-- Q5

-- =========================
-- Associer les questions au Test 1
-- =========================
INSERT INTO test_qcm VALUES
(1,1),(1,2),(1,3),(1,4),(1,5);

-- =========================
-- Questions du Test 2
-- =========================
INSERT INTO question (enonce, point) VALUES
('Quel est le langage utilisé pour le développement Android natif ?', 1),
('Que signifie SQL ?', 1),
('Quelle est la complexité moyenne de recherche dans une table de hachage ?', 1),
('Quel protocole est utilisé pour sécuriser les communications sur le web ?', 1),
('Quelle est la valeur binaire de 5 en base 2 ?', 1);

-- =========================
-- Réponses du Test 2
-- =========================
INSERT INTO reponse (valeur) VALUES
('Java'), ('Python'), ('C++'), ('PHP'),                              -- Q6
('Structured Query Language'), ('System Question Logic'),
('Standard Query Level'), ('Simple Quick Language'),                 -- Q7
('O(1)'), ('O(n)'), ('O(log n)'), ('O(n log n)'),                    -- Q8
('HTTP'), ('HTTPS'), ('FTP'), ('SMTP'),                              -- Q9
('101'), ('111'), ('110'), ('100');                                  -- Q10

-- =========================
-- Mapping Question -> Réponse (Test 2)
-- =========================
INSERT INTO question_reponse VALUES 
(6,21,1),(6,22,0),(6,23,0),(6,24,0),  -- Q6
(7,25,1),(7,26,0),(7,27,0),(7,28,0),  -- Q7
(8,29,1),(8,30,0),(8,31,0),(8,32,0),  -- Q8
(9,33,0),(9,34,1),(9,35,0),(9,36,0),  -- Q9
(10,37,1),(10,38,0),(10,39,0),(10,40,0);-- Q10

-- =========================
-- Associer les questions au Test 2
-- =========================
INSERT INTO test_qcm VALUES
(2,6),(2,7),(2,8),(2,9),(2,10);

-- =========================
-- Annonces (2 seulement, liées aux tests)
-- =========================
INSERT INTO annonce 
(date_limite, urgent, ferme, description, annee_experience, age, 
 age_obligatoire, diplome_obligatoire, experience_obligatoire, genre_obligatoire, ville_obligatoire,
 id_diplome, id_genre, id_ville, id_filiere, id_test, id_poste)
VALUES
('2025-12-31', TRUE, FALSE, 'Recherche développeur web confirmé maîtrisant Java et SQL.', 
 3, NULL, 0, 1, 1, 0, 1, 2, NULL, 1, 1, 1, 1),  

('2025-11-30', FALSE, FALSE, 'Administrateur systèmes avec bonne maîtrise de Linux et sécurisation réseau.', 
 5, 28, 1, 1, 1, 0, 0, 1, NULL, 3, 2, 2, 2);

-- =========================
-- Annonce_Compétence (pour les 2 annonces)
-- =========================
INSERT INTO annonce_competence (id_annonce, id_competence, est_obligatoire) VALUES
(1, 1, TRUE),  -- Dév Web -> Java obligatoire
(1, 2, TRUE),  -- SQL obligatoire
(2, 5, TRUE),  -- Admin sys -> Linux obligatoire
(2, 6, FALSE); -- Excel apprécié

-- =========================
-- Annonce_Langue (pour les 2 annonces)
-- =========================
INSERT INTO annonce_langue (id_annonce, id_langue, est_obligatoire) VALUES
(1, 1, TRUE),  -- Dév Web -> anglais obligatoire
(2, 1, TRUE),  -- Admin sys -> anglais obligatoire
(2, 2, TRUE);  -- Admin sys -> français obligatoire