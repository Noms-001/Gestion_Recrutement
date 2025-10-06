// src/main/java/com/example/entreprise/dto/AnnonceDTO.java
package com.example.entreprise.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import com.example.entreprise.entity.Annonce;

public class AnnonceDTO {
    public Long id;
    public String posteLibelle;
    public String departementNom;
    public String villeNom;
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
        this.villeNom = annonce.getVille() != null ? annonce.getVille().getNom() : null;
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

    // 🔹 Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getPosteLibelle() { return posteLibelle; }
    public void setPosteLibelle(String posteLibelle) { this.posteLibelle = posteLibelle; }
    
    public String getDepartementNom() { return departementNom; }
    public void setDepartementNom(String departementNom) { this.departementNom = departementNom; }
    
    public String getVilleNom() { return villeNom; }
    public void setVilleNom(String villeNom) { this.villeNom = villeNom; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Boolean getFerme() { return ferme; }
    public void setFerme(Boolean ferme) { this.ferme = ferme; }
    
    public LocalDate getDateLimite() { return dateLimite; }
    public void setDateLimite(LocalDate dateLimite) { this.dateLimite = dateLimite; }
    
    public Integer getAnneeExperience() { return anneeExperience; }
    public void setAnneeExperience(Integer anneeExperience) { this.anneeExperience = anneeExperience; }
    
    public int getCandidaturesCount() { return candidaturesCount; }
    public void setCandidaturesCount(int candidaturesCount) { this.candidaturesCount = candidaturesCount; }
    
    public LocalDate getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDate dateCreation) { this.dateCreation = dateCreation; }
    
    public List<String> getCompetences() { return competences; }
    public void setCompetences(List<String> competences) { this.competences = competences; }
    
    public List<String> getLangues() { return langues; }
    public void setLangues(List<String> langues) { this.langues = langues; }
    
    public Boolean getDiplomeObligatoire() { return diplomeObligatoire; }
    public void setDiplomeObligatoire(Boolean diplomeObligatoire) { this.diplomeObligatoire = diplomeObligatoire; }
    
    public String getDiplomeLibelle() { return diplomeLibelle; }
    public void setDiplomeLibelle(String diplomeLibelle) { this.diplomeLibelle = diplomeLibelle; }
    
    public Double getDiplomeNiveau() { return diplomeNiveau; }
    public void setDiplomeNiveau(Double diplomeNiveau) { this.diplomeNiveau = diplomeNiveau; }
    
    public Boolean getAgeObligatoire() { return ageObligatoire; }
    public void setAgeObligatoire(Boolean ageObligatoire) { this.ageObligatoire = ageObligatoire; }
    
    public Integer getAgeMinimum() { return ageMinimum; }
    public void setAgeMinimum(Integer ageMinimum) { this.ageMinimum = ageMinimum; }
    
    public Boolean getExperienceObligatoire() { return experienceObligatoire; }
    public void setExperienceObligatoire(Boolean experienceObligatoire) { this.experienceObligatoire = experienceObligatoire; }
    
    public Boolean getGenreObligatoire() { return genreObligatoire; }
    public void setGenreObligatoire(Boolean genreObligatoire) { this.genreObligatoire = genreObligatoire; }
    
    public String getGenreLibelle() { return genreLibelle; }
    public void setGenreLibelle(String genreLibelle) { this.genreLibelle = genreLibelle; }
    
    public Boolean getVilleObligatoire() { return villeObligatoire; }
    public void setVilleObligatoire(Boolean villeObligatoire) { this.villeObligatoire = villeObligatoire; }
    
    public Boolean getUrgent() { return urgent; }
    public void setUrgent(Boolean urgent) { this.urgent = urgent; }
    
    public List<String> getCompetencesObligatoires() { return competencesObligatoires; }
    public void setCompetencesObligatoires(List<String> competencesObligatoires) { this.competencesObligatoires = competencesObligatoires; }
    
    public List<String> getLanguesObligatoires() { return languesObligatoires; }
    public void setLanguesObligatoires(List<String> languesObligatoires) { this.languesObligatoires = languesObligatoires; }

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