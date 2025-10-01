package com.example.entreprise.repository;

import com.example.entreprise.entity.Education;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EducationRepository extends JpaRepository<Education, Long> {
    List<Education> findByCandidatId(Long candidatId);
    void deleteByCandidatId(Long candidatId);
}
