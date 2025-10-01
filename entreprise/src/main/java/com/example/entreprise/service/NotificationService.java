package com.example.entreprise.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.entreprise.entity.Notification;
import com.example.entreprise.entity.Utilisateur;
import com.example.entreprise.repository.NotificationRepository;
import com.example.entreprise.repository.UtilisateurRepository;

@Service
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final UtilisateurRepository utilisateurRepository;

    public NotificationService(NotificationRepository notificationRepository,
            UtilisateurRepository utilisateurRepository) {
        this.notificationRepository = notificationRepository;
        this.utilisateurRepository = utilisateurRepository;
    }

    public List<Notification> getNotificationsByUtilisateurId(Long idUtilisateur) {
        Utilisateur utilisateur = utilisateurRepository.findById(idUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
        return notificationRepository.findByUtilisateurOrderByCreatedAtDesc(utilisateur);
    }

    public long countUnreadNotifications(Long idUtilisateur) {
        Utilisateur utilisateur = utilisateurRepository.findById(idUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
        return notificationRepository.countUnreadByUtilisateur(utilisateur);
    }

}
