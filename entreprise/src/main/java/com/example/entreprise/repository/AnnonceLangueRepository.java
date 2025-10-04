package com.example.entreprise.repository;

import com.example.entreprise.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnnonceLangueRepository extends JpaRepository<AnnonceLangue, AnnonceLangueId> {
    boolean existsById_IdAnnonceAndId_IdLangue(Long idAnnonce, Long idLangue);
    // Filtre par ville via la relation Annonce
    List<AnnonceLangue> findByAnnonceVilleId(Long villeId);
    @Query("SELECT al FROM AnnonceLangue al JOIN FETCH al.langue WHERE al.annonce.id = :annonceId")
    List<AnnonceLangue> findByAnnonceIdWithLangue(@Param("annonceId") Long annonceId);
    
    void deleteById_IdAnnonceAndId_IdLangue(Long annonceId, Long langueId);
    
    void deleteById_IdAnnonce(Long annonceId);
    // AnnonceRepository.java
    @Query("SELECT a FROM Annonce a WHERE " +
        "LOWER(a.poste.libelle) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
        "LOWER(a.description) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
        "LOWER(a.poste.departement.nom) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
        "LOWER(a.ville.nom) LIKE LOWER(CONCAT('%', :query, '%'))")
    List<Annonce> findBySearchQuery(@Param("query") String query);
}