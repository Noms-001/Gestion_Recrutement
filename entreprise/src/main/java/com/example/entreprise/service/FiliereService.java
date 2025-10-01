package com.example.entreprise.service;

import com.example.entreprise.entity.Filiere;
import com.example.entreprise.repository.FiliereRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Service
public class FiliereService {
    @Autowired
    private FiliereRepository filiereRepository;

    public List<Filiere> findAll() {
        return filiereRepository.findAll();
    }

    public Filiere findById(Long filiereId) {
        return filiereRepository.findById(filiereId).get();
    }
}
