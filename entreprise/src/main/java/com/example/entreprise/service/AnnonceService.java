package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.dto.*;
import com.example.entreprise.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.hibernate.Hibernate;
import org.springframework.transaction.annotation.Transactional;

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

    public Optional<AnnonceDetailDTO> findAnnonceDetailById(Long id) {
        Optional<Annonce> annonceOpt = annonceRepository.findById(id);

        if (annonceOpt.isEmpty()) {
            return Optional.empty();
        }

        Annonce annonce = annonceOpt.get();

        // Initialiser manuellement les relations nécessaires pour éviter
        // LazyInitializationException
        Hibernate.initialize(annonce.getPoste());
        if (annonce.getPoste() != null) {
            Hibernate.initialize(annonce.getPoste().getDepartement());
        }
        Hibernate.initialize(annonce.getVille());
        Hibernate.initialize(annonce.getFiliere());
        Hibernate.initialize(annonce.getTest());
        Hibernate.initialize(annonce.getDiplome());
        Hibernate.initialize(annonce.getGenre());

        AnnonceDetailDTO dto = convertToDetailDTO(annonce);

        return Optional.of(dto);
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
                    dto.id = Long.valueOf(al.getLangue().getId());
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

    private AnnonceDetailDTO convertToDetailDTO(Annonce annonce) {
        AnnonceDetailDTO dto = new AnnonceDetailDTO();
        dto.id = annonce.getId();
        dto.posteLibelle = annonce.getPoste().getLibelle();
        dto.departementId = annonce.getPoste().getDepartement().getId();
        dto.departementNom = annonce.getPoste().getDepartement().getNom();
        dto.villeId = annonce.getVille() != null ? annonce.getVille().getId() : null;
        dto.villeNom = annonce.getVille() != null ? annonce.getVille().getNom() : "";
        dto.ferme = annonce.getFerme();
        dto.dateLimite = annonce.getDateLimite();
        dto.anneeExperience = annonce.getAnneeExperience();
        dto.age = annonce.getAge();
        dto.genre = annonce.getGenre() != null ? annonce.getGenre().getLibelle() : null;
        dto.diplomeId = annonce.getDiplome() != null ? annonce.getDiplome().getId() : null;
        dto.filiereId = annonce.getFiliere() != null ? annonce.getFiliere().getId() : null;
        dto.testId = annonce.getTest() != null ? annonce.getTest().getId() : null;
        dto.description = annonce.getDescription();
        dto.urgent = annonce.getUrgent();
        dto.ageObligatoire = annonce.getAgeObligatoire();
        dto.diplomeObligatoire = annonce.getDiplomeObligatoire();
        dto.experienceObligatoire = annonce.getExperienceObligatoire();
        dto.genreObligatoire = annonce.getGenreObligatoire();
        dto.villeObligatoire = annonce.getVilleObligatoire();
        dto.candidaturesCount = annonce.getCandidatures() != null ? annonce.getCandidatures().size() : 0;
        dto.dateCreation = annonce.getDateCreation();

        return dto;
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
}
    @Transactional(readOnly = true)
    public List<AnnonceDTO> getAllAnnonces() {
        List<Annonce> annonces = repository.findAllActiveAnnonces();

        return annonces.stream().map(annonce -> {
            AnnonceDTO dto = new AnnonceDTO();

            // Informations de base
            dto.id = annonce.getId();
            dto.posteLibelle = annonce.getPoste() != null ? annonce.getPoste().getLibelle() : "Poste non spécifié";
            dto.departementNom = annonce.getPoste() != null && annonce.getPoste().getDepartement() != null
                    ? annonce.getPoste().getDepartement().getNom()
                    : "Département non spécifié";
            dto.villeNom = annonce.getVille() != null ? annonce.getVille().getNom() : "Lieu non spécifié";
            dto.description = annonce.getDescription();
            dto.ferme = annonce.getFerme();
            dto.dateLimite = annonce.getDateLimite();
            dto.anneeExperience = annonce.getAnneeExperience();
            dto.candidaturesCount = annonce.getCandidatures() != null ? annonce.getCandidatures().size() : 0;
            dto.dateCreation = annonce.getDateCreation();

            // Critères obligatoires
            dto.diplomeObligatoire = annonce.getDiplomeObligatoire();
            dto.diplomeLibelle = annonce.getDiplome() != null ? annonce.getDiplome().getLibelle() : null;
            dto.diplomeNiveau = annonce.getDiplome() != null ? annonce.getDiplome().getNiveau() : null;
            dto.ageObligatoire = annonce.getAgeObligatoire();
            dto.ageMinimum = annonce.getAge();
            dto.experienceObligatoire = annonce.getExperienceObligatoire();
            dto.genreObligatoire = annonce.getGenreObligatoire();
            dto.genreLibelle = annonce.getGenre() != null ? annonce.getGenre().getLibelle() : null;
            dto.villeObligatoire = annonce.getVilleObligatoire();

            // Compétences et langues (chargées en lazy)
            if (annonce.getCompetences() != null) {
                dto.competences = annonce.getCompetences().stream()
                        .map(annonceCompetence -> annonceCompetence.getCompetence().getLibelle())
                        .collect(Collectors.toList());

                dto.competencesObligatoires = annonce.getCompetences().stream()
                        .filter(AnnonceCompetence::isEstObligatoire)
                        .map(annonceCompetence -> annonceCompetence.getCompetence().getLibelle())
                        .collect(Collectors.toList());
            }

            if (annonce.getLangues() != null) {
                dto.langues = annonce.getLangues().stream()
                        .map(annonceLangue -> annonceLangue.getLangue().getLibelle())
                        .collect(Collectors.toList());

                dto.languesObligatoires = annonce.getLangues().stream()
                        .filter(AnnonceLangue::isEstObligatoire)
                        .map(annonceLangue -> annonceLangue.getLangue().getLibelle())
                        .collect(Collectors.toList());
            }

            return dto;
        }).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public AnnonceDTO getAnnonceById(Long id) {
        return repository.findByIdWithCompetences(id)
                .map(annonce -> {
                    AnnonceDTO dto = new AnnonceDTO();

                    // Informations de base
                    dto.id = annonce.getId();
                    dto.posteLibelle = annonce.getPoste() != null ? annonce.getPoste().getLibelle() : "Poste non spécifié";
                    dto.departementNom = annonce.getPoste() != null && annonce.getPoste().getDepartement() != null
                            ? annonce.getPoste().getDepartement().getNom()
                            : "Département non spécifié";
                    dto.villeNom = annonce.getVille() != null ? annonce.getVille().getNom() : "Lieu non spécifié";
                    dto.description = annonce.getDescription();
                    dto.ferme = annonce.getFerme();
                    dto.dateLimite = annonce.getDateLimite();
                    dto.anneeExperience = annonce.getAnneeExperience();
                    dto.candidaturesCount = annonce.getCandidatures() != null ? annonce.getCandidatures().size() : 0;
                    dto.dateCreation = annonce.getDateCreation();

                    // Critères obligatoires
                    dto.diplomeObligatoire = annonce.getDiplomeObligatoire();
                    dto.diplomeLibelle = annonce.getDiplome() != null ? annonce.getDiplome().getLibelle() : null;
                    dto.diplomeNiveau = annonce.getDiplome() != null ? annonce.getDiplome().getNiveau() : null;
                    dto.ageObligatoire = annonce.getAgeObligatoire();
                    dto.ageMinimum = annonce.getAge();
                    dto.experienceObligatoire = annonce.getExperienceObligatoire();
                    dto.genreObligatoire = annonce.getGenreObligatoire();
                    dto.genreLibelle = annonce.getGenre() != null ? annonce.getGenre().getLibelle() : null;
                    dto.villeObligatoire = annonce.getVilleObligatoire();

                    // Compétences (déjà chargées avec la requête)
                    if (annonce.getCompetences() != null) {
                        dto.competences = annonce.getCompetences().stream()
                                .map(annonceCompetence -> annonceCompetence.getCompetence().getLibelle())
                                .collect(Collectors.toList());

                        dto.competencesObligatoires = annonce.getCompetences().stream()
                                .filter(AnnonceCompetence::isEstObligatoire)
                                .map(annonceCompetence -> annonceCompetence.getCompetence().getLibelle())
                                .collect(Collectors.toList());
                    }

                    // Langues (chargées en lazy)
                    if (annonce.getLangues() != null) {
                        dto.langues = annonce.getLangues().stream()
                                .map(annonceLangue -> annonceLangue.getLangue().getLibelle())
                                .collect(Collectors.toList());

                        dto.languesObligatoires = annonce.getLangues().stream()
                                .filter(AnnonceLangue::isEstObligatoire)
                                .map(annonceLangue -> annonceLangue.getLangue().getLibelle())
                                .collect(Collectors.toList());
                    }

                    return dto;
                })
                .orElse(null);
    }

}
