package com.example.entreprise.repository;

import com.example.entreprise.entity.Experience;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public interface ExperienceRepository extends JpaRepository<Experience, Long> {
    List<Experience> findByCandidatId(Long candidatId);
    void deleteByCandidatId(Long candidatId);
}
