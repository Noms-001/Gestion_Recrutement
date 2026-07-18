package com.example.entreprise.repository;

import com.example.entreprise.entity.*;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface EducationRepository extends JpaRepository<Education, Long> {
    List<Education> findByCandidatId(Long candidatId);
    void deleteByCandidatId(Long candidatId);
    @Query("SELECT e FROM Education e WHERE e.candidat = :candidat AND e.filiere = :filiere")
    List<Education> findByCandidatAndFiliere(@Param("candidat") Candidat candidat, 
                                           @Param("filiere") Filiere filiere);
}
