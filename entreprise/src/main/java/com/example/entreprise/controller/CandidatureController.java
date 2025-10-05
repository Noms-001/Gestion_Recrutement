package com.example.entreprise.controller;

import com.example.entreprise.service.CandidatureService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/candidature")
public class CandidatureController {

    @Autowired
    private CandidatureService candidatureService;

    @PostMapping("/postuler/{annonceId}")
    public String postuler(@PathVariable Long annonceId,
                         HttpSession session,
                         RedirectAttributes redirectAttributes) {
        try {
            Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
            
            if (utilisateurId == null) {
                redirectAttributes.addFlashAttribute("error", "Vous devez être connecté pour postuler");
                return "redirect:/login";
            }
            
            // Vérifier si déjà postulé
            if (candidatureService.aDejaPostule(utilisateurId, annonceId)) {
                redirectAttributes.addFlashAttribute("error", "Vous avez déjà postulé à cette annonce");
                return "redirect:/job-listings";
            }
            
            // Traiter la candidature
            Long testId = candidatureService.postuler(utilisateurId, annonceId);
            
            redirectAttributes.addFlashAttribute("success", "Candidature envoyée avec succès !");
            redirectAttributes.addFlashAttribute("testId", testId);
            return "redirect:/candidature/success";
            
        } catch (IllegalStateException ie) {
            return "redirect:/cv-submission?field="+ie.getMessage();
        } catch (IllegalArgumentException ie) {
            // Critères non remplis - redirection vers page d'erreur
            redirectAttributes.addFlashAttribute("error", ie.getMessage());
            return "redirect:/candidature/error";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Une erreur est survenue lors de la candidature");
            return "redirect:/candidature/error";
        }
    }

    @GetMapping("/success")
    public String success(@ModelAttribute("testId") Long testId, Model model) {
        model.addAttribute("testId", testId);
        return "success-candidature";
    }

    @GetMapping("/error")
    public String error(@ModelAttribute("error") String error, Model model) {
        model.addAttribute("errorMessage", error);
        return "error-candidature";
    }
}