package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

@Service
public class CandidatureValidationService {

    @Autowired private CandidatRepository candidatRepository;
    @Autowired private AnnonceRepository annonceRepository;
    @Autowired private EducationRepository educationRepository;
    @Autowired private ExperienceRepository experienceRepository;

    public Long validerCandidature(Long candidatId, Long annonceId) throws Exception {
        Candidat candidat = candidatRepository.findById(candidatId)
                .orElseThrow(() -> new IllegalArgumentException("Candidat introuvable"));
        Annonce annonce = annonceRepository.findById(annonceId)
                .orElseThrow(() -> new IllegalArgumentException("Annonce introuvable"));

        // Vérification de l'âge
        if (annonce.getAgeObligatoire() && !validerAge(candidat, annonce)) {
            if (candidat.getDateNaissance() == null) {
                throw new IllegalStateException("dateNaissance");
            }
            throw new IllegalArgumentException("Âge ne correspond pas aux critères requis");
        }

        // Vérification de la ville
        if (annonce.getVilleObligatoire() && !validerVille(candidat, annonce)) {
            if (candidat.getVille() == null) {
                throw new IllegalStateException("ville");
            }
            throw new IllegalArgumentException("Ville ne correspond pas à celle exigée par l'annonce");
        }

        // Vérification du genre
        if (annonce.getGenreObligatoire() && !validerGenre(candidat, annonce)) {
            throw new IllegalArgumentException("Genre non conforme aux critères de l'annonce");
        }

        // Vérification du diplôme
        if (annonce.getDiplomeObligatoire() && !validerDiplome(candidat, annonce)) {
            throw new IllegalArgumentException("Diplôme insuffisant pour ce poste");
        }

        // Vérification de l'expérience
        if (annonce.getExperienceObligatoire() && !validerExperience(candidat, annonce)) {
            throw new IllegalArgumentException("Expérience professionnelle insuffisante");
        }

        // Vérification des compétences
        if (!validerCompetencesObligatoires(candidat, annonce)) {
            throw new IllegalArgumentException("Compétences obligatoires manquantes");
        }

        // Vérification des langues
        if (!validerLanguesObligatoires(candidat, annonce)) {
            throw new IllegalArgumentException("Langues obligatoires manquantes");
        }

        if (annonce.getTest() == null) {
            throw new IllegalArgumentException("Aucun test associé à cette annonce");
        }

        return annonce.getTest().getId();
    }

    // Méthodes de validation (doivent être public ou package-private pour être utilisées)
    boolean validerAge(Candidat candidat, Annonce annonce) {
        if (candidat.getDateNaissance() == null) return false;
        int ageCandidat = Period.between(candidat.getDateNaissance(), LocalDate.now()).getYears();
        return annonce.getAge() == null || ageCandidat <= annonce.getAge();
    }

    boolean validerVille(Candidat candidat, Annonce annonce) {
        if (candidat.getVille() == null) return false;
        return annonce.getVille() == null || 
               candidat.getVille().getId().equals(annonce.getVille().getId());
    }

    boolean validerGenre(Candidat candidat, Annonce annonce) {
        return annonce.getGenre() == null || 
               (candidat.getUtilisateur().getGenre() != null && 
                candidat.getUtilisateur().getGenre().getId().equals(annonce.getGenre().getId()));
    }

    boolean validerDiplome(Candidat candidat, Annonce annonce) {
        if (annonce.getDiplome() == null) return true;
        List<Education> educations = educationRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        return educations.stream()
                .anyMatch(e -> e.getDiplome().getNiveau() >= annonce.getDiplome().getNiveau());
    }

    boolean validerExperience(Candidat candidat, Annonce annonce) {
        if (annonce.getAnneeExperience() == null) return true;
        List<Experience> experiences = experienceRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        int total = experiences.stream()
                .mapToInt(e -> e.getFinAnnee() - e.getDebutAnnee())
                .sum();
        return total >= annonce.getAnneeExperience();
    }

    private boolean validerCompetencesObligatoires(Candidat candidat, Annonce annonce) {
        List<AnnonceCompetence> requises = annonce.getCompetences().stream()
                .filter(AnnonceCompetence::isEstObligatoire)
                .toList();
        return requises.stream().allMatch(aComp ->
                candidat.getCompetences().stream()
                        .anyMatch(cComp -> cComp.getId().equals(aComp.getCompetence().getId())));
    }

    private boolean validerLanguesObligatoires(Candidat candidat, Annonce annonce) {
        List<AnnonceLangue> requises = annonce.getLangues().stream()
                .filter(AnnonceLangue::isEstObligatoire)
                .toList();
        return requises.stream().allMatch(aLang ->
                candidat.getLangues().stream()
                        .anyMatch(cLang -> cLang.getId().equals(aLang.getLangue().getId())));
    }
}