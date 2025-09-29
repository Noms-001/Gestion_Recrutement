package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "test_qcm")
public class TestQcm {
    @EmbeddedId
    private TestQcmId id;

    @ManyToOne
    @MapsId("idTest")
    @JoinColumn(name = "id_test")
    private Test test;

    @ManyToOne
    @MapsId("idQuestion")
    @JoinColumn(name = "id_question")
    private Question question;

    // Getters & Setters
    public TestQcmId getId() { return id; }
    public void setId(TestQcmId id) { this.id = id; }
    public Test getTest() { return test; }
    public void setTest(Test test) { this.test = test; }
    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }
}
