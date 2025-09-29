package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "candidat_essai")
public class CandidatEssai {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_candidat_essai")
    private Long id;

    private LocalDate dateContrat;
    private Integer duree;

    @ManyToOne
    @JoinColumn(name = "id_poste", nullable = false)
    private Poste poste;

    @ManyToOne
    @JoinColumn(name = "id_candidat", nullable = false)
    private Candidat candidat;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public LocalDate getDateContrat() { return dateContrat; }
    public void setDateContrat(LocalDate dateContrat) { this.dateContrat = dateContrat; }
    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }
    public Poste getPoste() { return poste; }
    public void setPoste(Poste poste) { this.poste = poste; }
    public Candidat getCandidat() { return candidat; }
    public void setCandidat(Candidat candidat) { this.candidat = candidat; }
}
