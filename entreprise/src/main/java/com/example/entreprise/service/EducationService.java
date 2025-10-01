package com.example.entreprise.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entreprise.entity.Education;
import com.example.entreprise.repository.EducationRepository;

@Service
public class EducationService {

    @Autowired
    private EducationRepository educationRepository;

    public List<Education> findByCandidatId(Long candidatId) {
        return educationRepository.findByCandidatId(candidatId);
    }

    public void deleteByCandidatId(Long candidatId) {
        educationRepository.deleteByCandidatId(candidatId);
    }

    public void save(Education education) {
        educationRepository.save(education);
    }
}
