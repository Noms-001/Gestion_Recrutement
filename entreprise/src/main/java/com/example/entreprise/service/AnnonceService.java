package com.example.entreprise.service;

import com.example.entreprise.entity.Annonce;
import com.example.entreprise.repository.AnnonceRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Service
public class AnnonceService {
    @Autowired
    private AnnonceRepository repository;

    public List<Annonce> findAll() {
        return repository.findAll();
    }

    // Filtre combiné
    public List<Annonce> filter(Long villeId, Long departementId, String poste, String status) {
        return repository.findByFilters(villeId, departementId, poste, status);
    }
}
