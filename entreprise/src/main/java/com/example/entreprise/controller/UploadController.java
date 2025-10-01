package com.example.entreprise.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.entreprise.entity.Candidat;
import com.example.entreprise.service.CandidatService;

import jakarta.servlet.http.HttpSession;

@RestController
public class UploadController {

    @Autowired
    private CandidatService candidatService;

    @PostMapping("/upload-photo")
    public boolean uploadPhoto(@RequestParam("photo") MultipartFile file,
            HttpSession session) throws IOException {
        Long idUtilisateur = (Long) session.getAttribute("id_utilisateur");
        if (idUtilisateur == null)
            return false;

        if (!file.isEmpty()) {
            // Générer un nom unique
            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            Path uploadPath = Paths.get("src/main/webapp/resources/img/uploads/");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Sauvegarde du fichier
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Sauvegarde du chemin en BDD
            Candidat candidat = candidatService.findByUtilisateurId(idUtilisateur).get();
            candidat.setPhoto("resources/img/uploads/" + fileName);
            candidatService.save(candidat);
        }
        return true;
    }

}
