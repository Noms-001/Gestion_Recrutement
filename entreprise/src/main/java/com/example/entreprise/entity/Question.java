package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "question")
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_question")
    private Long id;

    private String enonce;
    private Integer point;

    @OneToMany(mappedBy = "question")
    private List<Reponse> reponses;

    @OneToMany(mappedBy = "question")
    private List<TestQcm> tests;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getEnonce() { return enonce; }
    public void setEnonce(String enonce) { this.enonce = enonce; }
    public Integer getPoint() { return point; }
    public void setPoint(Integer point) { this.point = point; }
    public List<Reponse> getReponses() { return reponses; }
    public void setReponses(List<Reponse> reponses) { this.reponses = reponses; }
    public List<TestQcm> getTests() { return tests; }
    public void setTests(List<TestQcm> tests) { this.tests = tests; }
}
