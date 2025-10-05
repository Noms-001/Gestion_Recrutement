package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CandidatureCompatibilityService {

    @Autowired private CandidatRepository candidatRepository;
    @Autowired private AnnonceRepository annonceRepository;
    @Autowired private EducationRepository educationRepository;
    @Autowired private ExperienceRepository experienceRepository;

    public double calculerPourcentageCompatibilite(Long candidatId, Long annonceId) {
        try {
            Candidat candidat = candidatRepository.findById(candidatId)
                    .orElseThrow(() -> new IllegalArgumentException("Candidat introuvable"));
            Annonce annonce = annonceRepository.findById(annonceId)
                    .orElseThrow(() -> new IllegalArgumentException("Annonce introuvable"));

            int totalCriteres = 0;
            int criteresRemplis = 0;

            // 1. Âge (si spécifié dans l'annonce)
            if (annonce.getAge() != null) {
                totalCriteres++;
                if (validerAge(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // 2. Ville (si spécifiée dans l'annonce)
            if (annonce.getVille() != null) {
                totalCriteres++;
                if (validerVille(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // 3. Genre (si spécifié dans l'annonce)
            if (annonce.getGenre() != null) {
                totalCriteres++;
                if (validerGenre(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // 4. Diplôme (si spécifié dans l'annonce)
            if (annonce.getDiplome() != null) {
                totalCriteres++;
                if (validerDiplome(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // 5. Expérience (si spécifiée dans l'annonce)
            if (annonce.getAnneeExperience() != null) {
                totalCriteres++;
                if (validerExperience(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // 6. Filière (toujours présente dans l'annonce)
            totalCriteres++;
            if (validerFiliere(candidat, annonce)) {
                criteresRemplis++;
            }

            // 7. Compétences (si spécifiées dans l'annonce)
            if (!annonce.getCompetences().isEmpty()) {
                totalCriteres++;
                if (validerCompetences(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // 8. Langues (si spécifiées dans l'annonce)
            if (!annonce.getLangues().isEmpty()) {
                totalCriteres++;
                if (validerLangues(candidat, annonce)) {
                    criteresRemplis++;
                }
            }

            // Si aucun critère n'est spécifié, compatibilité à 100%
            if (totalCriteres == 0) return 100.0;
            
            // Calcul simple : critères remplis / total critères
            return (double) criteresRemplis / totalCriteres * 100;

        } catch (Exception e) {
            return 0.0;
        }
    }

    // Méthodes de validation
    private boolean validerAge(Candidat candidat, Annonce annonce) {
        if (candidat.getDateNaissance() == null) return false;
        java.time.Period age = java.time.Period.between(candidat.getDateNaissance(), java.time.LocalDate.now());
        return age.getYears() <= annonce.getAge();
    }

    private boolean validerVille(Candidat candidat, Annonce annonce) {
        if (candidat.getVille() == null) return false;
        return candidat.getVille().getId().equals(annonce.getVille().getId());
    }

    private boolean validerGenre(Candidat candidat, Annonce annonce) {
        if (candidat.getUtilisateur().getGenre() == null) return false;
        return candidat.getUtilisateur().getGenre().getId().equals(annonce.getGenre().getId());
    }

    private boolean validerDiplome(Candidat candidat, Annonce annonce) {
        List<Education> educations = educationRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        return educations.stream()
                .anyMatch(e -> e.getDiplome().getNiveau() >= annonce.getDiplome().getNiveau());
    }

    private boolean validerExperience(Candidat candidat, Annonce annonce) {
        List<Experience> experiences = experienceRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        int total = experiences.stream()
                .mapToInt(e -> e.getFinAnnee() - e.getDebutAnnee())
                .sum();
        return total >= annonce.getAnneeExperience();
    }

    private boolean validerFiliere(Candidat candidat, Annonce annonce) {
        // Vérifie si le candidat a au moins une expérience ou éducation dans la filière
        boolean hasExperience = !experienceRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere()).isEmpty();
        boolean hasEducation = !educationRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere()).isEmpty();
        return hasExperience || hasEducation;
    }

    private boolean validerCompetences(Candidat candidat, Annonce annonce) {
        List<AnnonceCompetence> competencesRequises = annonce.getCompetences();
        return competencesRequises.stream().allMatch(aComp ->
                candidat.getCompetences().stream()
                        .anyMatch(cComp -> cComp.getId().equals(aComp.getCompetence().getId())));
    }

    private boolean validerLangues(Candidat candidat, Annonce annonce) {
        List<AnnonceLangue> languesRequises = annonce.getLangues();
        return languesRequises.stream().allMatch(aLang ->
                candidat.getLangues().stream()
                        .anyMatch(cLang -> cLang.getId().equals(aLang.getLangue().getId())));
    }
}