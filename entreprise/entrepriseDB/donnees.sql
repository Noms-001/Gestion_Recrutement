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

