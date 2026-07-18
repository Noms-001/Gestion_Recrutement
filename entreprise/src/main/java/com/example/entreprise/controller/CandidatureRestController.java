package com.example.entreprise.controller;

import com.example.entreprise.dto.VerificationResultDTO;
import com.example.entreprise.entity.Candidature;
import com.example.entreprise.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@RestController 
@RequestMapping("/api/candidatures")
public class CandidatureRestController {

    @Autowired
    private CandidatureService candidatureService;

    @Autowired
    private CandidatService candidatService;

    @PostMapping("/postuler")
    public ResponseEntity<?> postulerAnnonce(@RequestParam Long annonceId, HttpSession session) {
        Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
        Long candidatId = candidatService.findByUtilisateurId(utilisateurId).get().getId();
        
        if (candidatId == null) {
            return ResponseEntity.badRequest().body("Utilisateur non connecté");
        }

        try {
            // Vérifier l'éligibilité
            VerificationResultDTO verification = candidatureService.verifierEligibiliteCandidat(candidatId, annonceId);
            
            if (!verification.isEligible()) {
                // Rediriger vers le CV avec les problèmes
                return ResponseEntity.ok(verification);
            }

            // Créer la candidature
            Candidature candidature = candidatureService.creerCandidature(candidatId, annonceId);
            verification.setCandidatureId(candidature.getId());
            
            return ResponseEntity.ok(verification);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erreur lors de la candidature: " + e.getMessage());
        }
    }
}