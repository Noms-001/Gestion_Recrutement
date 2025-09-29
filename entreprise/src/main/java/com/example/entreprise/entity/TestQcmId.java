package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class TestQcmId implements Serializable {
    private Long idTest;
    private Long idQuestion;

    // Getters & Setters
    public Long getIdTest() { return idTest; }
    public void setIdTest(Long idTest) { this.idTest = idTest; }
    public Long getIdQuestion() { return idQuestion; }
    public void setIdQuestion(Long idQuestion) { this.idQuestion = idQuestion; }
}
