package com.example.entreprise.repository;

import com.example.entreprise.entity.Employe;
import com.example.entreprise.entity.Entretien;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EntretienRepository extends JpaRepository<Entretien, Long> {
    List<Entretien> findByEmployeAndDateEntretienBetween(Employe employe, LocalDateTime start, LocalDateTime end);
}
