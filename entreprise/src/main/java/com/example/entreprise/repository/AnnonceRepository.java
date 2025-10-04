package com.example.entreprise.repository;

import com.example.entreprise.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public interface AnnonceRepository extends JpaRepository<Annonce, Long> {

    @Query("SELECT a FROM Annonce a " +
           "WHERE (:villeId IS NULL OR a.ville.id = :villeId) " +
           "AND (:departementId IS NULL OR a.poste.departement.id = :departementId) " +
           "AND (:poste IS NULL OR LOWER(a.poste.libelle) LIKE LOWER(CONCAT('%', :poste, '%'))) " +
           "AND (:status IS NULL OR " +
           "     (:status = 'active' AND a.ferme = false AND a.dateLimite >= (CURRENT_DATE)) OR " +
           "     (:status = 'expiree' AND a.ferme = false AND a.dateLimite < (CURRENT_DATE)) OR " +
           "     (:status = 'fermee' AND a.ferme = true))")
    List<Annonce> findByFilters(
            @Param("villeId") Long villeId,
            @Param("departementId") Long departementId,
            @Param("poste") String poste,
            @Param("status") String status
    );
    @Query("SELECT a FROM Annonce a WHERE a.id = :id")
    Optional<Annonce> findByIdWithDetails(@Param("id") Long id);
    
    List<Annonce> findByPosteId(Long posteId);
}

