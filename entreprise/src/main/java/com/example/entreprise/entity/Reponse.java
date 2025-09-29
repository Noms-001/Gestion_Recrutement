package com.example.entreprise.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "reponse")
public class Reponse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reponse")
    private Long id;

    private String valeur;
    private Boolean estCorrect;

    @ManyToOne
    @JoinColumn(name = "id_question", nullable = false)
    private Question question;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getValeur() { return valeur; }
    public void setValeur(String valeur) { this.valeur = valeur; }
    public Boolean getEstCorrect() { return estCorrect; }
    public void setEstCorrect(Boolean estCorrect) { this.estCorrect = estCorrect; }
    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }
}
