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

    @Query("SELECT a FROM Annonce a " +
           "LEFT JOIN FETCH a.poste p " +
           "LEFT JOIN FETCH p.departement " +
           "LEFT JOIN FETCH a.ville " +
           "LEFT JOIN FETCH a.diplome " + // JUSTE AJOUTÉ ICI
           "WHERE a.ferme = false " +
           "ORDER BY a.dateCreation DESC")
    List<Annonce> findAllActiveAnnonces();
    
    // Charger une annonce spécifique avec toutes les relations (pour les détails)
    @Query("SELECT a FROM Annonce a " +
           "LEFT JOIN FETCH a.poste p " +
           "LEFT JOIN FETCH p.departement " +
           "LEFT JOIN FETCH a.ville " +
           "LEFT JOIN FETCH a.diplome " + // JUSTE AJOUTÉ ICI
           "LEFT JOIN FETCH a.competences ac " +
           "LEFT JOIN FETCH ac.competence " +
           "WHERE a.id = :id AND a.ferme = false")
    Optional<Annonce> findByIdWithCompetences(@Param("id") Long id);
    
    // Alternative: charger une annonce avec langues
    @Query("SELECT a FROM Annonce a " +
           "LEFT JOIN FETCH a.poste p " +
           "LEFT JOIN FETCH p.departement " +
           "LEFT JOIN FETCH a.ville " +
           "LEFT JOIN FETCH a.diplome " + // JUSTE AJOUTÉ ICI
           "LEFT JOIN FETCH a.langues al " +
           "LEFT JOIN FETCH al.langue " +
           "WHERE a.id = :id AND a.ferme = false")
    Optional<Annonce> findByIdWithLangues(@Param("id") Long id);

    // Dans AnnonceRepository.java
@Query("SELECT DISTINCT a FROM Annonce a " +
       "LEFT JOIN a.poste p " +
       "LEFT JOIN p.departement d " +
       "LEFT JOIN a.ville v " +
       "LEFT JOIN a.competences ac " +
       "LEFT JOIN ac.competence c " +
       "LEFT JOIN a.langues al " +
       "LEFT JOIN al.langue l " +
       "WHERE a.ferme = false " +
       "AND (LOWER(p.libelle) LIKE LOWER(CONCAT('%', :query, '%')) " +
       "OR LOWER(a.description) LIKE LOWER(CONCAT('%', :query, '%')) " +
       "OR LOWER(d.nom) LIKE LOWER(CONCAT('%', :query, '%')) " +
       "OR LOWER(v.nom) LIKE LOWER(CONCAT('%', :query, '%')) " +
       "OR LOWER(c.libelle) LIKE LOWER(CONCAT('%', :query, '%')) " +
       "OR LOWER(l.libelle) LIKE LOWER(CONCAT('%', :query, '%'))) " +
       "ORDER BY a.dateCreation DESC")
List<Annonce> findBySearchQuery(@Param("query") String query);
}

