package com.example.entreprise.dto;

public class ReponseDTO {
    private Long id;
    private String valeur;
    private Boolean estCorrect;

    // getters & setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getValeur() {
        return valeur;
    }

    public void setValeur(String valeur) {
        this.valeur = valeur;
    }

    public Boolean getEstCorrect() {
        return estCorrect;
    }

    public void setEstCorrect(Boolean estCorrect) {
        this.estCorrect = estCorrect;
    }
}