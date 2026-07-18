package com.example.entreprise.controller.rest;

import com.example.entreprise.entity.*;

import com.example.entreprise.service.*;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/candidat")
public class CandidatRestController {

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

        // ------------------ GET CV ------------------
        @GetMapping("/{id}")
        public ResponseEntity<Map<String, Object>> getCvPreview(@PathVariable Long id) {
                Candidat candidat = candidatService.findByUtilisateurId(id)
                                .orElseThrow(() -> new RuntimeException("Candidat non trouvé"));
                Utilisateur utilisateur = candidat.getUtilisateur();

                String[] mois = {
                                "Jan.", "Fev.", "Mar.", "Avr.", "Mai.", "Jui.",
                                "Jul.", "Aou.", "Sep.", "Oct.", "Nov.", "Dec."
                };

                // Déterminer le genre pour adapter le summary
                String genreLibelle = utilisateur.getGenre() != null ? utilisateur.getGenre().getLibelle() : "Homme";
                boolean isFeminine = genreLibelle.equalsIgnoreCase("Femme") || genreLibelle.equalsIgnoreCase("Femme");

                // Summary générique
                String summary = isFeminine
                                ? "Professionnelle motivée et polyvalente, dotée de compétences variées et d'une volonté d'apprendre en continu."
                                : "Professionnel motivé et polyvalent, doté de compétences variées et d'une volonté d'apprendre en continu.";

                // Construire la réponse JSON
                Map<String, Object> response = new HashMap<>();
                response.put("photo", candidat.getPhoto() != null ? candidat.getPhoto() : "");
                response.put("prenom", utilisateur.getPrenom());
                response.put("nom", utilisateur.getNom());
                response.put("role", "Candidat"); // ou un champ métier si disponible
                response.put("email", utilisateur.getEmail());
                response.put("phone", candidat.getTelephone() != null ? candidat.getTelephone() : "");
                response.put("location", candidat.getAdresse() != null ? candidat.getAdresse() : "");
                response.put("summary", summary);

                // Expériences
                List<Map<String, Object>> experiencesList = new ArrayList<>();
                if (candidat.getExperiences() != null) {
                        for (Experience e : candidat.getExperiences()) {
                                Map<String, Object> expMap = new HashMap<>();
                                expMap.put("company", e.getLieu());
                                expMap.put("title", e.getFiliere() != null ? e.getFiliere().getLibelle() : "");
                                expMap.put("start", e.getDebutAnnee() != null && e.getDebutMois() != null
                                                ? mois[e.getDebutMois() - 1] + " " + e.getDebutAnnee()
                                                : "");
                                expMap.put("end", e.getFinAnnee() != null && e.getFinMois() != null
                                                ? mois[e.getFinMois() - 1] + " " + e.getFinAnnee()
                                                : "");
                                expMap.put("desc", e.getDescription() != null ? e.getDescription() : "");
                                experiencesList.add(expMap);
                        }
                }
                response.put("experiences", experiencesList);

                // Education
                List<Map<String, Object>> educationsList = new ArrayList<>();
                if (candidat.getEducations() != null) {
                        for (Education ed : candidat.getEducations()) {
                                Map<String, Object> eduMap = new HashMap<>();
                                eduMap.put("school", ed.getLieu() != null ? ed.getLieu() : "");
                                eduMap.put("degree",
                                                ed.getDiplome() != null
                                                                ? ed.getDiplome().getLibelle() + " en "
                                                                                + ed.getFiliere().getLibelle()
                                                                : "");
                                eduMap.put("start", ed.getAnneeDebut() != null ? ed.getAnneeDebut().toString() : "");
                                eduMap.put("end", ed.getAnneeFin() != null ? ed.getAnneeFin().toString() : "");
                                educationsList.add(eduMap);
                        }
                }
                response.put("education", educationsList);

                // Compétences
                List<String> skillsList = new ArrayList<>();
                if (candidat.getCompetences() != null) {
                        for (Competence c : candidat.getCompetences()) {
                                skillsList.add(c.getLibelle());
                        }
                }
                response.put("skills", skillsList);

                // Langues
                List<String> languagesList = new ArrayList<>();
                if (candidat.getLangues() != null) {
                        for (Langue l : candidat.getLangues()) {
                                languagesList.add(l.getLibelle());
                        }
                }
                response.put("languages", languagesList);

                return ResponseEntity.ok(response);
        }

        @GetMapping("/{id}/cv")
        public ResponseEntity<Map<String, Object>> getCv(@PathVariable Long id) {
                Candidat candidat = candidatService.findById(id).get();
                if (candidat == null)
                        return ResponseEntity.notFound().build();

                Map<String, Object> response = new HashMap<>();
                response.put("experiences", candidat.getExperiences().stream()
                                .map(e -> Map.of(
                                                "start", e.getDebutAnnee() != null && e.getDebutMois() != null
                                                                ? String.format("%04d-%02d", e.getDebutAnnee(),
                                                                                e.getDebutMois())
                                                                : "",
                                                "end", e.getFinAnnee() != null && e.getFinMois() != null
                                                                ? String.format("%04d-%02d", e.getFinAnnee(),
                                                                                e.getFinMois())
                                                                : "",
                                                "company", e.getLieu() != null ? e.getLieu() : "",
                                                "field", e.getFiliere() != null ? e.getFiliere().getId() : "",
                                                "fieldLabel", e.getFiliere() != null ? e.getFiliere().getLibelle() : "",
                                                "description", e.getDescription() != null ? e.getDescription() : ""))
                                .collect(Collectors.toList()));

                response.put("educations", candidat.getEducations().stream()
                                .map(ed -> Map.of(
                                                "degree", ed.getDiplome() != null ? ed.getDiplome().getId() : "",
                                                "degreeLabel",
                                                ed.getDiplome() != null ? ed.getDiplome().getLibelle() : "",
                                                "major", ed.getFiliere() != null ? ed.getFiliere().getId() : "",
                                                "majorLabel",
                                                ed.getFiliere() != null ? ed.getFiliere().getLibelle() : "",
                                                "startYear", ed.getAnneeDebut(),
                                                "endYear", ed.getAnneeFin(),
                                                "school", ed.getLieu() != null ? ed.getLieu() : ""))
                                .collect(Collectors.toList()));

                response.put("skills", candidat.getCompetences().stream()
                                .map(c -> Map.of("id", c.getId(), "label", c.getLibelle()))
                                .collect(Collectors.toList()));

                response.put("languages", candidat.getLangues().stream()
                                .map(l -> Map.of("id", l.getId(), "label", l.getLibelle()))
                                .collect(Collectors.toList()));

                return ResponseEntity.ok(response);
        }

        // ------------------ POST CV ------------------
        @PostMapping("/{id}/cv")
        public ResponseEntity<?> saveCv(@PathVariable Long id, @RequestBody Map<String, Object> payload) {
                try {
                        Map<String, Object> personalData = (Map<String, Object>) payload.get("personalData");
                        List<Map<String, Object>> experiences = (List<Map<String, Object>>) payload.get("experiences");
                        List<Map<String, Object>> educations = (List<Map<String, Object>>) payload.get("educations");
                        List<Map<String, Object>> skills = (List<Map<String, Object>>) payload.get("skills");
                        List<Map<String, Object>> languages = (List<Map<String, Object>>) payload.get("languages");

                        candidatService.saveCv(id, personalData, experiences, educations, skills, languages);

                        return ResponseEntity.ok(Map.of("message", "CV sauvegardé avec succès"));
                } catch (Exception e) {
                        return ResponseEntity.status(500).body(Map.of("message", e.getMessage()));
                }
        }

}
