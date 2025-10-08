package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.dto.*;
import com.example.entreprise.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
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
    @Autowired
    private GenreRepository genreRepository;

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
            List<Long> competences,
            List<Boolean> competencesObligatoires,
            List<Long> langues,
            List<Boolean> languesObligatoires,
            Long departementId) {
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

        // Gérer le genre
        if (genre != null && !genre.isEmpty()) {
            Genre genreEntity = genreRepository.findByLibelle(genre)
                    .orElseGet(() -> {
                        Genre g = new Genre();
                        g.setLibelle(genre);
                        return genreRepository.save(g);
                    });
            annonce.setGenre(genreEntity);
        }

        annonce.setGenreObligatoire(genreObligatoire != null ? genreObligatoire : false);
        annonce.setDiplome(diplomeId != null ? diplomeRepository.findById(diplomeId).orElse(null) : null);
        annonce.setDiplomeObligatoire(diplomeObligatoire != null ? diplomeObligatoire : false);
        annonce.setUrgent(urgent != null ? urgent : false);

        annonce = annonceRepository.save(annonce);

        // Ajouter compétences (éviter doublons)
        if (competences != null) {
            for (int i = 0; i < competences.size(); i++) {
                Long compId = competences.get(i);
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
        if (langues != null) {
            for (int i = 0; i < langues.size(); i++) {
                Long langId = langues.get(i);
                boolean obligatoire = languesObligatoires != null && languesObligatoires.size() > i
                        ? languesObligatoires.get(i)
                        : false;

                if (!annonceLangueRepository.existsById_IdAnnonceAndId_IdLangue(annonce.getId(), langId)) {
                    Langue lang = langueRepository.findById(langId).orElse(null);
                    if (lang != null) {
                        AnnonceLangue al = new AnnonceLangue();
                        al.setId(new AnnonceLangueId(annonce.getId(), lang.getId()));
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
        return annonces.stream()
                .map(AnnonceDTO::fromEntity)
                .collect(Collectors.toList());
    }

    public List<CompetenceDTO> findCompetencesByAnnonceId(Long annonceId) {
        return annonceCompetenceRepository.findByAnnonceIdWithCompetence(annonceId)
                .stream()
                .map(ac -> {
                    CompetenceDTO dto = new CompetenceDTO();
                    dto.id = ac.getCompetence().getId();
                    dto.libelle = ac.getCompetence().getLibelle();
                    dto.estObligatoire = ac.isEstObligatoire();
                    return dto;
                })
                .collect(Collectors.toList());
    }

    public List<LangueDTO> findLanguesByAnnonceId(Long annonceId) {
        return annonceLangueRepository.findByAnnonceIdWithLangue(annonceId)
                .stream()
                .map(al -> {
                    LangueDTO dto = new LangueDTO();
                    dto.id = al.getLangue().getId();
                    dto.libelle = al.getLangue().getLibelle();
                    dto.estObligatoire = al.isEstObligatoire();
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public Annonce updateAnnonce(
            Long annonceId,
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
            List<Long> competences,
            List<Boolean> competencesObligatoires,
            List<Long> langues,
            List<Boolean> languesObligatoires,
            Long departementId) {
        Annonce annonce = annonceRepository.findById(annonceId)
                .orElseThrow(() -> new RuntimeException("Annonce non trouvée"));

        // Mettre à jour le poste si nécessaire
        if (posteLibelle != null && !posteLibelle.equals(annonce.getPoste().getLibelle())) {
            Poste poste = posteRepository.findByLibelle(posteLibelle)
                    .orElseGet(() -> {
                        Poste p = new Poste();
                        p.setLibelle(posteLibelle);
                        Departement dep = departementRepository.findById(departementId).orElse(null);
                        p.setDepartement(dep);
                        return posteRepository.save(p);
                    });
            annonce.setPoste(poste);
        }

        // Mettre à jour les champs de base
        if (filiereId != null)
            annonce.setFiliere(filiereRepository.findById(filiereId).orElse(null));
        if (testId != null)
            annonce.setTest(testRepository.findById(testId).orElse(null));
        if (dateLimite != null)
            annonce.setDateLimite(dateLimite);
        if (description != null)
            annonce.setDescription(description);
        if (age != null)
            annonce.setAge(age);
        if (ageObligatoire != null)
            annonce.setAgeObligatoire(ageObligatoire);
        if (anneeExperience != null)
            annonce.setAnneeExperience(anneeExperience);
        if (experienceObligatoire != null)
            annonce.setExperienceObligatoire(experienceObligatoire);
        if (villeId != null)
            annonce.setVille(villeRepository.findById(villeId).orElse(null));
        if (villeObligatoire != null)
            annonce.setVilleObligatoire(villeObligatoire);

        // Mettre à jour le genre
        if (genre != null && !genre.isEmpty()) {
            Genre genreEntity = genreRepository.findByLibelle(genre)
                    .orElseGet(() -> {
                        Genre g = new Genre();
                        g.setLibelle(genre);
                        return genreRepository.save(g);
                    });
            annonce.setGenre(genreEntity);
        }

        if (genreObligatoire != null)
            annonce.setGenreObligatoire(genreObligatoire);
        if (diplomeId != null)
            annonce.setDiplome(diplomeRepository.findById(diplomeId).orElse(null));
        if (diplomeObligatoire != null)
            annonce.setDiplomeObligatoire(diplomeObligatoire);
        if (urgent != null)
            annonce.setUrgent(urgent);

        // Sauvegarder l'annonce mise à jour
        annonce = annonceRepository.save(annonce);

        // Mettre à jour les compétences
        updateCompetences(annonce, competences, competencesObligatoires);

        // Mettre à jour les langues
        updateLangues(annonce, langues, languesObligatoires);

        return annonce;
    }

    @Transactional
    private void updateCompetences(Annonce annonce, List<Long> competences, List<Boolean> competencesObligatoires) {
        if (competences != null) {
            // Récupérer d'abord toutes les compétences existantes
            List<AnnonceCompetence> existingCompetences = annonceCompetenceRepository
                    .findByAnnonceIdWithCompetence(annonce.getId());

            // Supprimer les compétences existantes une par une
            for (AnnonceCompetence existing : existingCompetences) {
                annonceCompetenceRepository.delete(existing);
            }

            // Ajouter les nouvelles compétences
            for (int i = 0; i < competences.size(); i++) {
                Long compId = competences.get(i);
                boolean obligatoire = competencesObligatoires != null && competencesObligatoires.size() > i
                        ? competencesObligatoires.get(i)
                        : false;

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

    @Transactional
    private void updateLangues(Annonce annonce, List<Long> langues, List<Boolean> languesObligatoires) {
        if (langues != null) {
            // Récupérer d'abord toutes les langues existantes
            List<AnnonceLangue> existingLangues = annonceLangueRepository.findByAnnonceIdWithLangue(annonce.getId());

            // Supprimer les langues existantes une par une
            for (AnnonceLangue existing : existingLangues) {
                annonceLangueRepository.delete(existing);
            }

            // Ajouter les nouvelles langues
            for (int i = 0; i < langues.size(); i++) {
                Long langId = langues.get(i);
                boolean obligatoire = languesObligatoires != null && languesObligatoires.size() > i
                        ? languesObligatoires.get(i)
                        : false;

                Langue lang = langueRepository.findById(langId).orElse(null);
                if (lang != null) {
                    AnnonceLangue al = new AnnonceLangue();
                    al.setId(new AnnonceLangueId(annonce.getId(), lang.getId()));
                    al.setAnnonce(annonce);
                    al.setLangue(lang);
                    al.setEstObligatoire(obligatoire);
                    annonceLangueRepository.save(al);
                }
            }
        }
    }

    // Méthodes utilitaires supplémentaires
    public boolean existsById(Long id) {
        return annonceRepository.existsById(id);
    }

    public void deleteAnnonce(Long id) {
        if (annonceRepository.existsById(id)) {
            annonceRepository.deleteById(id);
        }
    }

    @Transactional
    public void closeAnnonce(Long id) {
        annonceRepository.findById(id).ifPresent(annonce -> {
            annonce.setFerme(true);
            annonceRepository.save(annonce);
        });
    }

    public void reopenAnnonce(Long id) {
        annonceRepository.findById(id).ifPresent(annonce -> {
            annonce.setFerme(false);
            annonceRepository.save(annonce);
        });
    }

    @Transactional(readOnly = true)
    public List<AnnonceDTO> getAllAnnonces() {
        List<Annonce> annonces = annonceRepository.findAllActiveAnnonces();
        return annonces.stream()
                .map(AnnonceDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public AnnonceDTO getAnnonceById(Long id) {
        return annonceRepository.findByIdWithCompetences(id)
                .map(AnnonceDTO::fromEntity)
                .orElse(null);
    }

    public List<AnnonceDTO> filterAnnonces(List<Long> villes, Long diplome, Integer experience, 
                                        List<Long> competences, List<Long> langues, Boolean urgent) {
        
        List<Annonce> annonces = annonceRepository.findAllActiveAnnonces();
        
        return annonces.stream()
                .filter(annonce -> filterByVilles(annonce, villes))
                .filter(annonce -> filterByDiplome(annonce, diplome))
                .filter(annonce -> filterByExperience(annonce, experience))
                .filter(annonce -> filterByCompetences(annonce, competences))
                .filter(annonce -> filterByLangues(annonce, langues))
                .filter(annonce -> filterByUrgent(annonce, urgent))
                .map(AnnonceDTO::fromEntity)
                .collect(Collectors.toList());
    }

    private boolean filterByUrgent(Annonce annonce, Boolean urgent) {
        if (urgent == null || !urgent) return true;
        return annonce.getUrgent() != null && annonce.getUrgent();
    }

    public List<AnnonceDTO> searchAnnonces(String query) {
        return annonceRepository.findBySearchQuery(query).stream()
                .map(AnnonceDTO::fromEntity)
                .collect(Collectors.toList());
    }

    private boolean filterByVilles(Annonce annonce, List<Long> villes) {
        if (villes == null || villes.isEmpty()) return true;
        return annonce.getVille() != null && villes.contains(annonce.getVille().getId());
    }

    private boolean filterByDiplome(Annonce annonce, Long diplomeId) {
        if (diplomeId == null) return true;
        return annonce.getDiplome() != null && annonce.getDiplome().getId().equals(diplomeId);
    }

    private boolean filterByExperience(Annonce annonce, Integer experience) {
        if (experience == null || experience == 0) return true;
        return annonce.getAnneeExperience() != null && annonce.getAnneeExperience() >= experience;
    }

    private boolean filterByCompetences(Annonce annonce, List<Long> competences) {
        if (competences == null || competences.isEmpty()) return true;
        return annonce.getCompetences().stream()
                .anyMatch(ac -> competences.contains(ac.getCompetence().getId()));
    }

    private boolean filterByLangues(Annonce annonce, List<Long> langues) {
        if (langues == null || langues.isEmpty()) return true;
        return annonce.getLangues().stream()
                .anyMatch(al -> langues.contains(al.getLangue().getId()));
    }
}