package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.dto.*;
import com.example.entreprise.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;

@Service
public class AnnonceService {

    @Autowired
    private AnnonceRepository annonceRepository;
    @Autowired
    private PosteRepository posteRepository;
    @Autowired
    private FiliereRepository filiereRepository;
    @Autowired
    private TestRepository testRepository;
    @Autowired
    private VilleRepository villeRepository;
    @Autowired
    private DiplomeRepository diplomeRepository;
    @Autowired
    private CompetenceRepository competenceRepository;
    @Autowired
    private LangueRepository langueRepository;
    @Autowired
    private DepartementRepository departementRepository;
    @Autowired
    private AnnonceCompetenceRepository annonceCompetenceRepository;
    @Autowired
    private AnnonceLangueRepository annonceLangueRepository;

    public Annonce createAnnonce(
            String posteLibelle,
            Long filiereId,
            Long testId,
            LocalDate dateLimite,
            String description,
            Integer age,
            Boolean ageObligatoire,
            Integer anneeExperience,
            Boolean experienceObligatoire,
            Long villeId,
            Boolean villeObligatoire,
            String genre,
            Boolean genreObligatoire,
            Long diplomeId,
            Boolean diplomeObligatoire,
            Boolean urgent,
            List<Long> competencesIds,
            List<Boolean> competencesObligatoires,
            List<Long> languesIds,
            List<Boolean> languesObligatoires,
            Long departementId
    ) {
        // Vérifier ou créer le poste
        Poste poste = posteRepository.findByLibelle(posteLibelle)
                .orElseGet(() -> {
                    Poste p = new Poste();
                    p.setLibelle(posteLibelle);
                    Departement dep = departementRepository.findById(departementId).orElse(null);
                    p.setDepartement(dep);
                    return posteRepository.save(p);
                });

        // Créer l'annonce
        Annonce annonce = new Annonce();
        annonce.setPoste(poste);
        annonce.setFiliere(filiereRepository.findById(filiereId).orElse(null));
        annonce.setTest(testRepository.findById(testId).orElse(null));
        annonce.setDateCreation(LocalDate.now());
        annonce.setDateLimite(dateLimite);
        annonce.setDescription(description);
        annonce.setAge(age);
        annonce.setAgeObligatoire(ageObligatoire != null ? ageObligatoire : false);
        annonce.setAnneeExperience(anneeExperience);
        annonce.setExperienceObligatoire(experienceObligatoire != null ? experienceObligatoire : false);
        annonce.setVille(villeId != null ? villeRepository.findById(villeId).orElse(null) : null);
        annonce.setVilleObligatoire(villeObligatoire != null ? villeObligatoire : false);
        annonce.setGenreObligatoire(genreObligatoire != null ? genreObligatoire : false);
        annonce.setDiplome(diplomeId != null ? diplomeRepository.findById(diplomeId).orElse(null) : null);
        annonce.setDiplomeObligatoire(diplomeObligatoire != null ? diplomeObligatoire : false);
        annonce.setUrgent(urgent != null ? urgent : false);

        annonce = annonceRepository.save(annonce);

        // Ajouter compétences (éviter doublons)
        if (competencesIds != null) {
            for (int i = 0; i < competencesIds.size(); i++) {
                Long compId = competencesIds.get(i);
                boolean obligatoire = competencesObligatoires != null && competencesObligatoires.size() > i
                        ? competencesObligatoires.get(i)
                        : false;

                if (!annonceCompetenceRepository.existsById_IdAnnonceAndId_IdCompetence(annonce.getId(), compId)) {
                    Competence comp = competenceRepository.findById(compId).orElse(null);
                    if (comp != null) {
                        AnnonceCompetence ac = new AnnonceCompetence();
                        ac.setId(new AnnonceCompetenceId(annonce.getId(), compId));
                        ac.setAnnonce(annonce);
                        ac.setCompetence(comp);
                        ac.setEstObligatoire(obligatoire);
                        annonceCompetenceRepository.save(ac);
                    }
                }
            }
        }

        // Ajouter langues (éviter doublons)
        if (languesIds != null) {
            for (int i = 0; i < languesIds.size(); i++) {
                Long langId = languesIds.get(i);
                boolean obligatoire = languesObligatoires != null && languesObligatoires.size() > i
                        ? languesObligatoires.get(i)
                        : false;

                if (!annonceLangueRepository.existsById_IdAnnonceAndId_IdLangue(annonce.getId(), langId)) {
                    Langue lang = langueRepository.findById(langId).orElse(null);
                    if (lang != null) {
                        AnnonceLangue al = new AnnonceLangue();
                        al.setId(new AnnonceLangueId(annonce.getId(), langId));
                        al.setAnnonce(annonce);
                        al.setLangue(lang);
                        al.setEstObligatoire(obligatoire);
                        annonceLangueRepository.save(al);
                    }
                }
            }
        }

        return annonce;
    }

    public List<Annonce> findAll() {
        return annonceRepository.findAll();
    }

    public List<AnnonceDTO> filter(Long villeId, Long departementId, String poste, String status) {
        List<Annonce> annonces = annonceRepository.findByFilters(villeId, departementId, poste, status);
        return annonces.stream().map(a -> {
            AnnonceDTO dto = new AnnonceDTO();
            dto.id = a.getId();
            dto.posteLibelle = a.getPoste().getLibelle();
            dto.departementNom = a.getPoste().getDepartement().getNom();
            dto.villeNom = a.getVille() != null ? a.getVille().getNom() : "";
            dto.ferme = a.getFerme();
            dto.dateLimite = a.getDateLimite();
            dto.anneeExperience = a.getAnneeExperience();
            dto.candidaturesCount = a.getCandidatures() != null ? a.getCandidatures().size() : 0;
            dto.dateCreation = a.getDateCreation();
            return dto;
        }).toList();
    }
}
