package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "departement")
public class Departement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_departement")
    private Long id;

    private String nom;

    @OneToMany(mappedBy = "departement")
    private List<Poste> postes;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public List<Poste> getPostes() { return postes; }
    public void setPostes(List<Poste> postes) { this.postes = postes; }
}
