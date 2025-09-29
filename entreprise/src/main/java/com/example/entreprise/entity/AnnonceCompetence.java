package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "annonce_competence")
public class AnnonceCompetence {

    @EmbeddedId
    private AnnonceCompetenceId id;

    @ManyToOne
    @MapsId("idAnnonce")
    @JoinColumn(name = "id_annonce")
    private Annonce annonce;

    @ManyToOne
    @MapsId("idCompetence")
    @JoinColumn(name = "id_competence")
    private Competence competence;

    @Column(name = "est_obligatoire")
    private boolean estObligatoire;

    public AnnonceCompetence() {
    }

    // getters et setters
    public AnnonceCompetenceId getId() {
        return id;
    }

    public void setId(AnnonceCompetenceId id) {
        this.id = id;
    }

    public Annonce getAnnonce() {
        return annonce;
    }

    public void setAnnonce(Annonce annonce) {
        this.annonce = annonce;
    }

    public Competence getCompetence() {
        return competence;
    }

    public void setCompetence(Competence competence) {
        this.competence = competence;
    }

    public boolean isEstObligatoire() {
        return estObligatoire;
    }

    public void setEstObligatoire(boolean estObligatoire) {
        this.estObligatoire = estObligatoire;
    }
}
