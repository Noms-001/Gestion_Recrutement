package com.example.entreprise.service;

import com.example.entreprise.entity.Ville;
import com.example.entreprise.repository.VilleRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Service
public class VilleService {
    @Autowired
    private VilleRepository villeRepository;

    public List<Ville> findAll() {
        return villeRepository.findAll();
    }
}
