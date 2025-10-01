package com.example.entreprise.service;

import com.example.entreprise.entity.Poste;
import com.example.entreprise.repository.PosteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PosteService {

    @Autowired
    private PosteRepository posteRepository;

    public List<Poste> getAll() {
        return posteRepository.findAll();
    }
}

