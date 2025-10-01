package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "annonce_langue")
public class AnnonceLangue {

    @EmbeddedId
    private AnnonceLangueId id;

    @ManyToOne
    @MapsId("idAnnonce")
    @JoinColumn(name = "id_annonce")
    private Annonce annonce;

    @ManyToOne
    @MapsId("idLangue")
    @JoinColumn(name = "id_langue")
    private Langue langue;

    @Column(name = "est_obligatoire")
    private boolean estObligatoire;

    public AnnonceLangue() {
    }

    public AnnonceLangue(Annonce annonce, Langue langue, boolean estObligatoire) {
        this.annonce = annonce;
        this.langue = langue;
        this.estObligatoire = estObligatoire;
        this.id = new AnnonceLangueId(annonce.getId(), Long.valueOf(langue.getId()));
    }

    // getters et setters
    public AnnonceLangueId getId() {
        return id;
    }

    public void setId(AnnonceLangueId id) {
        this.id = id;
    }

    public Annonce getAnnonce() {
        return annonce;
    }

    public void setAnnonce(Annonce annonce) {
        this.annonce = annonce;
    }

    public Langue getLangue() {
        return langue;
    }

    public void setLangue(Langue langue) {
        this.langue = langue;
    }

    public boolean isEstObligatoire() {
        return estObligatoire;
    }

    public void setEstObligatoire(boolean estObligatoire) {
        this.estObligatoire = estObligatoire;
    }
}
