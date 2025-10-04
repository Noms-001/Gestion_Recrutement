package com.example.entreprise.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.entreprise.dto.AnnonceDTO;
import com.example.entreprise.entity.*;
import com.example.entreprise.service.*;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AnnonceController {

    @Autowired
    private AnnonceService annonceService;

    @Autowired
    private CompetenceService competenceService;

    @Autowired
    private LangueService langueService;

    @Autowired
    private VilleService villeService;

    @Autowired
    private DiplomeService diplomeService;

    @GetMapping("/job-listings")
    public String showAnnoncesPage(HttpServletRequest request) {
        List<AnnonceDTO> annonces = annonceService.getAllAnnonces();
        List<Competence> competences = competenceService.findAll();
        List<Langue> langues = langueService.findAll();
        List<Ville> villes = villeService.findAll();
        List<Diplome> diplomes = diplomeService.findAll();
        request.setAttribute("annonces", annonces);
        request.setAttribute("competences", competences);
        request.setAttribute("langues", langues);
        request.setAttribute("villes", villes);
        request.setAttribute("diplomes", diplomes);

        return "/job-listings"; // nom du fichier JSP
    }
}