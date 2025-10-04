// src/main/java/com/example/entreprise/dto/AnnonceDTO.java
package com.example.entreprise.dto;

import java.time.LocalDate;
import java.util.List;

public class AnnonceDTO {
    public Long id;
    public String posteLibelle;
    public String departementNom;
    public String villeNom;
    public String description;
    public Boolean ferme;
    public LocalDate dateLimite;
    public Integer anneeExperience;
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
}
