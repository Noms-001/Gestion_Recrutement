package com.example.entreprise.controller;

import com.example.entreprise.service.AnnonceService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.Arrays;

@Controller
public class AnnonceController {

    @Autowired
    private AnnonceService annonceService;

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
            @RequestParam(value = "competences[]", required = false) Long[] competencesIds,
            @RequestParam(value = "competencesObligatoires[]", required = false) Boolean[] competencesObligatoires,
            @RequestParam(value = "langues[]", required = false) Long[] languesIds,
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
                    competencesIds != null ? Arrays.asList(competencesIds) : null,
                    competencesObligatoires != null ? Arrays.asList(competencesObligatoires) : null,
                    languesIds != null ? Arrays.asList(languesIds) : null,
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
}