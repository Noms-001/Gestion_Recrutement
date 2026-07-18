package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "test_passage")
public class TestPassage {
    @EmbeddedId
    private TestPassageId id;

    @ManyToOne
    @MapsId("idCandidat")
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    @ManyToOne
    @MapsId("idAnnonce")
    @JoinColumn(name = "id_annonce")
    private Annonce annonce;

    private Integer score;

    @Column(name = "date_passage")
    private LocalDate datePassage;

    // Getters & Setters
    public TestPassageId getId() { 
        return id; 
    }

    public void setId(TestPassageId id) { 
        this.id = id; 
    }

    public Candidat getCandidat() { 
        return candidat; 
    }

    public void setCandidat(Candidat candidat) { 
        this.candidat = candidat; 
    }

    public Annonce getAnnonce() { 
        return annonce; 
    }

    public void setAnnonce(Annonce annonce) { 
        this.annonce = annonce; 
    }

    public Integer getScore() { 
        return score; 
    }

    public void setScore(Integer score) { 
        this.score = score; 
    }

    public LocalDate getDatePassage() { 
        return datePassage; 
    }

    public void setDatePassage(LocalDate datePassage) { 
        this.datePassage = datePassage; 
    }
}
