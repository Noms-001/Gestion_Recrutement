package com.example.entreprise.repository;

import com.example.entreprise.entity.Poste;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PosteRepository extends JpaRepository<Poste, Long> {
    Optional<Poste> findByLibelle(String libelle);
}
