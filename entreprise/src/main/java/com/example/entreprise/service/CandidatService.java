package com.example.entreprise.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entreprise.entity.Candidat;
import com.example.entreprise.repository.CandidatRepository;


@Service
public class CandidatService {

    @Autowired
    private CandidatRepository candidatRepository;

    public Optional<Candidat> findByUtilisateurId(Long utilisateurId) {
        return candidatRepository.findByUtilisateurId(utilisateurId);
    }

    public Candidat save(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    public Optional<Candidat> findById(Long candidatId) {
        return candidatRepository.findById(candidatId);
    }
}
