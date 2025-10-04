package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "filiere")
public class Filiere {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_filiere")
    private Long id;

    private String libelle;

    @OneToMany(mappedBy = "filiere")
    private List<Experience> experiences;

    @OneToMany(mappedBy = "filiere")
    private List<Annonce> annonces;

    @OneToMany(mappedBy = "filiere")
    private List<Education> educations;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public List<Experience> getExperiences() {
        return experiences;
    }

    public void setExperiences(List<Experience> experiences) {
        this.experiences = experiences;
    }

    public List<Annonce> getAnnonces() {
        return annonces;
    }

    public void setAnnonces(List<Annonce> annonces) {
        this.annonces = annonces;
    }

    public List<Education> getEducations() {
        return educations;
    }

    public void setEducations(List<Education> educations) {
        this.educations = educations;
    }
}
