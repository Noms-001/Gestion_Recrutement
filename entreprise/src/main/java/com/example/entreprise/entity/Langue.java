package com.example.entreprise.entity;

import jakarta.persistence.*;

import java.util.*;

@Entity
@Table(name = "langue")
public class Langue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_langue")
    private Integer id;

    @Column(name = "libelle", nullable = false, unique = true, length = 100)
    private String libelle;

    @ManyToMany(mappedBy = "langues")
    private List<Candidat> candidats;

    public List<Candidat> getCandidats() {
        return candidats;
    }

    public void setCandidats(List<Candidat> candidats) {
        this.candidats = candidats;
    }

    // Constructeurs
    public Langue() {
    }

    public Langue(String libelle) {
        this.libelle = libelle;
    }

    // Getters et setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

}