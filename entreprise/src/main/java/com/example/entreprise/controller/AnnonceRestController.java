package com.example.entreprise.controller;

import com.example.entreprise.dto.AnnonceDTO;
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

    @GetMapping("/api/annonces")
    public List<AnnonceDTO> filterAnnonces(
            @RequestParam(required = false) Long villeId,
            @RequestParam(required = false) Long departementId,
            @RequestParam(required = false) String poste,
            @RequestParam(required = false) String status) {

        return annonceService.filter(villeId, departementId, poste, status);
    }

}
