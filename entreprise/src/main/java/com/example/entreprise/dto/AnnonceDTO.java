// src/main/java/com/example/entreprise/dto/AnnonceDTO.java
package com.example.entreprise.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import com.example.entreprise.entity.Annonce;

public class AnnonceDTO {
    public Long id;
    public String posteLibelle;
    public String filiereLibelle;
    public Long filiereId;
    public Long diplomeId;
    public String departementNom;
    public Long departementId;
    public String villeNom;
    public Long villeId;
    public Long genreId;
    public String description;
    public Boolean ferme;
    public LocalDate dateLimite;
    public Integer anneeExperience;
    public Long testId;
    public int candidaturesCount;
    public LocalDate dateCreation;
    public List<String> competences;
    public List<String> langues;

    // Critères obligatoires
    public Boolean diplomeObligatoire;
    public String diplomeLibelle;
    public Double diplomeNiveau;

    public Boolean ageObligatoire;
    public Integer ageMinimum;

    public Boolean experienceObligatoire;

    public Boolean genreObligatoire;
    public String genreLibelle;

    public Boolean villeObligatoire;
    public Boolean urgent;

    // Compétences et langues obligatoires
    public List<String> competencesObligatoires;
    public List<String> languesObligatoires;

    // 🔹 Constructeur par défaut
    public AnnonceDTO() {}

    // 🔹 Constructeur avec entité Annonce
    public AnnonceDTO(Annonce annonce) {
        this.id = annonce.getId();
        this.posteLibelle = annonce.getPoste() != null ? annonce.getPoste().getLibelle() : null;
        this.departementNom = annonce.getPoste() != null && annonce.getPoste().getDepartement() != null 
                ? annonce.getPoste().getDepartement().getNom() : null;
        this.departementId = annonce.getPoste() != null && annonce.getPoste().getDepartement() != null 
                ? annonce.getPoste().getDepartement().getId() : null;
        this.villeNom = annonce.getVille() != null ? annonce.getVille().getNom() : null;
        this.villeId = annonce.getVille() != null ? annonce.getVille().getId() : null;
        this.diplomeId = annonce.getDiplome() != null ? annonce.getDiplome().getId() : null;
        this.filiereLibelle = annonce.getFiliere() != null ? annonce.getFiliere().getLibelle() : null;
        this.filiereId = annonce.getFiliere() != null ? annonce.getFiliere().getId() : null;
        this.genreId = annonce.getGenre() != null ? annonce.getGenre().getId() : null;
        this.description = annonce.getDescription();
        this.ferme = annonce.getFerme() != null ? annonce.getFerme() : false;
        this.dateLimite = annonce.getDateLimite();
        this.anneeExperience = annonce.getAnneeExperience();
        this.candidaturesCount = annonce.getCandidatures() != null ? annonce.getCandidatures().size() : 0;
        this.dateCreation = annonce.getDateCreation();
        this.urgent = annonce.getUrgent() != null ? annonce.getUrgent() : false;
        this.testId = annonce.getTest() != null ? annonce.getTest().getId() : 0;

        // 🔸 Compétences normales - avec vérification de null
        if (annonce.getCompetences() != null) {
            this.competences = annonce.getCompetences().stream()
                .filter(ac -> ac != null && !ac.isEstObligatoire())
                .map(ac -> ac.getCompetence() != null ? ac.getCompetence().getLibelle() : null)
                .filter(libelle -> libelle != null)
                .collect(Collectors.toList());
            
            this.competencesObligatoires = annonce.getCompetences().stream()
                .filter(ac -> ac != null && ac.isEstObligatoire())
                .map(ac -> ac.getCompetence() != null ? ac.getCompetence().getLibelle() : null)
                .filter(libelle -> libelle != null)
                .collect(Collectors.toList());
        } else {
            this.competences = List.of();
            this.competencesObligatoires = List.of();
        }

        // 🔸 Langues - avec vérification de null
        if (annonce.getLangues() != null) {
            this.langues = annonce.getLangues().stream()
                .filter(al -> al != null && !al.isEstObligatoire())
                .map(al -> al.getLangue() != null ? al.getLangue().getLibelle() : null)
                .filter(libelle -> libelle != null)
                .collect(Collectors.toList());
            
            this.languesObligatoires = annonce.getLangues().stream()
                .filter(al -> al != null && al.isEstObligatoire())
                .map(al -> al.getLangue() != null ? al.getLangue().getLibelle() : null)
                .filter(libelle -> libelle != null)
                .collect(Collectors.toList());
        } else {
            this.langues = List.of();
            this.languesObligatoires = List.of();
        }

        // 🔸 Critères obligatoires - avec valeurs par défaut
        this.diplomeObligatoire = annonce.getDiplomeObligatoire() != null ? annonce.getDiplomeObligatoire() : false;
        this.diplomeLibelle = annonce.getDiplome() != null ? annonce.getDiplome().getLibelle() : null;
        this.diplomeNiveau = annonce.getDiplome() != null ? annonce.getDiplome().getNiveau() : null;
        this.ageObligatoire = annonce.getAgeObligatoire() != null ? annonce.getAgeObligatoire() : false;
        this.ageMinimum = annonce.getAge();
        this.experienceObligatoire = annonce.getExperienceObligatoire() != null ? annonce.getExperienceObligatoire() : false;
        this.genreObligatoire = annonce.getGenreObligatoire() != null ? annonce.getGenreObligatoire() : false;
        this.genreLibelle = annonce.getGenre() != null ? annonce.getGenre().getLibelle() : null;
        this.villeObligatoire = annonce.getVilleObligatoire() != null ? annonce.getVilleObligatoire() : false;
    }

    // 🔹 Méthode statique pour créer le DTO de manière sécurisée
    public static AnnonceDTO fromEntity(Annonce annonce) {
        if (annonce == null) {
            return null;
        }
        return new AnnonceDTO(annonce);
    }

    // 🔹 Méthode toString pour le débogage
    @Override
    public String toString() {
        return "AnnonceDTO{" +
                "id=" + id +
                ", posteLibelle='" + posteLibelle + '\'' +
                ", departementNom='" + departementNom + '\'' +
                ", villeNom='" + villeNom + '\'' +
                ", ferme=" + ferme +
                ", urgent=" + urgent +
                ", candidaturesCount=" + candidaturesCount +
                '}';
    }
}