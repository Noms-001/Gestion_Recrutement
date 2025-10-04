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

    @Column(name = "date_limite")
    private LocalDate dateLimite;

    @Column(name = "date_creation")
    private LocalDate dateCreation;

    private String description;
    
    @Column(name = "annee_experience")
    private Integer anneeExperience;
    
    private Integer age;
    private Boolean urgent = false;
    private Boolean ferme = false;

    @Column(name = "age_obligatoire")
    private Boolean ageObligatoire = false;
    
    @Column(name = "diplome_obligatoire")
    private Boolean diplomeObligatoire = false;
    
    @Column(name = "experience_obligatoire")
    private Boolean experienceObligatoire = false;
    
    @Column(name = "genre_obligatoire")
    private Boolean genreObligatoire = false;
    
    @Column(name = "ville_obligatoire")
    private Boolean villeObligatoire = false;

    // Relations avec FetchType.LAZY pour éviter les problèmes
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_diplome")
    private Diplome diplome;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_genre")
    private Genre genre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_ville")
    private Ville ville;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_filiere", nullable = false)
    private Filiere filiere;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_test", nullable = false)
    private Test test;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_poste", nullable = false)
    private Poste poste;

    // Collections avec FetchType.LAZY et List (pas besoin de Set)
    @OneToMany(mappedBy = "annonce", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Candidature> candidatures;

    @OneToMany(mappedBy = "annonce", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<AnnonceCompetence> competences;

    @OneToMany(mappedBy = "annonce", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<AnnonceLangue> langues;

    // Constructeurs
    public Annonce() {
        this.dateCreation = LocalDate.now();
    }

    public Annonce(String description, Poste poste, Ville ville) {
        this();
        this.description = description;
        this.poste = poste;
        this.ville = ville;
        this.ferme = false;
        this.urgent = false;
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getDateLimite() { return dateLimite; }
    public void setDateLimite(LocalDate dateLimite) { this.dateLimite = dateLimite; }

    public LocalDate getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDate dateCreation) { this.dateCreation = dateCreation; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getAnneeExperience() { return anneeExperience; }
    public void setAnneeExperience(Integer anneeExperience) { this.anneeExperience = anneeExperience; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public Boolean getUrgent() { return urgent; }
    public void setUrgent(Boolean urgent) { this.urgent = urgent; }

    public Boolean getFerme() { return ferme; }
    public void setFerme(Boolean ferme) { this.ferme = ferme; }

    public Boolean getAgeObligatoire() { return ageObligatoire; }
    public void setAgeObligatoire(Boolean ageObligatoire) { this.ageObligatoire = ageObligatoire; }

    public Boolean getDiplomeObligatoire() { return diplomeObligatoire; }
    public void setDiplomeObligatoire(Boolean diplomeObligatoire) { this.diplomeObligatoire = diplomeObligatoire; }

    public Boolean getExperienceObligatoire() { return experienceObligatoire; }
    public void setExperienceObligatoire(Boolean experienceObligatoire) { this.experienceObligatoire = experienceObligatoire; }

    public Boolean getGenreObligatoire() { return genreObligatoire; }
    public void setGenreObligatoire(Boolean genreObligatoire) { this.genreObligatoire = genreObligatoire; }

    public Boolean getVilleObligatoire() { return villeObligatoire; }
    public void setVilleObligatoire(Boolean villeObligatoire) { this.villeObligatoire = villeObligatoire; }

    public Diplome getDiplome() { return diplome; }
    public void setDiplome(Diplome diplome) { this.diplome = diplome; }

    public Genre getGenre() { return genre; }
    public void setGenre(Genre genre) { this.genre = genre; }

    public Ville getVille() { return ville; }
    public void setVille(Ville ville) { this.ville = ville; }

    public Filiere getFiliere() { return filiere; }
    public void setFiliere(Filiere filiere) { this.filiere = filiere; }

    public Test getTest() { return test; }
    public void setTest(Test test) { this.test = test; }

    public Poste getPoste() { return poste; }
    public void setPoste(Poste poste) { this.poste = poste; }

    public List<Candidature> getCandidatures() { return candidatures; }
    public void setCandidatures(List<Candidature> candidatures) { this.candidatures = candidatures; }

    public List<AnnonceCompetence> getCompetences() { return competences; }
    public void setCompetences(List<AnnonceCompetence> competences) { this.competences = competences; }

    public List<AnnonceLangue> getLangues() { return langues; }
    public void setLangues(List<AnnonceLangue> langues) { this.langues = langues; }

    // Méthodes utilitaires
    public void addCompetence(AnnonceCompetence annonceCompetence) {
        this.competences.add(annonceCompetence);
        annonceCompetence.setAnnonce(this);
    }

    public void removeCompetence(AnnonceCompetence annonceCompetence) {
        this.competences.remove(annonceCompetence);
        annonceCompetence.setAnnonce(null);
    }

    public void addLangue(AnnonceLangue annonceLangue) {
        this.langues.add(annonceLangue);
        annonceLangue.setAnnonce(this);
    }

    public void removeLangue(AnnonceLangue annonceLangue) {
        this.langues.remove(annonceLangue);
        annonceLangue.setAnnonce(null);
    }

    public void addCandidature(Candidature candidature) {
        this.candidatures.add(candidature);
        candidature.setAnnonce(this);
    }

    public void removeCandidature(Candidature candidature) {
        this.candidatures.remove(candidature);
        candidature.setAnnonce(null);
    }

    // Méthode pour vérifier si l'annonce est expirée
    public boolean isExpired() {
        return dateLimite != null && LocalDate.now().isAfter(dateLimite);
    }

    // Méthode pour vérifier si l'annonce est active
    public boolean isActive() {
        return !ferme && !isExpired();
    }
}