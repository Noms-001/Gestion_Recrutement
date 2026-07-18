package com.example.entreprise.repository;

import com.example.entreprise.entity.AnnonceCompetence;
import com.example.entreprise.entity.AnnonceCompetenceId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public interface AnnonceCompetenceRepository extends JpaRepository<AnnonceCompetence, AnnonceCompetenceId> {
    boolean existsById_IdAnnonceAndId_IdCompetence(Long idAnnonce, Long idCompetence);
    @Query("SELECT ac FROM AnnonceCompetence ac JOIN FETCH ac.competence WHERE ac.annonce.id = :annonceId")
    List<AnnonceCompetence> findByAnnonceIdWithCompetence(@Param("annonceId") Long annonceId);
    
    void deleteById_IdAnnonceAndId_IdCompetence(Long annonceId, Long competenceId);
    
    void deleteById_IdAnnonce(Long annonceId);
}
