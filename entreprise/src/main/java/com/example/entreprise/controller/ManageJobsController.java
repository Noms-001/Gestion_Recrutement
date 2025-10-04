package com.example.entreprise.controller;

import com.example.entreprise.entity.*;
import com.example.entreprise.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Controller
public class ManageJobsController {

    @Autowired
    private AnnonceService annonceService;

    @Autowired
    private VilleService villeService;

    @Autowired
    private DepartementService departementService;

    @Autowired
    private PosteService posteService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private FiliereService filiereService;

    @Autowired
    private LangueService langueService;

    @Autowired
    private CompetenceService competenceService;

    @Autowired
    private TestService testService;

    @GetMapping("/manage-jobs")
    public String showManageJobs(Model model) {
        List<Annonce> annonces = annonceService.findAll();
        List<Ville> villes = villeService.findAll();
        List<Departement> departements = departementService.findAll();
        List<Poste> postes = posteService.findAll();
        List<Diplome> diplomes = diplomeService.findAll();
        List<Filiere> filieres = filiereService.findAll();
        List<Langue> langues = langueService.findAll();
        List<Competence> competences = competenceService.findAll();
        List<Test> tests = testService.findAll();

        model.addAttribute("annonces", annonces);
        model.addAttribute("villes", villes);
        model.addAttribute("departements", departements);
        model.addAttribute("postes", postes);
        model.addAttribute("diplomes", diplomes);
        model.addAttribute("filieres", filieres);
        model.addAttribute("langues", langues);
        model.addAttribute("competences", competences);
        model.addAttribute("tests", tests);

        return "manage-jobs";
    }

    
}
