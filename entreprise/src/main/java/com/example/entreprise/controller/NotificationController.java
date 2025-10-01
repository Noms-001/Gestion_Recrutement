package com.example.entreprise.controller;

import java.util.*;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.entreprise.service.NotificationService;

@RestController
@RequestMapping("/api")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping("/notifications")
    public Map<String, Object> getNotifications(@RequestParam("id_utilisateur") Long idUtilisateur) {
        Map<String, Object> response = new HashMap<>();
        response.put("notifications", notificationService.getNotificationsByUtilisateurId(idUtilisateur));
        response.put("notificationCount", notificationService.countUnreadNotifications(idUtilisateur));
        return response;
    }

}
