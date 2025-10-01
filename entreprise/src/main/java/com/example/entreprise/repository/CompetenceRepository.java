package com.example.entreprise.repository;

import com.example.entreprise.entity.Competence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CompetenceRepository extends JpaRepository<Competence, Long> {
    List<Competence> findByCandidats_Id(Long candidatId);
    void deleteByCandidats_Id(Long candidatId);
    Optional<Competence> findByLibelle(String libelle);
}
