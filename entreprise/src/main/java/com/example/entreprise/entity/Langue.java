package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "langue")
public class Langue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_langue")
    private Long id;

    @Column(name = "libelle", nullable = false, unique = true, length = 100)
    private String libelle;

    @ManyToMany(mappedBy = "langues")
    private List<Candidat> candidats;

    // Constructors
    public Langue() {}
    public Langue(String libelle) { this.libelle = libelle; }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }

    public List<Candidat> getCandidats() { return candidats; }
    public void setCandidats(List<Candidat> candidats) { this.candidats = candidats; }
}
