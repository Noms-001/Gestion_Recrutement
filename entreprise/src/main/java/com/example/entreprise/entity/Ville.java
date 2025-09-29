package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "ville")
public class Ville {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_ville")
    private Long id;

    private String nom;

    @OneToMany(mappedBy = "ville")
    private List<Candidat> candidats;

    @OneToMany(mappedBy = "ville")
    private List<Annonce> annonces;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public List<Candidat> getCandidats() { return candidats; }
    public void setCandidats(List<Candidat> candidats) { this.candidats = candidats; }
    public List<Annonce> getAnnonces() { return annonces; }
    public void setAnnonces(List<Annonce> annonces) { this.annonces = annonces; }
}
