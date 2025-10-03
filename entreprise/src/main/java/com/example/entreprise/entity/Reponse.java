package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "reponse")
public class Reponse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reponse")
    private Long id;

    private String valeur;

    @OneToMany(mappedBy = "reponse", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<QuestionReponse> questionReponses;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getValeur() {
        return valeur;
    }

    public void setValeur(String valeur) {
        this.valeur = valeur;
    }

    public List<QuestionReponse> getQuestionReponses() {
        return questionReponses;
    }

    public void setQuestionReponses(List<QuestionReponse> questionReponses) {
        this.questionReponses = questionReponses;
    }

    public Boolean estCorrect(Question question) {
        if (questionReponses == null || questionReponses.isEmpty()) {
            return false;
        }
        return getQuestionReponses().stream()
                .anyMatch(qr -> qr.getQuestion().equals(question) && Boolean.TRUE.equals(qr.getEstCorrect()));
    }
}
