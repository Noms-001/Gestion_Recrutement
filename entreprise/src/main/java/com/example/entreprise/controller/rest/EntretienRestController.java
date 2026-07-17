package com.example.entreprise.controller.rest;

import com.example.entreprise.dto.EntretienDTO;
import com.example.entreprise.entity.Candidature;
import com.example.entreprise.service.*;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/entretiens")
@CrossOrigin(origins = "*")
public class EntretienRestController {

    @Autowired
    private EntretienService entretienService;

    @Autowired
    private CandidatureService candidatureService;

    @GetMapping
    public List<EntretienDTO> getAllInterviews() {
        return entretienService.getAllInterviews();
    }

    @PostMapping("/planifier/{annonceId}")
    public ResponseEntity<?> planifierEntretien(@PathVariable Long annonceId,
            HttpSession session) {
        try {
            Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
            if (utilisateurId == null) {
                throw new RuntimeException("Vous devez être connecté pour planifier un entretien");
            }

            Candidature candidature = candidatureService.aDejaPostule(utilisateurId, annonceId);
            if (candidature == null) {
                throw new RuntimeException("Aucune candidature trouvée pour cette annonce");
            }

            entretienService.plannifyInterview(candidature.getId());
            return ResponseEntity.ok().body(Map.of(
                    "success", true,
                    "message", "Entretien planifié avec succès"));
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "error", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of(
                    "success", false,
                    "error", "Erreur interne du serveur: " + e.getMessage()));
        }
    }
}
