package com.example.entreprise.service;

import com.example.entreprise.entity.Diplome;
import com.example.entreprise.repository.DiplomeRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Service
public class DiplomeService {
    @Autowired
    private DiplomeRepository diplomeRepository;

    public List<Diplome> findAll() {
        return diplomeRepository.findAll();
    }

    public Diplome findById(Long diplomeId) {
        return diplomeRepository.findById(diplomeId).get();
    }
}
