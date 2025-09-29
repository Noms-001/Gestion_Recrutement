package com.example.entreprise.repository;

import com.example.entreprise.entity.CandidatCompetence;
import com.example.entreprise.entity.CandidatCompetenceId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatCompetenceRepository extends JpaRepository<CandidatCompetence, CandidatCompetenceId> {
}
