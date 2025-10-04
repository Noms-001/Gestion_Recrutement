package com.example.entreprise.repository;

import com.example.entreprise.entity.Poste;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface PosteRepository extends JpaRepository<Poste, Long> {
    
    Optional<Poste> findByLibelle(String libelle);
    
    // CORRECTION : Trouver les postes vacants (sans employé ET sans annonce active)
    @Query("SELECT p FROM Poste p WHERE p.id NOT IN (" +
           "SELECT e.poste.id FROM Employe e WHERE e.poste IS NOT NULL" +
           ") AND p.id NOT IN (" +
           "SELECT a.poste.id FROM Annonce a WHERE a.ferme = false AND (a.dateLimite IS NULL OR a.dateLimite >= CURRENT_DATE)" +
           ")")
    List<Poste> findPostesVacants();
    
    // CORRECTION : Trouver les postes vacants avec filtre par département
    @Query("SELECT p FROM Poste p WHERE p.id NOT IN (" +
           "SELECT e.poste.id FROM Employe e WHERE e.poste IS NOT NULL" +
           ") AND p.id NOT IN (" +
           "SELECT a.poste.id FROM Annonce a WHERE a.ferme = false AND (a.dateLimite IS NULL OR a.dateLimite >= CURRENT_DATE)" +
           ") AND p.departement.id = :departementId")
    List<Poste> findPostesVacantsByDepartement(@Param("departementId") Long departementId);
    
    // CORRECTION : Trouver les postes vacants par nom de département
    @Query("SELECT p FROM Poste p WHERE p.id NOT IN (" +
           "SELECT e.poste.id FROM Employe e WHERE e.poste IS NOT NULL" +
           ") AND p.id NOT IN (" +
           "SELECT a.poste.id FROM Annonce a WHERE a.ferme = false AND (a.dateLimite IS NULL OR a.dateLimite >= CURRENT_DATE)" +
           ") AND p.departement.nom = :departementNom")
    List<Poste> findPostesVacantsByDepartementNom(@Param("departementNom") String departementNom);
    
    // CORRECTION : Vérifier si un poste spécifique est vacant
    @Query("SELECT CASE WHEN COUNT(p) = 0 THEN true ELSE false END FROM Poste p WHERE p.id = :posteId " +
           "AND (p.id IN (SELECT e.poste.id FROM Employe e WHERE e.poste IS NOT NULL) " +
           "OR p.id IN (SELECT a.poste.id FROM Annonce a WHERE a.ferme = false AND (a.dateLimite IS NULL OR a.dateLimite >= CURRENT_DATE)))")
    boolean isPosteOccupe(@Param("posteId") Long posteId);
    
    // CORRECTION : Vérifier si un poste spécifique est vacant par libellé
    @Query("SELECT CASE WHEN COUNT(p) = 0 THEN true ELSE false END FROM Poste p WHERE p.libelle = :libellePoste " +
           "AND (p.id IN (SELECT e.poste.id FROM Employe e WHERE e.poste IS NOT NULL) " +
           "OR p.id IN (SELECT a.poste.id FROM Annonce a WHERE a.ferme = false AND (a.dateLimite IS NULL OR a.dateLimite >= CURRENT_DATE)))")
    boolean isPosteOccupeByLibelle(@Param("libellePoste") String libellePoste);
}