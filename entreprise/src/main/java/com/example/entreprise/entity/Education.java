package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "education")
public class Education {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_education")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_filiere", nullable = false)
    private Filiere filiere;

    @ManyToOne
    @JoinColumn(name = "id_candidat", nullable = false)
    private Candidat candidat;

    @ManyToOne
    @JoinColumn(name = "id_diplome", nullable = false)
    private Diplome diplome;

    private Integer anneeDebut;
    private Integer anneeFin;
    private String lieu;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Filiere getFiliere() { return filiere; }
    public void setFiliere(Filiere filiere) { this.filiere = filiere; }
    public Candidat getCandidat() { return candidat; }
    public void setCandidat(Candidat candidat) { this.candidat = candidat; }
    public Diplome getDiplome() { return diplome; }
    public void setDiplome(Diplome diplome) { this.diplome = diplome; }
    public Integer getAnneeDebut() { return anneeDebut; }
    public void setAnneeDebut(Integer anneeDebut) { this.anneeDebut = anneeDebut; }
    public Integer getAnneeFin() { return anneeFin; }
    public void setAnneeFin(Integer anneeFin) { this.anneeFin = anneeFin; }
    public String getLieu() { return lieu; }
    public void setLieu(String lieu) { this.lieu = lieu; }
}
