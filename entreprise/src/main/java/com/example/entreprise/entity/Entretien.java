package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "entretien")
public class Entretien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_entretien")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_candidature", nullable = false)
    private Candidature candidature;

    @ManyToOne
    @JoinColumn(name = "id_employe", nullable = false)
    private Employe employe;

    private LocalDate dateEntretien;
    private String compteRendu;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Candidature getCandidature() { return candidature; }
    public void setCandidature(Candidature candidature) { this.candidature = candidature; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
    public LocalDate getDateEntretien() { return dateEntretien; }
    public void setDateEntretien(LocalDate dateEntretien) { this.dateEntretien = dateEntretien; }
    public String getCompteRendu() { return compteRendu; }
    public void setCompteRendu(String compteRendu) { this.compteRendu = compteRendu; }
}
