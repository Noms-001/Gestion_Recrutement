-- Genres
INSERT INTO genre (libelle)
VALUES ('Homme'), ('Femme');-- Utilisateurs

INSERT INTO utilisateur (nom, prenom, email, id_genre, mot_de_passe)
VALUES 
('Rakoto', 'Jean', 'jean.rakoto@example.com', 1, 'pwd123'),
('Randria', 'Marie', 'marie.randria@example.com', 2, 'pwd456'),
('Rabe', 'Paul', 'paul.rabe@example.com', 1, 'pwd789');

-- Villes
INSERT INTO ville (nom)
VALUES ('Antananarivo'), ('Toamasina'), ('Fianarantsoa');

-- Départements
INSERT INTO departement (nom)
VALUES ('Informatique'), ('Ressources Humaines');

-- Postes
INSERT INTO poste (libelle, id_departement)
VALUES ('Développeur Java', 1),
       ('Recruteur RH', 2);

-- Diplômes
INSERT INTO diplome (libelle, niveau)
VALUES ('Licence', 3.0),
       ('Master', 5.0);

-- Filières
INSERT INTO filiere (libelle)
VALUES ('Informatique'), ('Gestion');

-- Compétences
INSERT INTO competence (libelle)
VALUES ('Java'), ('Spring Boot'), ('Communication'), ('Comptabilité');

-- Langues
INSERT INTO langue (libelle)
VALUES ('Francais'), ('Espagnol'), ('Anglais');

-- Candidats
INSERT INTO candidat (date_naissance, photo, adresse, telephone, id_ville, id_utilisateur)
VALUES 
('2000-05-12', 'photo1.jpg',  'Andoharanofotsy', '0334050003', 1, 1),
('1998-09-20', 'photo2.jpg',  'Toamasina Centre', '0345577156', 2, 2);

-- Expériences
INSERT INTO experience (description, debut_mois, debut_annee, fin_mois, fin_annee, lieu, id_filiere, id_candidat)
VALUES 
('Stage en développement', 1, 2019, 1, 2020, 'Antananarivo', 1, 1),
('Assistante RH', 1, 2020, 1, 2022, 'Toamasina', 2, 2);

-- Tests
INSERT INTO test (titre, temps, score_min)
VALUES 
('Test Java', '01:00:00', 50),
('Test RH', '00:45:00', 40);

-- Questions
INSERT INTO question (enonce, point)
VALUES 
('Qu''est-ce qu''une classe en Java ?', 10),
('Définir le rôle d''un recruteur', 5);

-- Réponses
INSERT INTO reponse (valeur, est_correct, id_question)
VALUES 
('Une structure définissant objets', TRUE, 1),
('Une personne qui embauche', TRUE, 2);

-- Annonce
INSERT INTO annonce (date_limite, description, annee_experience, age, age_obligatoire, diplome_obligatoire, experience_obligatoire, genre_obligatoire, ville_obligatoire, id_diplome, id_genre, id_ville, id_filiere, id_test, id_poste)
VALUES 
('2025-12-31', 'Recherche Développeur Java confirmé', 2, 30, TRUE, TRUE, TRUE, FALSE, FALSE, 1, NULL, 1, 1, 1, 1),
('2025-06-30', 'Besoin de Recruteur RH junior', 1, NULL, FALSE, FALSE, TRUE, FALSE, FALSE, 2, 2, 2, 2, 2, 2);

-- Candidature
INSERT INTO candidature (id_annonce, id_candidat, date_candidature)
VALUES 
(1, 1, '2025-01-10'),
(2, 2, '2025-01-15');

