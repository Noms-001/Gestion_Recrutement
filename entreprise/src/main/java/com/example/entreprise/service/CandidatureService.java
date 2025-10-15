package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.dto.CandidatureDTO;
import com.example.entreprise.repository.*;
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
        if (candidat.getDateNaissance() == null || annonce.getAge() == null)
            return false;
        java.time.Period age = java.time.Period.between(candidat.getDateNaissance(), java.time.LocalDate.now());
        return age.getYears() <= annonce.getAge();
    }

    private boolean validerVille(Candidat candidat, Annonce annonce) {
        if (candidat.getVille() == null || annonce.getVille() == null)
            return false;
        return candidat.getVille().getId().equals(annonce.getVille().getId());
    }

    private boolean validerGenre(Candidat candidat, Annonce annonce) {
        if (candidat.getUtilisateur().getGenre() == null || annonce.getGenre() == null)
            return false;
        return candidat.getUtilisateur().getGenre().getId().equals(annonce.getGenre().getId());
    }

    private boolean validerDiplome(Candidat candidat, Annonce annonce) {
        if(annonce.getDiplome() == null) return false;
        List<Education> educations = educationRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        return educations.stream()
                .anyMatch(e -> e.getDiplome().getNiveau() >= annonce.getDiplome().getNiveau());
    }

    private boolean validerExperience(Candidat candidat, Annonce annonce) {
        if(annonce.getAnneeExperience() == null) 
            return false;
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

    private double calculerScoreDiplome(Candidat candidat, Annonce annonce) {
        List<Education> educations = educationRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        if (educations.isEmpty())
            return 0;

        double maxNiveau = educations.stream().mapToDouble(e -> e.getDiplome().getNiveau()).max().orElse(0);

        double req = annonce.getDiplome().getNiveau();
        return Math.min(100, (maxNiveau * 100.0 / req));
    }

    private double calculerScoreExperience(Candidat candidat, Annonce annonce) {
        List<Experience> experiences = experienceRepository.findByCandidatAndFiliere(candidat, annonce.getFiliere());
        if (experiences.isEmpty())
            return 0;

        int total = experiences.stream().mapToInt(e -> e.getFinAnnee() - e.getDebutAnnee()).sum();

        int req = annonce.getAnneeExperience();
        return Math.min(100, (total * 100.0 / req));
    }

    private double calculerScoreCompetences(Candidat candidat, Annonce annonce) {
        List<AnnonceCompetence> annonceComps = annonce.getCompetences();
        if (annonceComps.isEmpty()) return 100;

        double totalPoids = 0;
        double score = 0;

        for (AnnonceCompetence ac : annonceComps) {
            double facteur = ac.isEstObligatoire() ? 1.5 : 1.0;
            totalPoids += facteur;

            boolean possede = candidat.getCompetences().stream().anyMatch(cComp -> cComp.getId().equals(ac.getCompetence().getId()));
            if (possede) score += facteur;
        }

        return (score / totalPoids) * 100.0;
    }

    private double calculerScoreLangues(Candidat candidat, Annonce annonce) {
        List<AnnonceLangue> annonceLangues = annonce.getLangues();
        if (annonceLangues.isEmpty()) return 100;

        double totalPoids = 0;
        double score = 0;

        for (AnnonceLangue al : annonceLangues) {
            double facteur = al.isEstObligatoire() ? 1.5 : 1.0;
            totalPoids += facteur;

            boolean possede = candidat.getLangues().stream().anyMatch(cLang -> cLang.getId().equals(al.getLangue().getId()));
            if (possede) score += facteur;
        }

        return (score / totalPoids) * 100.0;
    }

    private List<String> getCompetencesMatch(Candidat candidat, Annonce annonce) {
        return annonce.getCompetences().stream()
                .filter(aComp -> candidat.getCompetences().stream()
                        .anyMatch(cComp -> cComp.getId().equals(aComp.getCompetence().getId())))
                .map(aComp -> aComp.getCompetence().getLibelle())
                .collect(Collectors.toList());
    }

    private List<String> getLanguesMatch(Candidat candidat, Annonce annonce) {
        return annonce.getLangues().stream()
                .filter(aLang -> candidat.getLangues().stream()
                        .anyMatch(cLang -> cLang.getId().equals(aLang.getLangue().getId())))
                .map(aLang -> aLang.getLangue().getLibelle())
                .collect(Collectors.toList());
    }


    public CandidatureDTO evaluerCompatibilite(Long candidatureId) throws Exception {
        Candidature candidature = candidatureRepository.findById(candidatureId)
                .orElseThrow(() -> new IllegalArgumentException("Candidature introuvable"));
        Candidat candidat = candidature.getCandidat();
        Annonce annonce = candidature.getAnnonce();

        CandidatureDTO dto = new CandidatureDTO();
        dto.setId(candidatureId);
        dto.nom = candidat.getUtilisateur().getNom();
        dto.prenom = candidat.getUtilisateur().getPrenom();
        dto.photo = candidat.getPhoto();

        double totalScore = 0;

        // 🔹 Pondération par critère
        double wAge = 10;
        double wVille = 10;
        double wGenre = 5;
        double wDiplome = 15;
        double wExperience = 15;
        double wCompetences = 30;
        double wLangues = 15;

        double facteur = 1.5;

        if (annonce.getAgeObligatoire())
            wAge *= facteur;
        if (annonce.getVilleObligatoire())
            wVille *= facteur;
        if (annonce.getGenreObligatoire())
            wGenre *= facteur;
        if (annonce.getDiplomeObligatoire())
            wDiplome *= facteur;
        if (annonce.getExperienceObligatoire())
            wExperience *= facteur;

        double totalPoids = wAge + wVille + wGenre + wDiplome + wExperience + wCompetences + wLangues;

        // ==== AGE ====
        double ageScore = validerAge(candidat, annonce) ? 100 : 0;
        dto.addScore("Âge", ageScore);
        totalScore += ageScore * (wAge / totalPoids);

        // ==== VILLE ====
        double villeScore = validerVille(candidat, annonce) ? 100 : 0;
        dto.addScore("Ville", villeScore);
        totalScore += villeScore * (wVille / totalPoids);

        // ==== GENRE ====
        double genreScore = validerGenre(candidat, annonce) ? 100 : 0;
        dto.addScore("Genre", genreScore);
        totalScore += genreScore * (wGenre / totalPoids);

        // ==== DIPLÔME ====
        double diplomeScore = calculerScoreDiplome(candidat, annonce);
        dto.addScore("Diplôme", diplomeScore);
        totalScore += diplomeScore * (wDiplome / totalPoids);

        // ==== EXPÉRIENCE ====
        double expScore = calculerScoreExperience(candidat, annonce);
        dto.addScore("Expérience", expScore);
        totalScore += expScore * (wExperience / totalPoids);

        // ==== COMPÉTENCES ====
        double compScore = calculerScoreCompetences(candidat, annonce);
        dto.addScore("Compétences", compScore);
        dto.addCorrespondance("Compétences", getCompetencesMatch(candidat, annonce));
        totalScore += compScore * (wCompetences / totalPoids);

        // ==== LANGUES ====
        double langScore = calculerScoreLangues(candidat, annonce);
        dto.addScore("Langues", langScore);
        dto.addCorrespondance("Langues", getLanguesMatch(candidat, annonce));
        totalScore += langScore * (wLangues / totalPoids);

        // ==== Résultat final ====
        dto.setScoreGlobal(Math.round(totalScore * 100.0) / 100.0);
        return dto;
    }

}