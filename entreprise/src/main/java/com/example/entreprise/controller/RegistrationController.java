package com.example.entreprise.controller;

import com.example.entreprise.service.*;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RegistrationController {

    @Autowired
    private UtilisateurService utilisateurService;

    @Autowired
    private PosteService posteService;

    @Autowired
    private GenreService genreService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("postes", posteService.findAll());
        model.addAttribute("genres", genreService.findAll());
        return "registration";
    }

    @PostMapping("/register")
    public String register(HttpServletRequest request, RedirectAttributes redirectAttrs) {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");
        String profil = request.getParameter("profil");
        String posteStr = request.getParameter("poste");
        String genreStr = request.getParameter("genre");

        Long posteId = null;
        if (posteStr != null && !posteStr.isEmpty()) {
            posteId = Long.parseLong(posteStr);
        }

        Long genreId = null;
        if (genreStr != null && !genreStr.isEmpty()) {
            genreId = Long.parseLong(genreStr);
        }

        try {
            utilisateurService.inscrireUtilisateur(nom, prenom, email, motDePasse, profil, posteId, genreId);
            return "redirect:/";
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", e.getMessage());
            return "redirect:/register";

        }
    }
}
