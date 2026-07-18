package com.example.entreprise.repository;

import com.example.entreprise.entity.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GenreRepository extends JpaRepository<Genre, Long> {
    Optional<Genre> findByLibelle(String libelle);
}
