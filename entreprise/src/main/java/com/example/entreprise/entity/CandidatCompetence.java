package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "candidat_competence")
public class CandidatCompetence {

    @EmbeddedId
    private CandidatCompetenceId id;

    @ManyToOne
    @MapsId("idCandidat")
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    @ManyToOne
    @MapsId("idCompetence")
    @JoinColumn(name = "id_competence")
    private Competence competence;

    public CandidatCompetence() {
    }

    // getters et setters
    public CandidatCompetenceId getId() {
        return id;
    }

    public void setId(CandidatCompetenceId id) {
        this.id = id;
    }

    public Candidat getCandidat() {
        return candidat;
    }

    public void setCandidat(Candidat candidat) {
        this.candidat = candidat;
    }

    public Competence getCompetence() {
        return competence;
    }

    public void setCompetence(Competence competence) {
        this.competence = competence;
    }
}
