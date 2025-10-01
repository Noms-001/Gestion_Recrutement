package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Optional;

@Service
public class CompetenceService {
    @Autowired
    private CompetenceRepository competenceRepository;

    public List<Competence> findAll() {
        return competenceRepository.findAll();
    } 

    public List<Competence> findByCandidatId(Long candidatId) {
        return competenceRepository.findByCandidats_Id(candidatId);
    }

    public Optional<Competence> findByLibelle(String libelle) {
        return competenceRepository.findByLibelle(libelle);
    }

    public Competence save(Competence competence) {
        return competenceRepository.save(competence);
    }
}
