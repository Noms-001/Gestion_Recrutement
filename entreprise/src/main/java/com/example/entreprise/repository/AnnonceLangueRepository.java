package com.example.entreprise.repository;

import com.example.entreprise.entity.AnnonceLangue;
import com.example.entreprise.entity.AnnonceLangueId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnnonceLangueRepository extends JpaRepository<AnnonceLangue, AnnonceLangueId> {

    // Filtre par ville via la relation Annonce
    List<AnnonceLangue> findByAnnonceVilleId(Long villeId);
}
