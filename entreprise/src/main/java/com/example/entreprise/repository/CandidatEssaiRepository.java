package com.example.entreprise.repository;

import com.example.entreprise.entity.CandidatEssai;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatEssaiRepository extends JpaRepository<CandidatEssai, Long> {
}
