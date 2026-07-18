package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "entretien")
public class Entretien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_entretien")
    private Long id;

    @Column(name = "score_comportemental")
    private Double scoreComportemental;

    @Column(name = "score_culturel")
    private Double scoreCulturel;

    @Column(name = "score_technique")
    private Double scoreTechnique;

    @ManyToOne
    @JoinColumn(name = "id_candidature", nullable = false)
    private Candidature candidature;

    @ManyToOne
    @JoinColumn(name = "id_employe", nullable = false)
    private Employe employe;

    @Column(name = "date_entretien", nullable = false)
    private LocalDateTime dateEntretien;

    @Column(name = "compte_rendu")
    private String compteRendu;

    @Column(name = "point_fort")
    private String pointFort;

    private String amelioration;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getScore() {
        return scoreComportemental + scoreCulturel + scoreTechnique;
    }

    public Candidature getCandidature() {
        return candidature;
    }

    public void setCandidature(Candidature candidature) {
        this.candidature = candidature;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

    public LocalDateTime getDateEntretien() {
        return dateEntretien;
    }

    public void setDateEntretien(LocalDateTime dateEntretien) {
        this.dateEntretien = dateEntretien;
    }

    public String getCompteRendu() {
        return compteRendu;
    }

    public void setCompteRendu(String compteRendu) {
        this.compteRendu = compteRendu;
    }

    public Double getScoreComportemental() {
        return scoreComportemental;
    }

    public void setScoreComportemental(Double scoreComportemental) {
        this.scoreComportemental = scoreComportemental;
    }

    public Double getScoreCulturel() {
        return scoreCulturel;
    }

    public void setScoreCulturel(Double scoreCulturel) {
        this.scoreCulturel = scoreCulturel;
    }

    public Double getScoreTechnique() {
        return scoreTechnique;
    }

    public void setScoreTechnique(Double scoreTechnique) {
        this.scoreTechnique = scoreTechnique;
    }

    public String getPointFort() {
        return pointFort;
    }

    public void setPointFort(String pointFort) {
        this.pointFort = pointFort;
    }

    public String getAmelioration() {
        return amelioration;
    }

    public void setAmelioration(String amelioration) {
        this.amelioration = amelioration;
    }
}
