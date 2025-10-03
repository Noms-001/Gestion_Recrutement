package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class QuestionReponseId implements Serializable {

    private Long idQuestion;
    private Long idReponse;

    public QuestionReponseId() {}

    public QuestionReponseId(Long idQuestion, Long idReponse) {
        this.idQuestion = idQuestion;
        this.idReponse = idReponse;
    }

    // equals & hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof QuestionReponseId)) return false;
        QuestionReponseId that = (QuestionReponseId) o;
        return Objects.equals(idQuestion, that.idQuestion) &&
               Objects.equals(idReponse, that.idReponse);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idQuestion, idReponse);
    }

    // Getters & Setters
    public Long getIdQuestion() { return idQuestion; }
    public void setIdQuestion(Long idQuestion) { this.idQuestion = idQuestion; }
    public Long getIdReponse() { return idReponse; }
    public void setIdReponse(Long idReponse) { this.idReponse = idReponse; }
}
