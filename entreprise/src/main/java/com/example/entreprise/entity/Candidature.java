package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "candidature")
public class Candidature {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_candidature")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_annonce")
    private Annonce annonce;

    @ManyToOne
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    private LocalDate dateCandidature;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Annonce getAnnonce() { return annonce; }
    public void setAnnonce(Annonce annonce) { this.annonce = annonce; }
    public Candidat getCandidat() { return candidat; }
    public void setCandidat(Candidat candidat) { this.candidat = candidat; }
    public LocalDate getDateCandidature() { return dateCandidature; }
    public void setDateCandidature(LocalDate dateCandidature) { this.dateCandidature = dateCandidature; }
}
