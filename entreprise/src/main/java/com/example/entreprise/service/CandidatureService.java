package com.example.entreprise.service;

import com.example.entreprise.dto.VerificationResultDTO;
import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CandidatureService {

    @Autowired
    private CandidatRepository candidatRepository;

    @Autowired
    private AnnonceRepository annonceRepository;

    @Autowired
    private CandidatureRepository candidatureRepository;

    // Vérifier si le candidat peut postuler
    public VerificationResultDTO verifierEligibiliteCandidat(Long candidatId, Long annonceId) {
        VerificationResultDTO result = new VerificationResultDTO();
        result.setEligible(true);
        List<String> problemes = new ArrayList<>();

        Optional<Candidat> candidatOpt = candidatRepository.findByIdWithDetails(candidatId);
        Optional<Annonce> annonceOpt = annonceRepository.findByIdWithDetails(annonceId);

        if (candidatOpt.isEmpty() || annonceOpt.isEmpty()) {
            result.setEligible(false);
            result.setProblemes(List.of("Candidat ou annonce non trouvé"));
            return result;
        }

        Candidat candidat = candidatOpt.get();
        Annonce annonce = annonceOpt.get();

        // 1. Vérification des informations personnelles obligatoires
        if (!verifierInfosPersonnelles(candidat, problemes)) {
            result.setEligible(false);
        }

        // 2. Vérification des critères obligatoires de l'annonce
        if (!verifierCriteresAnnonce(candidat, annonce, problemes)) {
            result.setEligible(false);
        }

        result.setProblemes(problemes);
        return result;
    }

    private boolean verifierInfosPersonnelles(Candidat candidat, List<String> problemes) {
        boolean valide = true;

        if (candidat.getUtilisateur().getNom() == null || candidat.getUtilisateur().getNom().trim().isEmpty()) {
            problemes.add("Nom manquant");
            valide = false;
        }
        if (candidat.getUtilisateur().getPrenom() == null || candidat.getUtilisateur().getPrenom().trim().isEmpty()) {
            problemes.add("Prénom manquant");
            valide = false;
        }
        if (candidat.getUtilisateur().getEmail() == null || candidat.getUtilisateur().getEmail().trim().isEmpty()) {
            problemes.add("Email manquant");
            valide = false;
        }
        if (candidat.getTelephone() == null || candidat.getTelephone().trim().isEmpty()) {
            problemes.add("Téléphone manquant");
            valide = false;
        }
        if (candidat.getAdresse() == null || candidat.getAdresse().trim().isEmpty()) {
            problemes.add("Adresse manquant");
            valide = false;
        }

        return valide;
    }

    private boolean verifierCriteresAnnonce(Candidat candidat, Annonce annonce, List<String> problemes) {
        boolean valide = true;

        // Vérification diplôme
        if (Boolean.TRUE.equals(annonce.getDiplomeObligatoire()) && annonce.getDiplome() != null) {
            if (!verifierDiplome(candidat, annonce.getDiplome())) {
                problemes.add("Diplôme requis: " + annonce.getDiplome().getLibelle() + " (niveau " + annonce.getDiplome().getNiveau() + ")");
                valide = false;
            }
        }

        // Vérification âge
        if (Boolean.TRUE.equals(annonce.getAgeObligatoire()) && annonce.getAge() != null) {
            if (!verifierAge(candidat, annonce.getAge())) {
                problemes.add("Âge minimum requis: " + annonce.getAge() + " ans");
                valide = false;
            }
        }

        // Vérification expérience
        if (Boolean.TRUE.equals(annonce.getExperienceObligatoire()) && annonce.getAnneeExperience() != null) {
            if (!verifierExperience(candidat, annonce.getAnneeExperience())) {
                problemes.add("Expérience requise: " + annonce.getAnneeExperience() + " an(s)");
                valide = false;
            }
        }

        // Vérification genre
        if (Boolean.TRUE.equals(annonce.getGenreObligatoire()) && annonce.getGenre() != null) {
            if (!verifierGenre(candidat, annonce.getGenre())) {
                problemes.add("Genre requis: " + annonce.getGenre().getLibelle());
                valide = false;
            }
        }

        // Vérification ville
        if (Boolean.TRUE.equals(annonce.getVilleObligatoire()) && annonce.getVille() != null) {
            if (!verifierVille(candidat, annonce.getVille())) {
                problemes.add("Localisation requise: " + annonce.getVille().getNom());
                valide = false;
            }
        }

        // Vérification compétences obligatoires
        if (annonce.getCompetences() != null) {
            List<String> competencesManquantes = verifierCompetencesObligatoires(candidat, annonce);
            if (!competencesManquantes.isEmpty()) {
                problemes.add("Compétences obligatoires manquantes: " + String.join(", ", competencesManquantes));
                valide = false;
            }
        }

        // Vérification langues obligatoires
        if (annonce.getLangues() != null) {
            List<String> languesManquantes = verifierLanguesObligatoires(candidat, annonce);
            if (!languesManquantes.isEmpty()) {
                problemes.add("Langues obligatoires manquantes: " + String.join(", ", languesManquantes));
                valide = false;
            }
        }

        return valide;
    }

    private boolean verifierDiplome(Candidat candidat, Diplome diplomeRequis) {
        if (candidat.getEducations() == null || candidat.getEducations().isEmpty()) {
            return false;
        }

        return candidat.getEducations().stream()
            .anyMatch(education -> education.getDiplome() != null && 
                education.getDiplome().getNiveau() >= diplomeRequis.getNiveau());
    }

    private boolean verifierAge(Candidat candidat, Integer ageMinimum) {
        if (candidat.getDateNaissance() == null) {
            return false;
        }
        
        int age = LocalDate.now().getYear() - candidat.getDateNaissance().getYear();
        return age >= ageMinimum;
    }

    private boolean verifierExperience(Candidat candidat, Integer anneeExperienceRequise) {
        if (candidat.getExperiences() == null || candidat.getExperiences().isEmpty()) {
            return false;
        }

        // Calcul approximatif de l'expérience totale
        long experienceTotale = candidat.getExperiences().stream()
            .mapToLong(exp -> {
                if (exp.getFinAnnee() != null && exp.getDebutAnnee() != null) {
                    return exp.getFinAnnee() - exp.getDebutAnnee();
                }
                return 0;
            })
            .sum();

        return experienceTotale >= anneeExperienceRequise;
    }

    private boolean verifierGenre(Candidat candidat, Genre genreRequis) {
        return candidat.getUtilisateur().getGenre() != null && 
               candidat.getUtilisateur().getGenre().getId().equals(genreRequis.getId());
    }

    private boolean verifierVille(Candidat candidat, Ville villeRequise) {
        return candidat.getVille() != null && 
               candidat.getVille().getId().equals(villeRequise.getId());
    }

    private List<String> verifierCompetencesObligatoires(Candidat candidat, Annonce annonce) {
        List<String> competencesManquantes = new ArrayList<>();
        
        annonce.getCompetences().stream()
            .filter(AnnonceCompetence::isEstObligatoire)
            .forEach(annonceCompetence -> {
                boolean possedeCompetence = candidat.getCompetences().stream()
                    .anyMatch(competence -> competence.getId().equals(annonceCompetence.getCompetence().getId()));
                
                if (!possedeCompetence) {
                    competencesManquantes.add(annonceCompetence.getCompetence().getLibelle());
                }
            });
        
        return competencesManquantes;
    }

    private List<String> verifierLanguesObligatoires(Candidat candidat, Annonce annonce) {
        List<String> languesManquantes = new ArrayList<>();
        
        annonce.getLangues().stream()
            .filter(AnnonceLangue::isEstObligatoire)
            .forEach(annonceLangue -> {
                boolean possedeLangue = candidat.getLangues().stream()
                    .anyMatch(langue -> langue.getId().equals(annonceLangue.getLangue().getId()));
                
                if (!possedeLangue) {
                    languesManquantes.add(annonceLangue.getLangue().getLibelle());
                }
            });
        
        return languesManquantes;
    }

    @Transactional
    public Candidature creerCandidature(Long candidatId, Long annonceId) {
        Optional<Candidat> candidatOpt = candidatRepository.findById(candidatId);
        Optional<Annonce> annonceOpt = annonceRepository.findById(annonceId);

        if (candidatOpt.isEmpty() || annonceOpt.isEmpty()) {
            throw new RuntimeException("Candidat ou annonce non trouvé");
        }

        // Vérifier si candidature existe déjà
        boolean existeDeja = candidatureRepository.existsByCandidatIdAndAnnonceId(candidatId, annonceId);
        if (existeDeja) {
            throw new RuntimeException("Candidature déjà existante");
        }

        Candidature candidature = new Candidature();
        candidature.setCandidat(candidatOpt.get());
        candidature.setAnnonce(annonceOpt.get());
        candidature.setDateCandidature(LocalDate.now());

        return candidatureRepository.save(candidature);
    }
}