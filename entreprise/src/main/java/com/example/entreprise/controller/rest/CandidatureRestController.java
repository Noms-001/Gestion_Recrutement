package com.example.entreprise.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.entreprise.dto.CandidatureDTO;
import com.example.entreprise.service.CandidatureService;

@RestController
@RequestMapping("/api/compatibilite")
public class CandidatureRestController {

    @Autowired
    private CandidatureService candidatureService;
    
    @GetMapping("/{id}")
    public ResponseEntity<?> evaluerCompatibilite(@PathVariable Long id) {
        try {
            CandidatureDTO result = candidatureService.evaluerCompatibilite(id);
            return ResponseEntity.ok(result);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Erreur : " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("Erreur interne : " + e.getMessage());
        }
    }
}
