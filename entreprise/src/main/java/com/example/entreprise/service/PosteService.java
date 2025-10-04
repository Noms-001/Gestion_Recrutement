package com.example.entreprise.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entreprise.entity.Poste;
import com.example.entreprise.repository.PosteRepository;

@Service
public class PosteService {

    @Autowired
    private PosteRepository posteRepository;

    public List<Poste> findAll() {
        return posteRepository.findAll();
    }
}

