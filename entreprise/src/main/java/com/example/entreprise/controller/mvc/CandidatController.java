package com.example.entreprise.controller.mvc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

import com.example.entreprise.entity.Candidat;
import com.example.entreprise.entity.Competence;
import com.example.entreprise.entity.Education;
import com.example.entreprise.entity.Experience;
import com.example.entreprise.entity.Langue;
import com.example.entreprise.service.CandidatService;
import com.example.entreprise.service.CompetenceService;
import com.example.entreprise.service.DiplomeService;
import com.example.entreprise.service.EducationService;
import com.example.entreprise.service.ExperienceService;
import com.example.entreprise.service.FiliereService;
import com.example.entreprise.service.GenreService;
import com.example.entreprise.service.LangueService;
import com.example.entreprise.service.VilleService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CandidatController {

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
