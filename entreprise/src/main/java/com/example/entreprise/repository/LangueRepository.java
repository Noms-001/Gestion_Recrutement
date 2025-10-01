package com.example.entreprise.repository;

import com.example.entreprise.entity.Langue;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface LangueRepository extends JpaRepository<Langue, Long> {
    List<Langue> findByCandidats_Id(Long candidatId);
    void deleteByCandidats_Id(Long candidatId);
    Optional<Langue> findByLibelle(String libelle);
}
