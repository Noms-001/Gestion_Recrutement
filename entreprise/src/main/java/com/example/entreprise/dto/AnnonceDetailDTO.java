// AnnonceDetailDTO.java
package com.example.entreprise.dto;

import java.time.LocalDate;
import java.util.List;

public class AnnonceDetailDTO {
    public Long id;
    public String posteLibelle;
    public Long departementId;
    public String departementNom;
    public Long villeId;
    public String villeNom;
    public Boolean ferme;
    public LocalDate dateLimite;
    public Integer anneeExperience;
    public Integer age;
    public String genre;
    public Long diplomeId;
    public Long filiereId;
    public Long testId;
    public String description;
    public Boolean urgent;
    public Boolean ageObligatoire;
    public Boolean diplomeObligatoire;
    public Boolean experienceObligatoire;
    public Boolean genreObligatoire;
    public Boolean villeObligatoire;
    public int candidaturesCount;
    public LocalDate dateCreation;
}