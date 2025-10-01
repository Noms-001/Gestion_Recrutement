package com.example.entreprise.controller;

import com.example.entreprise.entity.Annonce;
import com.example.entreprise.service.AnnonceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class AnnonceRestController {
    @Autowired
    private AnnonceService annonceService;

    // GET /api/annonces?villeId=1&metierId=2&niveauId=3
    @GetMapping("/api/annonces")
    public List<Annonce> filterAnnonces(
            @RequestParam(required = false) Long villeId,
            @RequestParam(required = false) Long metierId,
            @RequestParam(required = false) Long niveauId) {

        return annonceService.filter(villeId, metierId, niveauId);
    }
}
