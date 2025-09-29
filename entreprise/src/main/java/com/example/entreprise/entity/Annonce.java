package com.example.entreprise.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "annonce")
public class Annonce {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_annonce")
    private Long id;

    private LocalDate dateLimite;
    private String description;
    private Integer anneeExperience;
    private Integer age;
    private Boolean ageObligatoire;
    private Boolean diplomeObligatoire;
    private Boolean experienceObligatoire;
    private Boolean genreObligatoire;
    private Boolean villeObligatoire;

    @ManyToOne
    @JoinColumn(name = "id_diplome")
    private Diplome diplome;

    @ManyToOne
    @JoinColumn(name = "id_genre")
    private Genre genre;

    @ManyToOne
    @JoinColumn(name = "id_ville")
    private Ville ville;

    @ManyToOne
    @JoinColumn(name = "id_filiere", nullable = false)
    private Filiere filiere;

    @ManyToOne
    @JoinColumn(name = "id_test", nullable = false)
    private Test test;

    @ManyToOne
    @JoinColumn(name = "id_poste", nullable = false)
    private Poste poste;

    @OneToMany(mappedBy = "annonce")
    private List<Candidature> candidatures;

    @ManyToMany
    @JoinTable(name = "annonce_competence", joinColumns = @JoinColumn(name = "id_annonce"), inverseJoinColumns = @JoinColumn(name = "id_competence"))
    private List<Competence> competencesObligatoires;

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDateLimite() {
        return dateLimite;
    }

    public void setDateLimite(LocalDate dateLimite) {
        this.dateLimite = dateLimite;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getAnneeExperience() {
        return anneeExperience;
    }

    public void setAnneeExperience(Integer anneeExperience) {
        this.anneeExperience = anneeExperience;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Boolean getAgeObligatoire() {
        return ageObligatoire;
    }

    public void setAgeObligatoire(Boolean ageObligatoire) {
        this.ageObligatoire = ageObligatoire;
    }

    public Boolean getDiplomeObligatoire() {
        return diplomeObligatoire;
    }

    public void setDiplomeObligatoire(Boolean diplomeObligatoire) {
        this.diplomeObligatoire = diplomeObligatoire;
    }

    public Boolean getExperienceObligatoire() {
        return experienceObligatoire;
    }

    public void setExperienceObligatoire(Boolean experienceObligatoire) {
        this.experienceObligatoire = experienceObligatoire;
    }

    public Boolean getGenreObligatoire() {
        return genreObligatoire;
    }

    public void setGenreObligatoire(Boolean genreObligatoire) {
        this.genreObligatoire = genreObligatoire;
    }

    public Boolean getVilleObligatoire() {
        return villeObligatoire;
    }

    public void setVilleObligatoire(Boolean villeObligatoire) {
        this.villeObligatoire = villeObligatoire;
    }

    public Diplome getDiplome() {
        return diplome;
    }

    public void setDiplome(Diplome diplome) {
        this.diplome = diplome;
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

    public Filiere getFiliere() {
        return filiere;
    }

    public void setFiliere(Filiere filiere) {
        this.filiere = filiere;
    }

    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }

    public Poste getPoste() {
        return poste;
    }

    public void setPoste(Poste poste) {
        this.poste = poste;
    }

    public List<Candidature> getCandidatures() {
        return candidatures;
    }

    public void setCandidatures(List<Candidature> candidatures) {
        this.candidatures = candidatures;
    }

    public List<Competence> getCompetencesObligatoires() {
        return competencesObligatoires;
    }

    public void setCompetencesObligatoires(List<Competence> competencesObligatoires) {
        this.competencesObligatoires = competencesObligatoires;
    }
}
