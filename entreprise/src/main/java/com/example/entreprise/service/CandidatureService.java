package com.example.entreprise.service;

import com.example.entreprise.entity.Candidature;
import com.example.entreprise.entity.Candidat;
import com.example.entreprise.entity.Annonce;
import com.example.entreprise.repository.CandidatureRepository;
import com.example.entreprise.repository.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;

@Service
public class CandidatureService {

    @Autowired
    private CandidatureRepository candidatureRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;
    
    @Autowired
    private CandidatureValidationService validationService;

    @Transactional
    public Long postuler(Long utilisateurId, Long annonceId) throws Exception {
        try {
            // Récupération du candidat lié à l'utilisateur
            Long candidatId = utilisateurRepository.findById(utilisateurId)
                    .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"))
                    .getCandidat()
                    .getId();

            // Validation des critères avant de postuler
            Long validation = validationService.validerCandidature(candidatId, annonceId);

            // Création de la candidature
            Candidature candidature = new Candidature();

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

    public boolean aDejaPostule(Long utilisateurId, Long annonceId) {
        Long candidatId = utilisateurRepository.findById(utilisateurId).get().getCandidat().getId();
        return candidatureRepository.existsByCandidatIdAndAnnonceId(candidatId, annonceId);
    }
}