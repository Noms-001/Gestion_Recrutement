package com.example.entreprise.repository;

import com.example.entreprise.entity.Candidature;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CandidatureRepository extends JpaRepository<Candidature, Long> {
    
    Optional<Candidature> findByCandidatIdAndAnnonceId(Long candidatId, Long annonceId);
    
    @Query("SELECT COUNT(c) FROM Candidature c WHERE c.annonce.id = :annonceId")
    long countByAnnonceId(@Param("annonceId") Long annonceId);

    List<Candidature> findByAnnonceId(Long annonceId);
}