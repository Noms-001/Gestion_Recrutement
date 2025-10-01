// src/main/java/com/example/entreprise/dto/AnnonceDTO.java
package com.example.entreprise.dto;

import java.time.LocalDate;

public class AnnonceDTO {
    public Long id;
    public String posteLibelle;
    public String departementNom;
    public String villeNom;
    public Boolean ferme;
    public LocalDate dateLimite;
    public Integer anneeExperience;
    public int candidaturesCount;
    public String typeContrat; // si tu veux
    public LocalDate dateCreation;
}
