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
    @MapsId("idTest")
    @JoinColumn(name = "id_test")
    private Test test;

    private LocalDate datePassage;

    // Getters & Setters
    public TestPassageId getId() { return id; }
    public void setId(TestPassageId id) { this.id = id; }
    public Candidat getCandidat() { return candidat; }
    public void setCandidat(Candidat candidat) { this.candidat = candidat; }
    public Test getTest() { return test; }
    public void setTest(Test test) { this.test = test; }
    public LocalDate getDatePassage() { return datePassage; }
    public void setDatePassage(LocalDate datePassage) { this.datePassage = datePassage; }
}
