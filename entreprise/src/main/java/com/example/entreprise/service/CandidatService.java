package com.example.entreprise.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.entreprise.entity.Candidat;
import com.example.entreprise.entity.Competence;
import com.example.entreprise.entity.Diplome;
import com.example.entreprise.entity.Education;
import com.example.entreprise.entity.Experience;
import com.example.entreprise.entity.Filiere;
import com.example.entreprise.entity.Langue;
import com.example.entreprise.entity.Utilisateur;
import com.example.entreprise.entity.Ville;
import com.example.entreprise.repository.CandidatRepository;
import com.example.entreprise.repository.UtilisateurRepository;
import com.example.entreprise.repository.VilleRepository;
import java.util.*;

@Service
public class CandidatService {

    @Autowired
    private CandidatRepository candidatRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private ExperienceService experienceService;

    @Autowired
    private EducationService educationService;

    @Autowired
    private CompetenceService competenceService;

    @Autowired
    private LangueService langueService;

    @Autowired
    private FiliereService filiereService;

    @Autowired
    private VilleRepository villeRepository;

    @Autowired
    private DiplomeService diplomeService;

    // ------------------ GET CV ------------------
    public Map<String, Object> getCvByCandidatId(Long candidatId) {
        Candidat candidat = candidatRepository.findById(candidatId)
                .orElseThrow(() -> new RuntimeException("Candidat non trouvé"));

        Map<String, Object> cvData = new HashMap<>();
        cvData.put("experiences", experienceService.findByCandidatId(candidat.getId()));
        cvData.put("educations", educationService.findByCandidatId(candidat.getId()));
        cvData.put("skills", competenceService.findByCandidatId(candidat.getId()));
        cvData.put("languages", langueService.findByCandidatId(candidat.getId()));

        return cvData;
    }

    // ------------------ SAVE CV ------------------
    @Transactional
    public void saveCv(Long candidatId,
            Map<String, Object> personalData,
            List<Map<String, Object>> experiencesData,
            List<Map<String, Object>> educationsData,
            List<Map<String, Object>> skillsData,
            List<Map<String, Object>> languagesData) {

        Candidat candidat = candidatRepository.findById(candidatId)
                .orElseThrow(() -> new RuntimeException("Candidat non trouvé"));

        // ----------- Infos personnelles -----------
        if (personalData != null) {
            if (personalData.get("dateNaissance") != null && !personalData.get("dateNaissance").equals("")) {
                candidat.setDateNaissance(LocalDate.parse((String) personalData.get("dateNaissance")));
            }
            if (personalData.get("telephone") != null && !personalData.get("telephone").equals("")) {
                candidat.setTelephone((String) personalData.get("telephone"));
            }
            if (personalData.get("adresse") != null && !personalData.get("adresse").equals("")) {
                candidat.setAdresse((String) personalData.get("adresse"));
            }
            if (personalData.get("villeId") != null && !personalData.get("villeId").equals("")) {
                Long villeId = Long.valueOf(personalData.get("villeId").toString());
                Ville ville = villeRepository.findById(villeId)
                        .orElseThrow(() -> new RuntimeException("Ville non trouvée"));
                candidat.setVille(ville);
            }

            // ---- Mise à jour utilisateur lié ----
            Utilisateur u = candidat.getUtilisateur();
            if (personalData.get("nom") != null)
                u.setNom((String) personalData.get("nom"));
            if (personalData.get("prenom") != null)
                u.setPrenom((String) personalData.get("prenom"));
            if (personalData.get("email") != null)
                u.setEmail((String) personalData.get("email"));
            utilisateurRepository.save(u);
        }

        // ----------- Expériences -----------
        experienceService.deleteByCandidatId(candidatId);
        for (Map<String, Object> exp : experiencesData) {
            Experience e = new Experience();
            e.setCandidat(candidat);
            e.setLieu((String) exp.get("company"));

            if (exp.get("start") != null) {
                String[] startParts = ((String) exp.get("start")).split("-");
                e.setDebutAnnee(Integer.parseInt(startParts[0]));
                e.setDebutMois(Integer.parseInt(startParts[1]));
            }

            if (exp.get("end") != null) {
                String[] endParts = ((String) exp.get("end")).split("-");
                e.setFinAnnee(Integer.parseInt(endParts[0]));
                e.setFinMois(Integer.parseInt(endParts[1]));
            }

            e.setDescription((String) exp.get("description"));

            if (exp.get("field") != null) {
                Long filiereId = Long.valueOf(exp.get("field").toString());
                Filiere f = filiereService.findById(filiereId);
                e.setFiliere(f);
            }

            experienceService.save(e);
        }

        // ----------- Éducations -----------
        educationService.deleteByCandidatId(candidatId);
        for (Map<String, Object> edu : educationsData) {

            Education e = new Education();
            e.setCandidat(candidat);

            e.setLieu((String) edu.get("school"));
            if (edu.get("degree") != null) {
                Diplome diplome = diplomeService.findById(Long.valueOf(edu.get("degree").toString()));
                e.setDiplome(diplome);
            }
            if (edu.get("startYear") != null) {
                Integer anneeDebut = Integer.valueOf(edu.get("startYear").toString());
                e.setAnneeDebut(anneeDebut);
            }
            if (edu.get("endYear") != null) {
                Integer anneeFin = Integer.valueOf(edu.get("endYear").toString());
                e.setAnneeFin(anneeFin);
            }
            if (edu.get("major") != null) {
                Filiere filiere = filiereService.findById(Long.valueOf(edu.get("major").toString()));
                e.setFiliere(filiere);
            }

            educationService.save(e);
        }

        // ----------- Compétences (merge ManyToMany) -----------
        Set<Competence> newCompetences = skillsData.stream()
                .map(s -> {
                    String libelle = (String) s.get("label");
                    return competenceService.findByLibelle(libelle)
                            .orElseGet(() -> {
                                Competence c = new Competence();
                                c.setLibelle(libelle);
                                return competenceService.save(c);
                            });
                })
                .collect(Collectors.toSet());

        candidat.getCompetences().removeIf(c -> !newCompetences.contains(c));
        newCompetences.forEach(c -> {
            if (!candidat.getCompetences().contains(c)) {
                candidat.getCompetences().add(c);
            }
        });

        // ----------- Langues (merge ManyToMany) -----------
        Set<Langue> newLangues = languagesData.stream()
                .map(l -> {
                    String libelle = (String) l.get("label");
                    return langueService.findByLibelle(libelle)
                            .orElseGet(() -> {
                                Langue newLangue = new Langue();
                                newLangue.setLibelle(libelle);
                                return langueService.save(newLangue);
                            });
                })
                .collect(Collectors.toSet());

        candidat.getLangues().removeIf(l -> !newLangues.contains(l));
        newLangues.forEach(l -> {
            if (!candidat.getLangues().contains(l)) {
                candidat.getLangues().add(l);
            }
        });

        // ----------- Sauvegarde finale -----------
        candidatRepository.save(candidat);
    }

    public Optional<Candidat> findByUtilisateurId(Long utilisateurId) {
        return candidatRepository.findByUtilisateurId(utilisateurId);
    }

    public Candidat save(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    public Optional<Candidat> findById(Long candidatId) {
        return candidatRepository.findById(candidatId);
    }
}
