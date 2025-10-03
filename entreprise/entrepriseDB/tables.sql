CREATE TABLE genre (
  id_genre INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE utilisateur (
  id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  id_genre INT NOT NULL,
  mot_de_passe VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE departement (
  id_departement INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ville (
  id_ville INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE competence (
  id_competence INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE filiere (
  id_filiere INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE diplome (
  id_diplome INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(255) NOT NULL,
  niveau DECIMAL(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE question (
  id_question INT AUTO_INCREMENT PRIMARY KEY,
  enonce TEXT NOT NULL,    
  point INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE test (
  id_test INT AUTO_INCREMENT PRIMARY KEY,
  titre VARCHAR(255),
  temps TIME,
  score_min INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE poste (
  id_poste INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(255) NOT NULL,
  id_departement INT NOT NULL,
  FOREIGN KEY (id_departement) REFERENCES departement(id_departement)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE reponse (
  id_reponse INT AUTO_INCREMENT PRIMARY KEY,
  valeur VARCHAR(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE question_reponse (
  id_question INT NOT NULL,
  id_reponse INT NOT NULL,
  est_correct BOOLEAN NOT NULL DEFAULT 0,
  FOREIGN KEY (id_question) REFERENCES question(id_question)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_reponse) REFERENCES reponse(id_reponse)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE candidat (
  id_candidat INT AUTO_INCREMENT PRIMARY KEY,
  date_naissance DATE,
  photo VARCHAR(255),
  adresse VARCHAR(255),
  telephone VARCHAR(255),
  id_ville INT,
  id_utilisateur INT NOT NULL UNIQUE,
  FOREIGN KEY (id_ville) REFERENCES ville(id_ville)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE experience (
  id_experience INT AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(1000),
  debut_mois INT NOT NULL,
  debut_annee INT NOT NULL,
  fin_mois INT NOT NULL,
  fin_annee INT NOT NULL,
  lieu VARCHAR(255),
  id_filiere INT NOT NULL,
  id_candidat INT NOT NULL,
  FOREIGN KEY (id_filiere) REFERENCES filiere(id_filiere)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE employe (
  id_employe INT AUTO_INCREMENT PRIMARY KEY,
  id_poste INT NOT NULL,
  id_utilisateur INT NOT NULL,
  date_embauche DATE DEFAULT NULL,
  FOREIGN KEY (id_poste) REFERENCES poste(id_poste)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE test_qcm (
  id_test INT NOT NULL,
  id_question INT NOT NULL,
  PRIMARY KEY (id_test, id_question),
  FOREIGN KEY (id_test) REFERENCES test(id_test)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_question) REFERENCES question(id_question)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE annonce (
  id_annonce INT AUTO_INCREMENT PRIMARY KEY,
  date_limite DATE NOT NULL, 
  date_creation DATE DEFAULT (CURRENT_DATE),
  urgent BOOLEAN,
  ferme BOOLEAN,
  description TEXT,
  annee_experience INT DEFAULT NULL,
  age INT DEFAULT NULL,
  age_obligatoire BOOLEAN NOT NULL DEFAULT 0,
  diplome_obligatoire BOOLEAN NOT NULL DEFAULT 0,
  experience_obligatoire BOOLEAN NOT NULL DEFAULT 0,
  genre_obligatoire BOOLEAN NOT NULL DEFAULT 0,
  ville_obligatoire BOOLEAN NOT NULL DEFAULT 0,
  id_diplome INT DEFAULT NULL,
  id_genre INT DEFAULT NULL,
  id_ville INT DEFAULT NULL,
  id_filiere INT NOT NULL,
  id_test INT NOT NULL,
  id_poste INT NOT NULL,
  INDEX (id_poste),
  INDEX (id_test),
  INDEX (id_filiere),
  FOREIGN KEY (id_diplome) REFERENCES diplome(id_diplome)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_genre) REFERENCES genre(id_genre)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_ville) REFERENCES ville(id_ville)
    ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (id_filiere) REFERENCES filiere(id_filiere)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_test) REFERENCES test(id_test)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_poste) REFERENCES poste(id_poste)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE candidat_essai (
  id_candidat_essai INT AUTO_INCREMENT PRIMARY KEY,
  date_contrat DATE NOT NULL,
  duree INT NOT NULL,
  id_poste INT NOT NULL,
  id_candidat INT NOT NULL,
  FOREIGN KEY (id_poste) REFERENCES poste(id_poste)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE (id_poste, id_candidat)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE candidature (
  id_candidature INT AUTO_INCREMENT PRIMARY KEY,
  id_annonce INT,
  id_candidat INT,
  date_candidature DATE NOT NULL,
  FOREIGN KEY (id_annonce) REFERENCES annonce(id_annonce)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE education (
  id_education INT AUTO_INCREMENT PRIMARY KEY,
  id_filiere INT NOT NULL,
  id_candidat INT NOT NULL,
  id_diplome INT NOT NULL,
  annee_debut YEAR NOT NULL,
  annee_fin YEAR NOT NULL,
  lieu VARCHAR(255),
  FOREIGN KEY (id_filiere) REFERENCES filiere(id_filiere)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_diplome) REFERENCES diplome(id_diplome)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Compétences du candidat (many-to-many) : PK composite
CREATE TABLE candidat_competence (
  id_candidat INT NOT NULL,
  id_competence INT NOT NULL,
  PRIMARY KEY (id_candidat, id_competence),
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_competence) REFERENCES competence(id_competence)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE test_passage (
  id_candidat INT NOT NULL,
  id_test INT NOT NULL,
  date_passage DATE NOT NULL,
  PRIMARY KEY (id_candidat, id_test),
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_test) REFERENCES test(id_test)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE entretien (
  id_entretien INT AUTO_INCREMENT PRIMARY KEY,
  id_candidature INT NOT NULL,
  id_employe INT NOT NULL,
  date_entretien DATE NOT NULL,
  compte_rendu TEXT,
  FOREIGN KEY (id_candidature) REFERENCES candidature(id_candidature)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_employe) REFERENCES employe(id_employe)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE annonce_competence (
  id_annonce INT NOT NULL,
  id_competence INT NOT NULL,
  est_obligatoire BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (id_annonce, id_competence),
  FOREIGN KEY (id_annonce) REFERENCES annonce(id_annonce)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_competence) REFERENCES competence(id_competence)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Notifications
CREATE TABLE notification (
  id_notification INT AUTO_INCREMENT PRIMARY KEY,
  message VARCHAR(255) NOT NULL,
  id_utilisateur INT NOT NULL,
  lu BOOLEAN,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE langue (
  id_langue INT AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE candidat_langue (
  id_candidat INT NOT NULL,
  id_langue INT NOT NULL,
  PRIMARY KEY (id_candidat, id_langue),
  FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_langue) REFERENCES langue(id_langue)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE annonce_langue (
  id_annonce INT NOT NULL,
  id_langue INT NOT NULL,
  est_obligatoire BOOLEAN,
  PRIMARY KEY (id_annonce, id_langue),
  FOREIGN KEY (id_annonce) REFERENCES annonce(id_annonce)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_langue) REFERENCES langue(id_langue)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
