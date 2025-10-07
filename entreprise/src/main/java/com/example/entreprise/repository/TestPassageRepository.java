package com.example.entreprise.repository;

import com.example.entreprise.entity.Test;
import com.example.entreprise.entity.TestPassage;
import com.example.entreprise.entity.TestPassageId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TestPassageRepository extends JpaRepository<TestPassage, TestPassageId> {
    
    @Query("SELECT tp FROM TestPassage tp WHERE tp.candidat.id = :candidatId AND tp.annonce.id = :annonceId")
    Optional<TestPassage> findByCandidatIdAndTestId(@Param("candidatId") Long candidatId, @Param("annonceId") Long annonceId);
    
    boolean existsByCandidatIdAndAnnonceId(Long candidatId, Long AnnonceId);
}