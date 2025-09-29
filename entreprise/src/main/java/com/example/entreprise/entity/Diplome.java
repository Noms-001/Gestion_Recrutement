package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "diplome")
public class Diplome {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_diplome")
    private Long id;

    private String libelle;
    private Double niveau;

    @OneToMany(mappedBy = "diplome")
    private List<Annonce> annonces;

    @OneToMany(mappedBy = "diplome")
    private List<Education> educations;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    public Double getNiveau() { return niveau; }
    public void setNiveau(Double niveau) { this.niveau = niveau; }
    public List<Annonce> getAnnonces() { return annonces; }
    public void setAnnonces(List<Annonce> annonces) { this.annonces = annonces; }
    public List<Education> getEducations() { return educations; }
    public void setEducations(List<Education> educations) { this.educations = educations; }
}
