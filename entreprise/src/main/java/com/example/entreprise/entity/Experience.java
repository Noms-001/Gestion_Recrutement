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
    @Column(name = "debut_mois")
    private Integer debutMois;  // 1-12

    @Column(name = "debut_annee")
    private Integer debutAnnee;

    @Column(name = "fin_mois")
    private Integer finMois;    // 1-12

    @Column(name = "fin_annee")
    private Integer finAnnee;
    
    public Integer getDebutMois() {
        return debutMois;
    }

    public void setDebutMois(Integer debutMois) {
        this.debutMois = debutMois;
    }

    public Integer getDebutAnnee() {
        return debutAnnee;
    }

    public void setDebutAnnee(Integer debutAnnee) {
        this.debutAnnee = debutAnnee;
    }

    public Integer getFinMois() {
        return finMois;
    }

    public void setFinMois(Integer finMois) {
        this.finMois = finMois;
    }

    public Integer getFinAnnee() {
        return finAnnee;
    }

    public void setFinAnnee(Integer finAnnee) {
        this.finAnnee = finAnnee;
    }

    private String lieu;

    @ManyToOne
    @JoinColumn(name = "id_filiere", nullable = false)
    private Filiere filiere;

    @ManyToOne
    @JoinColumn(name = "id_candidat", nullable = false)
    private Candidat candidat;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public Filiere getFiliere() {
        return filiere;
    }

    public void setFiliere(Filiere filiere) {
        this.filiere = filiere;
    }

    public Candidat getCandidat() {
        return candidat;
    }

    public void setCandidat(Candidat candidat) {
        this.candidat = candidat;
    }
}
