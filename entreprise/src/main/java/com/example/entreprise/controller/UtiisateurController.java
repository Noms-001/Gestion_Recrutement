package com.example.entreprise.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.entreprise.entity.Employe;
import com.example.entreprise.entity.Utilisateur;
import com.example.entreprise.service.UtilisateurService;
import com.example.entreprise.service.GenreService;
import com.example.entreprise.service.PosteService;
import com.example.entreprise.service.UtilisateurService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UtiisateurController {

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

    @GetMapping("/")
    public String showLoginPage() {
        return "login"; // login.jsp
    }

    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {

        Optional<Utilisateur> optUser = utilisateurService.authenticate(email, password);

        if (optUser.isEmpty()) {
            model.addAttribute("error", "Email ou mot de passe incorrect.");
            return "login";
        }

        Utilisateur user = optUser.get();
        session.setAttribute("id_utilisateur", user.getId());
        session.setAttribute("nom", user.getNom());
        session.setAttribute("prenom", user.getPrenom());
        String initials = user.getNom().charAt(0) + "" + user.getPrenom().charAt(0);
        session.setAttribute("initiales", initials.toUpperCase());

        // Vérifier rôle employé
        Optional<Employe> employe = utilisateurService.getEmploye(user);
        if (employe.isPresent()) {
            session.setAttribute("poste", employe.get().getPoste().getId());
            session.setAttribute("profil", "recruteur");
            session.setAttribute("avatarColor", "var(--primary-color)");
            return "dashboard";
        } else {
            session.setAttribute("profil", "candidat");
            session.setAttribute("avatarColor", "var(--primary-dark)");
        }

        // Si aucun rôle
        model.addAttribute("error", "Aucun rôle assigné à cet utilisateur.");
        return "redirect:/cv-submission";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
