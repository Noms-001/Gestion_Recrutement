package com.example.entreprise.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.entreprise.entity.Employe;
import com.example.entreprise.entity.Utilisateur;
import com.example.entreprise.service.AuthService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/")
    public String showLoginPage() {
        return "login"; // login.jsp
    }

    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {

        Optional<Utilisateur> optUser = authService.authenticate(email, password);

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
        Optional<Employe> employe = authService.getEmploye(user);
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
