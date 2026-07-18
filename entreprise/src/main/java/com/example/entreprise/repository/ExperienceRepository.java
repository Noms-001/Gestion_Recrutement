package com.example.entreprise.repository;

import com.example.entreprise.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface ExperienceRepository extends JpaRepository<Experience, Long> {
    List<Experience> findByCandidatId(Long candidatId);
    void deleteByCandidatId(Long candidatId);
    @Query("SELECT e FROM Experience e WHERE e.candidat = :candidat AND e.filiere = :filiere")
    List<Experience> findByCandidatAndFiliere(@Param("candidat") Candidat candidat, 
                                            @Param("filiere") Filiere filiere);
}
