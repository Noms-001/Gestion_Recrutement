package com.example.entreprise.controller.rest;

import com.example.entreprise.service.PosteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/postes")
public class PosteRestController {

    @Autowired
    private PosteService posteService;

    @GetMapping("/vacants")
    public List<String> getPostesVacants() {
        return posteService.getLibellesPostesVacants();
    }

    @GetMapping("/vacants/departement/{departementId}")
    public List<String> getPostesVacantsByDepartement(@PathVariable Long departementId) {
        return posteService.getLibellesPostesVacantsByDepartement(departementId);
    }

    @GetMapping("/{posteId}/vacant")
    public boolean isPosteVacant(@PathVariable Long posteId) {
        return posteService.isPosteVacant(posteId);
    }

    @GetMapping("/vacant/{libellePoste}")
    public boolean isPosteVacantByLibelle(@PathVariable String libellePoste) {
        return posteService.isPosteVacantByLibelle(libellePoste);
    }
}