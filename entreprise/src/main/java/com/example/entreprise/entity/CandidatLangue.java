package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "candidat_langue")
public class CandidatLangue {

    @EmbeddedId
    private CandidatLangueId id;

    @ManyToOne
    @MapsId("idCandidat")
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    @ManyToOne
    @MapsId("idLangue")
    @JoinColumn(name = "id_langue")
    private Langue langue;

    public CandidatLangue() {
    }

    // getters et setters
    public CandidatLangueId getId() {
        return id;
    }

    public void setId(CandidatLangueId id) {
        this.id = id;
    }

    public Candidat getCandidat() {
        return candidat;
    }

    public void setCandidat(Candidat candidat) {
        this.candidat = candidat;
    }

    public Langue getLangue() {
        return langue;
    }

    public void setLangue(Langue langue) {
        this.langue = langue;
    }
}
