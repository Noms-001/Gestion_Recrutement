package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "candidat")
public class Candidat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_candidat")
    private Long id;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;
    private String photo;
    private String adresse;

    @ManyToOne
    @JoinColumn(name = "id_genre", nullable = false)
    private Genre genre;

    @ManyToOne
    @JoinColumn(name = "id_ville", nullable = false)
    private Ville ville;

    @OneToOne
    @JoinColumn(name = "id_utilisateur", nullable = false, unique = true)
    private Utilisateur utilisateur;

    @OneToMany(mappedBy = "candidat")
    private List<Experience> experiences;

    @OneToMany(mappedBy = "candidat")
    private List<Candidature> candidatures;

    @ManyToMany
    @JoinTable(name = "candidat_competence", joinColumns = @JoinColumn(name = "id_candidat"), inverseJoinColumns = @JoinColumn(name = "id_competence"))
    private List<Competence> competences;

    @OneToMany(mappedBy = "candidat")
    private List<TestPassage> testsPasses;

    @OneToMany(mappedBy = "candidat")
    private List<CandidatEssai> candidatsEssai;

    @OneToMany(mappedBy = "candidat")
    private List<Education> educations;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public Ville getVille() {
        return ville;
    }

    public void setVille(Ville ville) {
        this.ville = ville;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public List<Experience> getExperiences() {
        return experiences;
    }

    public void setExperiences(List<Experience> experiences) {
        this.experiences = experiences;
    }

    public List<Candidature> getCandidatures() {
        return candidatures;
    }

    public void setCandidatures(List<Candidature> candidatures) {
        this.candidatures = candidatures;
    }

    public List<Competence> getCompetences() {
        return competences;
    }

    public void setCompetences(List<Competence> competences) {
        this.competences = competences;
    }

    public List<TestPassage> getTestsPasses() {
        return testsPasses;
    }

    public void setTestsPasses(List<TestPassage> testsPasses) {
        this.testsPasses = testsPasses;
    }

    public List<CandidatEssai> getCandidatsEssai() {
        return candidatsEssai;
    }

    public void setCandidatsEssai(List<CandidatEssai> candidatsEssai) {
        this.candidatsEssai = candidatsEssai;
    }

    public List<Education> getEducations() {
        return educations;
    }

    public void setEducations(List<Education> educations) {
        this.educations = educations;
    }
}
