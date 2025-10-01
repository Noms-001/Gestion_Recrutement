package com.example.entreprise.service;

import com.example.entreprise.entity.Langue;
import com.example.entreprise.repository.LangueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LangueService {

    @Autowired
    private LangueRepository langueRepository;

    public List<Langue> findAll() {
        return langueRepository.findAll();
    }

    public List<Langue> findByCandidatId(Long candidatId) {
        return langueRepository.findByCandidats_Id(candidatId);
    }

    public void deleteByCandidatId(Long candidatId) {
        langueRepository.deleteByCandidats_Id(candidatId);
    }

    public Optional<Langue> findByLibelle(String libelle) {
        return langueRepository.findByLibelle(libelle);
    }

    public Langue save(Langue langue) {
        return langueRepository.save(langue);
    }
}
