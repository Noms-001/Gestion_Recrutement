package com.example.entreprise.service;

import com.example.entreprise.entity.Candidature;
import com.example.entreprise.entity.Education;
import com.example.entreprise.entity.Experience;
import com.example.entreprise.entity.Candidat;
import com.example.entreprise.dto.CandidatureDTO;
import com.example.entreprise.entity.Annonce;
import com.example.entreprise.entity.AnnonceCompetence;
import com.example.entreprise.entity.AnnonceLangue;
import com.example.entreprise.repository.AnnonceRepository;
import com.example.entreprise.repository.CandidatRepository;
import com.example.entreprise.repository.CandidatureRepository;
import com.example.entreprise.repository.EducationRepository;
import com.example.entreprise.repository.ExperienceRepository;
import com.example.entreprise.repository.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CandidatureService {

    @Autowired
    private CandidatureRepository candidatureRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private CandidatRepository candidatRepository;
    @Autowired
    private AnnonceRepository annonceRepository;
    @Autowired
    private EducationRepository educationRepository;
    @Autowired
    private ExperienceRepository experienceRepository;

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

    private boolean validerCompetencesObligatoires(Candidat candidat, Annonce annonce) {
        List<AnnonceCompetence> requises = annonce.getCompetences().stream()
                .filter(AnnonceCompetence::isEstObligatoire)
                .toList();
        return requises.stream().allMatch(aComp -> candidat.getCompetences().stream()
                .anyMatch(cComp -> cComp.getId().equals(aComp.getCompetence().getId())));
    }

    private boolean validerLanguesObligatoires(Candidat candidat, Annonce annonce) {
        List<AnnonceLangue> requises = annonce.getLangues().stream()
                .filter(AnnonceLangue::isEstObligatoire)
                .toList();
        return requises.stream().allMatch(aLang -> candidat.getLangues().stream()
                .anyMatch(cLang -> cLang.getId().equals(aLang.getLangue().getId())));
    }

    private boolean validerAge(Candidat candidat, Annonce annonce) {
        if (candidat.getDateNaissance() == null)
            return false;
        java.time.Period age = java.time.Period.between(candidat.getDateNaissance(), java.time.LocalDate.now());
        return age.getYears() <= annonce.getAge();
    }

    private boolean validerVille(Candidat candidat, Annonce annonce) {
        if (candidat.getVille() == null)
            return false;
        return candidat.getVille().getId().equals(annonce.getVille().getId());
    }

    private boolean validerGenre(Candidat candidat, Annonce annonce) {
        if (candidat.getUtilisateur().getGenre() == null)
            return false;
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

    @Transactional
    public Long postuler(Long utilisateurId, Long annonceId, Long candidatureId) throws Exception {
        try {
            // Récupération du candidat lié à l'utilisateur
            Long candidatId = utilisateurRepository.findById(utilisateurId)
                    .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"))
                    .getCandidat()
                    .getId();

            // Validation des critères avant de postuler
            Long validation = validerCandidature(candidatId, annonceId);

            // Création de la candidature
            Candidature candidature = new Candidature();
            candidature.setId(candidatureId);
            Candidat candidat = new Candidat();
            candidat.setId(candidatId);

            Annonce annonce = new Annonce();
            annonce.setId(annonceId);

            candidature.setCandidat(candidat);
            candidature.setAnnonce(annonce);
            candidature.setDateCandidature(LocalDate.now());

            candidatureRepository.save(candidature);

            return validation;

        } catch (Exception e) {
            throw e;
        }
    }

    public Candidature aDejaPostule(Long utilisateurId, Long annonceId) {
        Long candidatId = utilisateurRepository.findById(utilisateurId).get().getCandidat().getId();
        return candidatureRepository
                    .findByCandidatIdAndAnnonceId(candidatId, annonceId)
                    .orElse(null);
    }

    public List<CandidatureDTO> getCandidaturesByAnnonceId(Long annonceId) {
        List<Candidature> candidatures = candidatureRepository.findByAnnonceId(annonceId);
        return candidatures.stream()
                .map(CandidatureDTO::fromCandidature)
                .collect(Collectors.toList());
    }
}