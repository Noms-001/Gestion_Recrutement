package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "question_reponse")
public class QuestionReponse {

    @EmbeddedId
    private QuestionReponseId id;

    @ManyToOne
    @MapsId("idQuestion")
    @JoinColumn(name = "id_question")
    private Question question;

    @ManyToOne
    @MapsId("idReponse")
    @JoinColumn(name = "id_reponse")
    private Reponse reponse;

    @Column(name = "est_correct", nullable = false)
    private Boolean estCorrect = false;

    // Getters & Setters
    public QuestionReponseId getId() {
        return id;
    }

    public void setId(QuestionReponseId id) {
        this.id = id;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public Reponse getReponse() {
        return reponse;
    }

    public void setReponse(Reponse reponse) {
        this.reponse = reponse;
    }

    public Boolean getEstCorrect() {
        return estCorrect;
    }

    public void setEstCorrect(Boolean estCorrect) {
        this.estCorrect = estCorrect;
    }
}
