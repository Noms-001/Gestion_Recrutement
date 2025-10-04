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

    @GetMapping("/manage-jobs")
    public String showManageJobs(Model model) {
        List<Annonce> annonces = annonceService.findAll();
        List<Ville> villes = villeService.findAll();
        List<Departement> departements = departementService.getAll();

        model.addAttribute("annonces", annonces);
        model.addAttribute("villes", villes);
        model.addAttribute("departements", departements);

        return "manage-jobs"; // JSP
    }

    
}
