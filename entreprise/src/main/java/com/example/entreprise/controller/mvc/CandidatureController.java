package com.example.entreprise.controller.mvc;

import com.example.entreprise.service.*;
import com.example.entreprise.dto.CandidatureDTO;
import com.example.entreprise.entity.*;
import jakarta.servlet.http.HttpSession;

import java.util.List;

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

    @Autowired
    private TestPassageService testPassageService;

    @Autowired
    private VilleService villeService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private CompetenceService competenceService;

    @Autowired
    private LangueService langueService;

    @PostMapping("/postuler/{annonceId}")
    public String postuler(@PathVariable Long annonceId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
            Candidature candidature = candidatureService.aDejaPostule(utilisateurId, annonceId);
            Long candidatureId = candidature != null ? candidature.getId() : null;
            if (utilisateurId == null) {
                redirectAttributes.addFlashAttribute("error", "Vous devez être connecté pour postuler");
                return "redirect:/login";
            }
            // Vérifier si déjà postulé
            if (testPassageService.aDejaPasseTest(utilisateurId, annonceId)) {
                redirectAttributes.addFlashAttribute("error", "Vous avez déjà postulé à cette annonce");
                return "redirect:/job-listings";
            }

            // Traiter la candidature
            Long testId = candidatureService.postuler(utilisateurId, annonceId, candidatureId);

            redirectAttributes.addFlashAttribute("success", "Candidature envoyée avec succès !");
            redirectAttributes.addFlashAttribute("testId", testId);
            redirectAttributes.addFlashAttribute("annonceId", annonceId);
            return "redirect:/candidature/success";

        } catch (IllegalStateException ie) {
            return "redirect:/cv-submission?field=" + ie.getMessage();
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
    public String success(Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
        if (utilisateurId == null) {
            redirectAttributes.addFlashAttribute("error", "Vous devez être connecté pour postuler");
            return "redirect:/login";
        }
        Long testId = (Long) model.getAttribute("testId");
        Long annonceId = (Long) model.getAttribute("annonceId");
        if (testPassageService.aDejaPasseTest(utilisateurId, annonceId)) {
            redirectAttributes.addFlashAttribute("error", "Vous avez déjà postulé à cette annonce");
            return "redirect:/job-listings";
        }
        model.addAttribute("testId", testId);
        model.addAttribute("AnnonceId", annonceId);
        return "success-candidature";
    }

    @GetMapping("/error")
    public String error(@ModelAttribute("error") String error, Model model) {
        model.addAttribute("errorMessage", error);
        return "error-candidature";
    }

    @GetMapping("/annonce/{id}")
    public String getCandidaturesByAnnonce(@PathVariable("id") Long annonceId, Model model) {
        List<CandidatureDTO> candidatures = candidatureService.getCandidaturesByAnnonceId(annonceId);
        List<Ville> villes = villeService.findAll();
        List<Diplome> diplomes = diplomeService.findAll();
        List<Competence> competences = competenceService.findAll();
        List<Langue> langues = langueService.findAll();
        model.addAttribute("candidatures", candidatures);
        model.addAttribute("villes", villes);
        model.addAttribute("diplomes", diplomes);
        model.addAttribute("competences", competences);
        model.addAttribute("langues", langues);
        return "candidates";
    }
}