package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.*;

@Entity
@Table(name = "question")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_question")
    private Long id;

    private String enonce;
    private Integer point;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<QuestionReponse> questionReponses;

    @ManyToMany
    @JoinTable(name = "test_qcm", joinColumns = @JoinColumn(name = "id_question"), inverseJoinColumns = @JoinColumn(name = "id_test"))
    private List<Test> tests;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEnonce() {
        return enonce;
    }

    public void setEnonce(String enonce) {
        this.enonce = enonce;
    }

    public Integer getPoint() {
        return point;
    }

    public void setPoint(Integer point) {
        this.point = point;
    }

    public List<QuestionReponse> getQuestionReponses() {
        return questionReponses;
    }

    public void setQuestionReponses(List<QuestionReponse> questionReponses) {
        this.questionReponses = questionReponses;
    }

    public List<Test> getTests() {
        return tests;
    }

    public void setTests(List<Test> tests) {
        this.tests = tests;
    }

    public List<Reponse> getReponses() {
        if (questionReponses == null || questionReponses.isEmpty()) {
            return new ArrayList<>();
        }
        return getQuestionReponses()
                .stream()
                .map(QuestionReponse::getReponse)
                .toList();
    }

    public Reponse getReponseCorrect() {
        if (questionReponses == null || questionReponses.isEmpty()) {
            return null;
        }
        return getQuestionReponses()
                .stream()
                .filter(QuestionReponse::getEstCorrect)
                .map(QuestionReponse::getReponse)
                .findFirst()
                .orElse(null);

    }
}
