package com.example.entreprise.service;

import com.example.entreprise.entity.Annonce;
import com.example.entreprise.repository.AnnonceRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.util.List;
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

}
