package com.example.entreprise.repository;

import com.example.entreprise.entity.Candidat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface CandidatRepository extends JpaRepository<Candidat, Long> {
    Optional<Candidat> findByUtilisateurId(Long utilisateurId);
    @Query("SELECT c FROM Candidat c " +
           "LEFT JOIN FETCH c.utilisateur u " +
           "LEFT JOIN FETCH u.genre " +
           "LEFT JOIN FETCH c.ville " +
           "LEFT JOIN FETCH c.educations e " +
           "LEFT JOIN FETCH e.diplome " +
           "LEFT JOIN FETCH c.experiences " +
           "LEFT JOIN FETCH c.competences " +
           "LEFT JOIN FETCH c.langues " +
           "WHERE c.id = :id")
    Optional<Candidat> findByIdWithDetails(@Param("id") Long id);
}
