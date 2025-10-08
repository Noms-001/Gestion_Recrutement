package com.example.entreprise.controller.rest;

import com.example.entreprise.dto.QuestionDTO;
import com.example.entreprise.dto.TestDTO;
import com.example.entreprise.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.entreprise.entity.*;
import java.util.*;

@RestController
@RequestMapping("/api/test")
public class TestRestController {

    @Autowired
    private TestService testService;
    @Autowired
    private TestPassageService testPassageService;
    @Autowired
    private QuestionService questionService;

    @PostMapping
    public ResponseEntity<Test> createTest(@RequestBody TestDTO dto) {
        Test saved = testService.createTest(dto);
        return ResponseEntity.ok(saved);
    }

    @GetMapping
    public List<Test> findAll() {
        return testService.findAll();
    }

    @GetMapping("/questions")
    public List<QuestionDTO> findAllDTO() {
        return questionService.findAllDTO();
    }

    @GetMapping("/{testId}")
    public ResponseEntity<Map<String, Object>> demarrerTest(@PathVariable Long testId, HttpSession session, Model model) {
        return ResponseEntity.ok(testService.getTestInfo(testId));
    }

    @PostMapping("/{annonceId}/soumettre")
    public ResponseEntity soumettreTest(
            @PathVariable Long annonceId,
            @RequestParam Integer score,
            HttpSession session) {
        try {
            Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
            
            if (utilisateurId == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "Utilisateur non connecté"));
            }
            
            testService.demarrerTest(utilisateurId, annonceId);
            testPassageService.save(utilisateurId, annonceId, score);
            return ResponseEntity.ok(Map.of("success", true));
            
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}