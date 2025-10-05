package com.example.entreprise.repository;

import com.example.entreprise.entity.Candidature;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatureRepository extends JpaRepository<Candidature, Long> {
    boolean existsByCandidatIdAndAnnonceId(Long candidatId, Long annonceId);
}
