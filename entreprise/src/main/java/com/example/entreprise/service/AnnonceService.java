package com.example.entreprise.service;

import com.example.entreprise.entity.Annonce;
import com.example.entreprise.entity.AnnonceCompetence;
import com.example.entreprise.entity.AnnonceLangue;
import com.example.entreprise.repository.AnnonceRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.stream.Collectors;

import com.example.entreprise.dto.AnnonceDTO;

@Service
public class AnnonceService {
    @Autowired
    private AnnonceRepository repository;

    public List<Annonce> findAll() {
        return repository.findAll();
    }

    public List<AnnonceDTO> filter(Long villeId, Long departementId, String poste, String status) {
        List<Annonce> annonces = repository.findByFilters(villeId, departementId, poste, status);

        // convertir en DTO
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
