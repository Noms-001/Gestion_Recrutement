package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "experience")
public class Experience {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_experience")
    private Long id;

    private String description;
    private Integer debut;
    private Integer fin;
    private String lieu;

    @ManyToOne
    @JoinColumn(name = "id_filiere", nullable = false)
    private Filiere filiere;

    @ManyToOne
    @JoinColumn(name = "id_candidat", nullable = false)
    private Candidat candidat;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Integer getDebut() { return debut; }
    public void setDebut(Integer debut) { this.debut = debut; }
    public Integer getFin() { return fin; }
    public void setFin(Integer fin) { this.fin = fin; }
    public String getLieu() { return lieu; }
    public void setLieu(String lieu) { this.lieu = lieu; }
    public Filiere getFiliere() { return filiere; }
    public void setFiliere(Filiere filiere) { this.filiere = filiere; }
    public Candidat getCandidat() { return candidat; }
    public void setCandidat(Candidat candidat) { this.candidat = candidat; }
}
