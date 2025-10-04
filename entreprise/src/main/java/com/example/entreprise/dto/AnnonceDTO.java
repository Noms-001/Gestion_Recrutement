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
}
