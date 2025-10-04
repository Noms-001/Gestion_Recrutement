package com.example.entreprise.controller;

import java.util.*;
import java.time.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.example.entreprise.dto.*;
import com.example.entreprise.entity.*;
import com.example.entreprise.service.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AnnonceController {

    @Autowired
    private AnnonceService annonceService;

    @Autowired
    private CompetenceService competenceService;

    @Autowired
    private LangueService langueService;

    @Autowired
    private VilleService villeService;

    @Autowired
    private DiplomeService diplomeService;

    // Dans AnnonceController.java
    @PostMapping("/annonces/close")
    public String closeAnnonce(
            @RequestParam Long id,
            RedirectAttributes redirectAttributes) {

        try {
            annonceService.closeAnnonce(id);
            redirectAttributes.addFlashAttribute("success", "Annonce fermée avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la fermeture: " + e.getMessage());
        }

        return "redirect:/manage-jobs";
    }

    @PostMapping("/annonces/create")
    public String createAnnonce(
            @RequestParam(value = "poste", required = true) String posteLibelle,
            @RequestParam(value = "filiere", required = true) Long filiereId,
            @RequestParam(value = "test", required = true) Long testId,
            @RequestParam(value = "dateLimite", required = true) String dateLimiteStr,
            @RequestParam(value = "description", required = true) String description,
            @RequestParam(value = "age", required = false) Integer age,
            @RequestParam(value = "ageObligatoire", required = false) Boolean ageObligatoire,
            @RequestParam(value = "anneeExperience", required = false) Integer anneeExperience,
            @RequestParam(value = "experienceObligatoire", required = false) Boolean experienceObligatoire,
            @RequestParam(value = "ville", required = false) Long villeId,
            @RequestParam(value = "villeObligatoire", required = false) Boolean villeObligatoire,
            @RequestParam(value = "genreObligatoire", required = false) Boolean genreObligatoire,
            @RequestParam(value = "diplome", required = false) Long diplomeId,
            @RequestParam(value = "diplomeObligatoire", required = false) Boolean diplomeObligatoire,
            @RequestParam(value = "urgent", required = false) Boolean urgent,
            @RequestParam(value = "competences[]", required = false) Long[] competences,
            @RequestParam(value = "competencesObligatoires[]", required = false) Boolean[] competencesObligatoires,
            @RequestParam(value = "langues[]", required = false) Long[] langues,
            @RequestParam(value = "languesObligatoires[]", required = false) Boolean[] languesObligatoires,
            @RequestParam("departement") Long departementId,
            RedirectAttributes redirectAttributes) {
        try {
            LocalDate dateLimite = null;
            if (dateLimiteStr != null && !dateLimiteStr.isBlank()) {
                dateLimite = LocalDate.parse(dateLimiteStr);
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "Veuillez remplir la date limite");
                return "redirect:/manage-jobs";
            }

            annonceService.createAnnonce(
                    posteLibelle,
                    filiereId,
                    testId,
                    dateLimite,
                    description,
                    age,
                    ageObligatoire,
                    anneeExperience,
                    experienceObligatoire,
                    villeId,
                    villeObligatoire,
                    null,
                    genreObligatoire,
                    diplomeId,
                    diplomeObligatoire,
                    urgent,
                    competences != null ? Arrays.asList(competences) : null,
                    competencesObligatoires != null ? Arrays.asList(competencesObligatoires) : null,
                    langues != null ? Arrays.asList(langues) : null,
                    languesObligatoires != null ? Arrays.asList(languesObligatoires) : null,
                    departementId);

            redirectAttributes.addFlashAttribute("success", "Annonce créée avec succès !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Erreur lors de la création de l'annonce : " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/manage-jobs";
    }

    @PostMapping("/annonces/update")
    public String updateAnnonce(
            @RequestParam Long id,
            @RequestParam String poste,
            @RequestParam Long filiere,
            @RequestParam Long test,
            @RequestParam String dateLimite,
            @RequestParam String description,
            @RequestParam(required = false) Integer age,
            @RequestParam(required = false, defaultValue = "false") Boolean ageObligatoire,
            @RequestParam(required = false) Integer anneeExperience,
            @RequestParam(required = false, defaultValue = "false") Boolean experienceObligatoire,
            @RequestParam(required = false) Long ville,
            @RequestParam(required = false, defaultValue = "false") Boolean villeObligatoire,
            @RequestParam(required = false) String genre,
            @RequestParam(required = false, defaultValue = "false") Boolean genreObligatoire,
            @RequestParam(required = false) Long diplome,
            @RequestParam(required = false, defaultValue = "false") Boolean diplomeObligatoire,
            @RequestParam(required = false, defaultValue = "false") Boolean urgent,
            @RequestParam(required = false) List<Long> competences,
            @RequestParam(required = false) List<Boolean> competencesObligatoires,
            @RequestParam(required = false) List<Long> langues,
            @RequestParam(required = false) List<Boolean> languesObligatoires,
            @RequestParam Long departement,
            RedirectAttributes redirectAttributes) {

        try {
            annonceService.updateAnnonce(
                    id, poste, filiere, test, LocalDate.parse(dateLimite), description,
                    age, ageObligatoire, anneeExperience, experienceObligatoire,
                    ville, villeObligatoire, genre, genreObligatoire,
                    diplome, diplomeObligatoire, urgent,
                    competences, competencesObligatoires,
                    langues, languesObligatoires,
                    departement);

            redirectAttributes.addFlashAttribute("success", "Annonce modifiée avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la modification: " + e.getMessage());
        }

        return "redirect:/manage-jobs";
    }

    @GetMapping("/job-listings")
    public String showAnnoncesPage(HttpServletRequest request) {
        List<AnnonceDTO> annonces = annonceService.getAllAnnonces();
        List<Competence> competences = competenceService.findAll();
        List<Langue> langues = langueService.findAll();
        List<Ville> villes = villeService.findAll();
        List<Diplome> diplomes = diplomeService.findAll();
        request.setAttribute("annonces", annonces);
        request.setAttribute("competences", competences);
        request.setAttribute("langues", langues);
        request.setAttribute("villes", villes);
        request.setAttribute("diplomes", diplomes);

        return "/job-listings"; // nom du fichier JSP
    }
}