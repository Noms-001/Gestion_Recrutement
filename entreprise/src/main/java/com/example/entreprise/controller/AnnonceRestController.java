package com.example.entreprise.controller;

import com.example.entreprise.dto.AnnonceDTO;
import com.example.entreprise.dto.CompetenceDTO;
import com.example.entreprise.dto.LangueDTO;
import com.example.entreprise.service.AnnonceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;


@RestController
@RequestMapping("/api/annonces")
public class AnnonceRestController {
    @Autowired
    private AnnonceService annonceService;

    @GetMapping("/filtre")
    public List<AnnonceDTO> Annoncesfilter(
            @RequestParam(required = false) Long villeId,
            @RequestParam(required = false) Long departementId,
            @RequestParam(required = false) String poste,
            @RequestParam(required = false) String status) {

        return annonceService.filter(villeId, departementId, poste, status);
    }

    // Dans AnnonceRestController.java
    @GetMapping("/filter")
    public List<AnnonceDTO> filterAnnonces(
            @RequestParam(required = false) List<Long> villes,
            @RequestParam(required = false) Long diplome,
            @RequestParam(required = false) Integer experience,
            @RequestParam(required = false) List<Long> competences,
            @RequestParam(required = false) List<Long> langues,
            @RequestParam(required = false) Boolean urgent) { 
        
        return annonceService.filterAnnonces(villes, diplome, experience, competences, langues, urgent);
    }

    @GetMapping("/search")
    public List<AnnonceDTO> searchAnnonces(@RequestParam(required = false) String q) {
        return annonceService.searchAnnonces(q);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AnnonceDTO> getAnnonceDetails(@PathVariable Long id) {
        AnnonceDTO annonce = annonceService.getAnnonceById(id);
        if(annonce != null) {
            return ResponseEntity.ok(annonce);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/{id}/competences")
    public List<CompetenceDTO> getAnnonceCompetences(@PathVariable Long id) {
        return annonceService.findCompetencesByAnnonceId(id);
    }

    @GetMapping("/{id}/langues")
    public List<LangueDTO> getAnnonceLangues(@PathVariable Long id) {
        return annonceService.findLanguesByAnnonceId(id);
    }

}
