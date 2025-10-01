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
    private PosteService posteService;
    @Autowired
    private DepartementService departementService;

    @GetMapping("/manage-jobs")
    public String showManageJobs(Model model) {
        List<Annonce> annonces = annonceService.findAll();
        List<Poste> postes = posteService.getAll();
        List<Departement> departements = departementService.getAll();

        model.addAttribute("annonces", annonces);
        model.addAttribute("postes", postes);
        model.addAttribute("departements", departements);

        return "manage-jobs"; // JSP
    }
}
