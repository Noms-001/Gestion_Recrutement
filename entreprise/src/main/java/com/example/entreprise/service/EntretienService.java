package com.example.entreprise.service;

import com.example.entreprise.dto.EntretienDTO;
import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;
import java.time.*;

import org.springframework.transaction.annotation.Transactional;
@Service
@Transactional
public class EntretienService {

    @Autowired
    private EntretienRepository entretienRepository;
    
    @Autowired
    private CandidatureRepository candidatureRepository;
    
    @Autowired
    private EmployeRepository employeRepository;
    
    @Autowired
    private NotificationRepository notificationRepository;

    public List<EntretienDTO> getAllInterviews() {
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

        return entretienRepository.findAll().stream().map(entretien -> {
            var candidature = entretien.getCandidature();
            var candidat = candidature.getCandidat();
            var annonce = candidature.getAnnonce();
            var employe = entretien.getEmploye();

            var utilisateurCandidat = candidat.getUtilisateur();
            var utilisateurEmploye = employe.getUtilisateur();

            String date = entretien.getDateEntretien() != null
                    ? entretien.getDateEntretien().format(dateFormatter)
                    : "";
            String time = entretien.getDateEntretien() != null
                    ? entretien.getDateEntretien().format(timeFormatter)
                    : "";

            return new EntretienDTO(
                date,
                utilisateurCandidat.getPrenom() + " " + utilisateurCandidat.getNom(),
                utilisateurEmploye.getPrenom() + " " + utilisateurEmploye.getNom(),
                annonce.getPoste().getLibelle(),
                time,
                candidat.getPhoto()
            );
        }).collect(Collectors.toList());
    }

    public void plannifyInterview(Long candidatureId) {
        // Récupérer la candidature du candidat
        Candidature candidature = candidatureRepository.findById(candidatureId)
                .orElseThrow(() -> new RuntimeException("Candidature non trouvée"));
        
        // Vérifier si l'annonce est toujours active
        Annonce annonce = candidature.getAnnonce();
        if (annonce == null || !annonce.isActive()) {
            throw new RuntimeException("L'annonce n'est plus active");
        }
        
        // Récupérer tous les employés évaluateurs
        List<Employe> evaluateurs = employeRepository.findAll();
        if (evaluateurs.isEmpty()) {
            throw new RuntimeException("Aucun évaluateur disponible");
        }
        
        // Calculer la date de début (date limite + 1 jour)
        LocalDate dateDebut = annonce.getDateLimite().plusDays(1);
        
        // Trouver le premier créneau disponible
        LocalDateTime creneauDisponible = trouverCreneauDisponible(dateDebut, evaluateurs);
        
        if (creneauDisponible == null) {
            throw new RuntimeException("Aucun créneau disponible trouvé dans les 30 prochains jours");
        }
        
        // Sélectionner un évaluateur disponible pour ce créneau
        Employe evaluateur = trouverEvaluateurDisponible(evaluateurs, creneauDisponible);
        
        if (evaluateur == null) {
            throw new RuntimeException("Aucun évaluateur disponible pour le créneau trouvé");
        }
        
        // Créer et sauvegarder le nouvel entretien
        Entretien entretien = new Entretien();
        entretien.setCandidature(candidature);
        entretien.setEmploye(evaluateur);
        entretien.setDateEntretien(creneauDisponible);
        
        // Initialiser les scores à 0
        entretien.setScoreComportemental(0.0);
        entretien.setScoreCulturel(0.0);
        entretien.setScoreTechnique(0.0);
        
        // Sauvegarder l'entretien
        entretienRepository.save(entretien);
        
        // Envoyer la notification au candidat
        envoyerNotificationCandidat(candidature, creneauDisponible);
        
    }
    
