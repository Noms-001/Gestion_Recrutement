package com.example.entreprise.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entreprise.entity.Experience;
import com.example.entreprise.repository.ExperienceRepository;

@Service
public class ExperienceService {

    @Autowired
    private ExperienceRepository experienceRepository;

    public List<Experience> findByCandidatId(Long candidatId) {
        return experienceRepository.findByCandidatId(candidatId);
    }

    public void deleteByCandidatId(Long candidatId) {
        experienceRepository.deleteByCandidatId(candidatId);
    }

    public void save(Experience experience) {
        experienceRepository.save(experience);
    }
}
