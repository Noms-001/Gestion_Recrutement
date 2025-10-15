package com.example.entreprise.controller.rest;

import java.util.*;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.entreprise.service.NotificationService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/notifications")
public class NotificationRestController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public Map<String, Object> getNotifications(@RequestParam("id_utilisateur") Long idUtilisateur) {
        Map<String, Object> response = new HashMap<>();
        response.put("notifications", notificationService.getNotificationsByUtilisateurId(idUtilisateur));
        response.put("notificationCount", notificationService.countUnreadNotifications(idUtilisateur));
        return response;
    }

    @GetMapping("/read")
    public void read(HttpSession session) {
        Long utilisateurId = (Long) session.getAttribute("id_utilisateur");
        notificationService.markAllReadByUtilisateur(utilisateurId);
    }

}
