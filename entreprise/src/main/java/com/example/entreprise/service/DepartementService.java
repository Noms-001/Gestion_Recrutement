package com.example.entreprise.service;

import com.example.entreprise.entity.Departement;
import com.example.entreprise.repository.DepartementRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Service
public class DepartementService {
    @Autowired
    private DepartementRepository departementRepository;

    public DepartementService(DepartementRepository departementRepository) {
        this.departementRepository = departementRepository;
    }

    public List<Departement> findAll() {
        return departementRepository.findAll();
    }
}
