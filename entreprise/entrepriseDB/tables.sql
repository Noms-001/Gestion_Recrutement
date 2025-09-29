CREATE TABLE utilisateur (
   id_utilisateur INT AUTO_INCREMENT,
   nom VARCHAR(255) NOT NULL,
   email VARCHAR(255) NOT NULL,
   mot_de_passe VARCHAR(255) NOT NULL,
   prenom VARCHAR(255) NOT NULL,
   PRIMARY KEY (id_utilisateur)
);

CREATE TABLE departement (
   id_departement INT AUTO_INCREMENT,
   nom VARCHAR(255) NOT NULL,
   PRIMARY KEY (id_departement)
);

CREATE TABLE ville (
   id_ville INT AUTO_INCREMENT,
   nom VARCHAR(255) NOT NULL,
   PRIMARY KEY (id_ville)
);

CREATE TABLE competence (
   id_competence INT AUTO_INCREMENT,
   libelle VARCHAR(255) NOT NULL,
   PRIMARY KEY (id_competence)
);

CREATE TABLE genre (
   id_genre INT AUTO_INCREMENT,
   libelle VARCHAR(255) NOT NULL,
   PRIMARY KEY (id_genre)
);

CREATE TABLE filiere (
   id_filiere INT AUTO_INCREMENT,
   libelle VARCHAR(255) NOT NULL,
   PRIMARY KEY (id_filiere)
);

CREATE TABLE candidat (
   id_candidat INT AUTO_INCREMENT,
   date_naissance DATE,
   photo VARCHAR(255),
   adresse VARCHAR(255),
   id_genre INT NOT NULL,
   id_ville INT NOT NULL,
   id_utilisateur INT NOT NULL,
   PRIMARY KEY (id_candidat),
   FOREIGN KEY (id_genre) REFERENCES genre(id_genre),
   FOREIGN KEY (id_ville) REFERENCES ville(id_ville),
   FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE test (
   id_test INT AUTO_INCREMENT,
   titre VARCHAR(255),
   temps TIME NOT NULL,
   score_min INT NOT NULL,
   PRIMARY KEY (id_test)
);

CREATE TABLE notification (
   id_notification INT AUTO_INCREMENT,
   message VARCHAR(255) NOT NULL,
   id_utilisateur INT NOT NULL,
   PRIMARY KEY (id_notification),
   FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE diplome (
   id_diplome INT AUTO_INCREMENT,
   libelle VARCHAR(255) NOT NULL,
   niveau DECIMAL(10,5) NOT NULL,
   PRIMARY KEY (id_diplome)
);

CREATE TABLE question (
   id_question INT AUTO_INCREMENT,
   enonce VARCHAR(255) NOT NULL,
   point INT NOT NULL,
   PRIMARY KEY (id_question)
);

CREATE TABLE experience (
   id_experience INT AUTO_INCREMENT,
   description VARCHAR(255),
   debut INT NOT NULL,
   fin INT NOT NULL,
   lieu VARCHAR(255),
   id_filiere INT NOT NULL,
   id_candidat INT NOT NULL,
   PRIMARY KEY (id_experience),
   FOREIGN KEY (id_filiere) REFERENCES filiere(id_filiere),
   FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
);

CREATE TABLE poste (
   id_poste INT AUTO_INCREMENT,
   libelle VARCHAR(255) NOT NULL,
   id_departement INT NOT NULL,
   PRIMARY KEY (id_poste),
   FOREIGN KEY (id_departement) REFERENCES departement(id_departement)
);

CREATE TABLE reponse (
   id_reponse INT AUTO_INCREMENT,
   valeur VARCHAR(255) NOT NULL,
   est_correct BOOLEAN,
   id_question INT NOT NULL,
   PRIMARY KEY (id_reponse),
   FOREIGN KEY (id_question) REFERENCES question(id_question)
);

CREATE TABLE annonce (
   id_annonce INT AUTO_INCREMENT,
   date_limite DATE NOT NULL,
   description VARCHAR(255),
   annee_experence INT,
   age INT,
   age_obligatoire BOOLEAN,
   diplome_obligatoire BOOLEAN,
   experience_obligatoire BOOLEAN,
   genre_obligatoire BOOLEAN,
   ville_obligatoire BOOLEAN,
   id_diplome INT,
   id_genre INT,
   id_ville INT,
   id_filiere INT NOT NULL,
   id_test INT NOT NULL,
   id_poste INT NOT NULL,
   PRIMARY KEY (id_annonce),
   UNIQUE (id_poste),
   FOREIGN KEY (id_diplome) REFERENCES diplome(id_diplome),
   FOREIGN KEY (id_genre) REFERENCES genre(id_genre),
   FOREIGN KEY (id_ville) REFERENCES ville(id_ville),
   FOREIGN KEY (id_filiere) REFERENCES filiere(id_filiere),
   FOREIGN KEY (id_test) REFERENCES test(id_test),
   FOREIGN KEY (id_poste) REFERENCES poste(id_poste)
);

CREATE TABLE candidat_essai (
   id_candidat_essai INT AUTO_INCREMENT,
   date_contrat DATE NOT NULL,
   duree INT NOT NULL,
   id_poste INT NOT NULL,
   id_candidat INT NOT NULL,
   PRIMARY KEY (id_candidat_essai),
   FOREIGN KEY (id_poste) REFERENCES poste(id_poste),
   FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
);

CREATE TABLE candidature (
   id_candidature INT AUTO_INCREMENT,
   id_annonce INT,
   id_candidat INT,
   date_candidature DATE NOT NULL,
   PRIMARY KEY (id_candidature),
   FOREIGN KEY (id_annonce) REFERENCES annonce(id_annonce),
   FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
);

CREATE TABLE employe (
   id_poste INT,
   id_utilisateur INT,
   id_employe INT AUTO_INCREMENT,
   PRIMARY KEY (id_employe),
   FOREIGN KEY (id_poste) REFERENCES poste(id_poste),
   FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE test_qcm (
   id_test INT,
   id_question INT,
   FOREIGN KEY (id_test) REFERENCES test(id_test),
   FOREIGN KEY (id_question) REFERENCES question(id_question)
);

CREATE TABLE education (
   id_filiere INT,
   id_candidat INT,
   id_diplome INT,
   annee_debut INT NOT NULL,
   annee_fin INT NOT NULL,
   lieu VARCHAR(255),
   FOREIGN KEY (id_filiere) REFERENCES filiere(id_filiere),
   FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat),
   FOREIGN KEY (id_diplome) REFERENCES diplome(id_diplome)
);

CREATE TABLE candidat_competence (
   id_competence INT,
   id_candidat INT,
   FOREIGN KEY (id_competence) REFERENCES competence(id_competence),
   FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
);

CREATE TABLE test_passage (
   id_candidat INT,
   id_test INT,
   date_passage DATE NOT NULL,
   PRIMARY KEY (id_candidat, id_test),
   FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat),
   FOREIGN KEY (id_test) REFERENCES test(id_test)
);

CREATE TABLE entretien (
   id_candidature INT,
   id_employe INT,
   date_entretien DATE NOT NULL,
   FOREIGN KEY (id_candidature) REFERENCES candidature(id_candidature),
   FOREIGN KEY (id_employe) REFERENCES employe(id_employe)
);

CREATE TABLE annonce_competence (
   id_competence INT,
   id_annonce INT,
   est_obligatoire BOOLEAN,
   FOREIGN KEY (id_competence) REFERENCES competence(id_competence),
   FOREIGN KEY (id_annonce) REFERENCES annonce(id_annonce)
);
