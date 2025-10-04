package com.example.entreprise.repository;

import com.example.entreprise.entity.AnnonceLangue;
import com.example.entreprise.entity.AnnonceLangueId;
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
}