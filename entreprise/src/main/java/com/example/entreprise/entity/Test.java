package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "test")
public class Test {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_test")
    private Long id;

    private String titre;
    private LocalTime temps;
    private Integer scoreMin;

    @OneToMany(mappedBy = "test")
    private List<TestQcm> questions;

    @OneToMany(mappedBy = "test")
    private List<TestPassage> passages;

    @OneToMany(mappedBy = "test")
    private List<Annonce> annonces;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public LocalTime getTemps() { return temps; }
    public void setTemps(LocalTime temps) { this.temps = temps; }
    public Integer getScoreMin() { return scoreMin; }
    public void setScoreMin(Integer scoreMin) { this.scoreMin = scoreMin; }
    public List<TestQcm> getQuestions() { return questions; }
    public void setQuestions(List<TestQcm> questions) { this.questions = questions; }
    public List<TestPassage> getPassages() { return passages; }
    public void setPassages(List<TestPassage> passages) { this.passages = passages; }
    public List<Annonce> getAnnonces() { return annonces; }
    public void setAnnonces(List<Annonce> annonces) { this.annonces = annonces; }
}
