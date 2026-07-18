package com.example.entreprise.service;

import java.util.*;

import org.springframework.stereotype.Service;

import com.example.entreprise.entity.Notification;
import com.example.entreprise.entity.Utilisateur;
import com.example.entreprise.repository.NotificationRepository;
import com.example.entreprise.repository.UtilisateurRepository;
import org.springframework.transaction.annotation.Transactional;

@Service
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final UtilisateurRepository utilisateurRepository;

    public NotificationService(NotificationRepository notificationRepository,
            UtilisateurRepository utilisateurRepository) {
        this.notificationRepository = notificationRepository;
        this.utilisateurRepository = utilisateurRepository;
    }

    public List<Map<String, Object>> getNotificationsByUtilisateurId(Long idUtilisateur) {
        Utilisateur utilisateur = utilisateurRepository.findById(idUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
        List<Notification> notifications = notificationRepository.findByUtilisateurOrderByCreatedAtDesc(utilisateur);
        List<Map<String, Object>> messages = new ArrayList<>();
        for ( Notification n : notifications) {
            Map<String, Object> message = new HashMap<>();
            message.put("message", n.getMessage());
            message.put("createdAt", n.getCreatedAt());
            message.put("titre", n.getTitre());
            messages.add(message);
        }
        return messages;
    }

    public long countUnreadNotifications(Long idUtilisateur) {
        Utilisateur utilisateur = utilisateurRepository.findById(idUtilisateur)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
        return notificationRepository.countUnreadByUtilisateur(utilisateur);
    }

    @Transactional
    public void markAllReadByUtilisateur(Long utilisateurId) {
        notificationRepository.setAllReadByUtilisateur(utilisateurId);
    }

}
