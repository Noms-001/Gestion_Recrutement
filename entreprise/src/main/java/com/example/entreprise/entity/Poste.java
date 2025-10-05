package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "poste")
public class Poste {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_poste")
    private Long id;

    private String libelle;

    @ManyToOne
    @JoinColumn(name = "id_departement", nullable = false)
    private Departement departement;

    @OneToMany(mappedBy = "poste")
    private List<Employe> employes;

    @OneToMany(mappedBy = "poste", fetch = FetchType.LAZY)
    private List<Annonce> annonces;

    @OneToMany(mappedBy = "poste")
    private List<CandidatEssai> candidatsEssai;

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

    public Departement getDepartement() {
        return departement;
    }

    public void setDepartement(Departement departement) {
        this.departement = departement;
    }

    public List<Employe> getEmployes() {
        return employes;
    }

    public void setEmployes(List<Employe> employes) {
        this.employes = employes;
    }

    public List<Annonce> getAnnonce() {
        return annonces;
    }

    public void setAnnonce(List<Annonce> annonce) {
        this.annonces = annonces;
    }

    public List<CandidatEssai> getCandidatsEssai() {
        return candidatsEssai;
    }

    public void setCandidatsEssai(List<CandidatEssai> candidatsEssai) {
        this.candidatsEssai = candidatsEssai;
    }
}
