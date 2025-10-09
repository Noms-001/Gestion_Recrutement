package com.example.entreprise.dto;

import com.example.entreprise.entity.*;

import java.time.LocalDate;
import java.time.Period;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class CandidatureDTO {
    public String nom;
    public String prenom;
    public String adresse;
    public String photo;
    public String descriptionExperience;
    public Double anneeExperience;
    public LocalDate dateCandidature;
    public Integer scoreTest; 
    public Integer age;
    public List<String> competences;
    public List<String> langues;
    public String filiere;

    private CandidatureDTO() {}

    public static CandidatureDTO fromCandidature(Candidature candidature) {
        if (candidature == null || candidature.getCandidat() == null) return null;

        Candidat candidat = candidature.getCandidat();
        CandidatureDTO dto = new CandidatureDTO();

        dto.nom = candidat.getUtilisateur() != null ? candidat.getUtilisateur().getNom() : null;
        dto.prenom = candidat.getUtilisateur() != null ? candidat.getUtilisateur().getPrenom() : null;
        dto.adresse = candidat.getAdresse();
        dto.photo = candidat.getPhoto();
        dto.dateCandidature = candidature.getDateCandidature();

        // Expérience la plus longue dans la filière de l'annonce
        Annonce annonce = candidature.getAnnonce();
        Experience exp = candidat.getExperiences().stream()
                .filter(e -> e.getFiliere().getId().equals(annonce.getFiliere().getId()))
                .max(Comparator.comparing(e -> {
                    int debut = e.getDebutAnnee() != null ? e.getDebutAnnee() : 0;
                    int fin = e.getFinAnnee() != null ? e.getFinAnnee() : 0;
                    return fin - debut; 
                }))
                .orElse(null);

        if (exp != null) {
            dto.descriptionExperience = exp.getDescription();
            if (exp.getDebutAnnee() != null && exp.getFinAnnee() != null) {
                dto.anneeExperience = (double) (exp.getFinAnnee() - exp.getDebutAnnee());
            }
            dto.filiere = exp.getFiliere() != null ? exp.getFiliere().getLibelle() : null;
        } else if (!candidat.getExperiences().isEmpty()) {
            dto.filiere = candidat.getExperiences().get(0).getFiliere().getLibelle();
        }

        // Score du test passé pour cette annonce
        TestPassage tp = candidat.getTestsPasses().stream()
                .filter(t -> t.getAnnonce().getId().equals(annonce.getId()))
                .findFirst()
                .orElse(null);
        dto.scoreTest = tp != null ? tp.getScore() : null;

        // Age
        if (candidat.getDateNaissance() != null) {
            dto.age = Period.between(candidat.getDateNaissance(), LocalDate.now()).getYears();
        }

        // Compétences
        dto.competences = candidat.getCompetences() != null ? 
                candidat.getCompetences().stream()
                        .map(Competence::getLibelle)
                        .collect(Collectors.toList()) : List.of();

        // Langues
        dto.langues = candidat.getLangues() != null ?
                candidat.getLangues().stream()
                        .map(Langue::getLibelle)
                        .collect(Collectors.toList()) : List.of();

        return dto;
    }
}
