package com.example.entreprise.repository;

import com.example.entreprise.entity.Notification;
import com.example.entreprise.entity.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Modifying;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByUtilisateurOrderByCreatedAtDesc(Utilisateur utilisateur);

    // Compter notifications non lues (lu = false ou lu = null)
    @Query("SELECT COUNT(n) FROM Notification n WHERE n.utilisateur = :utilisateur AND (n.lu = false OR n.lu IS NULL)")
    long countUnreadByUtilisateur(@Param("utilisateur") Utilisateur utilisateur);

    @Modifying
    @Transactional
    @Query(value = "UPDATE notification SET lu = true WHERE id_utilisateur = :id", nativeQuery = true)
    void setAllReadByUtilisateur(@Param("id") Long utilisateurId);

}