    private LocalDateTime trouverCreneauDisponible(LocalDate dateDebut, List<Employe> evaluateurs) {
        LocalDate currentDate = dateDebut;
        
        // Chercher sur les 30 prochains jours (jours ouvrables uniquement)
        for (int i = 0; i < 30; i++) {
            // Vérifier si c'est un jour ouvrable (lundi à vendredi)
            if (currentDate.getDayOfWeek().getValue() >= 1 && currentDate.getDayOfWeek().getValue() <= 5) {
                LocalDateTime creneau = trouverCreneauDansJournee(currentDate, evaluateurs);
                if (creneau != null) {
                    return creneau;
                }
            }
            currentDate = currentDate.plusDays(1);
        }
        
        return null;
    }
    
    private LocalDateTime trouverCreneauDansJournee(LocalDate date, List<Employe> evaluateurs) {
        // Créneaux matin: 8h00, 8h40, 9h20, 10h00, 10h40
        LocalTime[] creneauxMatin = {
            LocalTime.of(8, 0), LocalTime.of(8, 40), LocalTime.of(9, 20),
            LocalTime.of(10, 0), LocalTime.of(10, 40)
        };
        
        // Créneaux après-midi: 14h00, 14h40, 15h20, 16h00, 16h40
        LocalTime[] creneauxApresMidi = {
            LocalTime.of(14, 0), LocalTime.of(14, 40), LocalTime.of(15, 20),
            LocalTime.of(16, 0), LocalTime.of(16, 40)
        };
        
        // Vérifier les créneaux du matin
        for (LocalTime heure : creneauxMatin) {
            LocalDateTime creneau = LocalDateTime.of(date, heure);
            if (estCreneauDisponible(evaluateurs, creneau)) {
                return creneau;
            }
        }
        
        // Vérifier les créneaux de l'après-midi
        for (LocalTime heure : creneauxApresMidi) {
            LocalDateTime creneau = LocalDateTime.of(date, heure);
            if (estCreneauDisponible(evaluateurs, creneau)) {
                return creneau;
            }
        }
        
        return null;
    }
    
    private boolean estCreneauDisponible(List<Employe> evaluateurs, LocalDateTime creneau) {
        for (Employe evaluateur : evaluateurs) {
            if (!aEntretienPrevu(evaluateur, creneau)) {
                return true;
            }
        }
        return false;
    }
    
    private boolean aEntretienPrevu(Employe evaluateur, LocalDateTime creneau) {
        // Vérifier si l'évaluateur a déjà un entretien à ce créneau
        LocalDateTime finCreneau = creneau.plusMinutes(40);
        
        List<Entretien> entretiens = entretienRepository.findByEmployeAndDateEntretienBetween(
            evaluateur, 
            creneau.toLocalDate().atStartOfDay(),
            creneau.toLocalDate().atTime(23, 59)
        );
        
        for (Entretien entretien : entretiens) {
            LocalDateTime debutEntretien = entretien.getDateEntretien();
            LocalDateTime finEntretien = debutEntretien.plusMinutes(40);
            
            // Vérifier le chevauchement
            if (creneau.isBefore(finEntretien) && finCreneau.isAfter(debutEntretien)) {
                return true;
            }
        }
        
        return false;
    }
    
    private Employe trouverEvaluateurDisponible(List<Employe> evaluateurs, LocalDateTime creneau) {
        for (Employe evaluateur : evaluateurs) {
            if (!aEntretienPrevu(evaluateur, creneau)) {
                return evaluateur;
            }
        }
        return null;
    }
    
    private void envoyerNotificationCandidat(Candidature candidature, LocalDateTime creneau) {
        Notification notification = new Notification();
        notification.setUtilisateur(candidature.getCandidat().getUtilisateur());
        notification.setMessage(String.format(
            "Votre entretien pour le poste '%s' est planifié pour le %s à %s. (Durée: 40 minutes)",
            candidature.getAnnonce().getPoste().getLibelle(),
            creneau.toLocalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")),
            creneau.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm"))
        ));
        notification.setLu(false);
        notification.setTitre("Entretien confirmé");
        notification.setCreatedAt(LocalDateTime.now());
        
        notificationRepository.save(notification);
    }
}