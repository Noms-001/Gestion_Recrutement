package com.example.entreprise.repository;

import com.example.entreprise.entity.Reponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface ReponseRepository extends JpaRepository<Reponse, Long> {
    Optional<Reponse> findFirstByValeur(String valeur);
}
