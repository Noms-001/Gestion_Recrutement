package com.example.entreprise.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.entreprise.entity.*;
import com.example.entreprise.service.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class CvController {

    @Autowired
    private CandidatService candidatService;

    @Autowired
    private ExperienceService experienceService;

    @Autowired
    private EducationService educationService;

    @Autowired
    private CompetenceService competenceService;

    @Autowired
    private LangueService langueService;

    @Autowired
    private FiliereService filiereService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private VilleService villeService;

    @Autowired
    private GenreService genreService;

    @GetMapping("/cv-preview") 
    public String cvPreview() {
        return "view-cv";
    }

    @GetMapping("/cv-submission")
    public String cvSubmit(Model model, HttpSession session) {

        // Récupérer l'id du candidat depuis la session
        Long idUtilisateur = (Long) session.getAttribute("id_utilisateur");
        if (idUtilisateur != null) {

            // Récupérer le candidat
            Candidat candidat = candidatService.findByUtilisateurId(idUtilisateur).get();
            if (candidat != null) {
                model.addAttribute("candidatData", candidat);

                // Récupérer expériences, éducation, compétences, langues
                List<Experience> experiences = experienceService.findByCandidatId(candidat.getId());
                List<Education> educations = educationService.findByCandidatId(candidat.getId());
                List<Competence> competences = competenceService.findByCandidatId(candidat.getId());
                List<Langue> langues = langueService.findByCandidatId(candidat.getId());

                model.addAttribute("candidatExperiences", experiences);
                model.addAttribute("candidatEducations", educations);
                model.addAttribute("candidatCompetences", competences);
                model.addAttribute("candidatLangues", langues);
            }
        }

        // Listes générales pour les selects
        model.addAttribute("filieres", filiereService.findAll());
        model.addAttribute("diplomes", diplomeService.findAll());
        model.addAttribute("villes", villeService.findAll());
        model.addAttribute("competences", competenceService.findAll());
        model.addAttribute("genres", genreService.findAll());
        model.addAttribute("langues", langueService.findAll());

        return "cv-submission";
    }

    
}
