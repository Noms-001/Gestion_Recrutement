package com.example.entreprise.repository;

import com.example.entreprise.entity.AnnonceCompetence;
import com.example.entreprise.entity.AnnonceCompetenceId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AnnonceCompetenceRepository extends JpaRepository<AnnonceCompetence, AnnonceCompetenceId> {
    boolean existsById_IdAnnonceAndId_IdCompetence(Long idAnnonce, Long idCompetence);
}
