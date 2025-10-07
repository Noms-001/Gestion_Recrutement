package com.example.entreprise.controller;

import com.example.entreprise.service.TestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/test")
public class TestRestController {

    @Autowired
    private TestService testService;

    @GetMapping("/{testId}")
    public ResponseEntity demarrerTest(@PathVariable Long testId, HttpSession session, Model model) {
        return ResponseEntity.ok(testService.getTestInfo(testId));
    }

    /**
     * API pour soumettre un test
     */
    @PostMapping("/{testId}/soumettre")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> soumettreTest(
            @PathVariable Long testId,
            @RequestBody Map<Integer, String> reponses,
            HttpSession session) {
        
        try {
            Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
            
            if (utilisateurId == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "Utilisateur non connecté"));
            }
            
            Map<String, Object> resultat = testService.soumettreTest(utilisateurId, testId, reponses);
            return ResponseEntity.ok(resultat);
            
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    /**
     * Page de résultats du test
     */
    @GetMapping("/{testId}/resultats")
    public String afficherResultats(@PathVariable Long testId, HttpSession session, Model model) {
        // Implémentation pour afficher les résultats détaillés
        return "test-results";
    }
}