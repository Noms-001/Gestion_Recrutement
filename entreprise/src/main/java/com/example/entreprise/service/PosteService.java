package com.example.entreprise.service;

import com.example.entreprise.entity.Poste;
import com.example.entreprise.repository.PosteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PosteService {

    @Autowired
    private PosteRepository posteRepository;

    public List<String> getLibellesPostesVacants() {
        List<Poste> postesVacants = posteRepository.findPostesVacants();
        return postesVacants.stream()
                .map(Poste::getLibelle)
                .collect(Collectors.toList());
    }

    public List<String> getLibellesPostesVacantsByDepartement(Long departementId) {
        List<Poste> postesVacants = posteRepository.findPostesVacantsByDepartement(departementId);
        return postesVacants.stream()
                .map(Poste::getLibelle)
                .collect(Collectors.toList());
    }

    public List<String> getLibellesPostesVacantsByDepartementNom(String departementNom) {
        List<Poste> postesVacants = posteRepository.findPostesVacantsByDepartementNom(departementNom);
        return postesVacants.stream()
                .map(Poste::getLibelle)
                .collect(Collectors.toList());
    }

    public List<Poste> getPostesVacants() {
        return posteRepository.findPostesVacants();
    }

    public boolean isPosteVacant(Long posteId) {
        List<Poste> postesVacants = posteRepository.findPostesVacants();
        return postesVacants.stream()
                .anyMatch(poste -> poste.getId().equals(posteId));
    }

    public boolean isPosteVacantByLibelle(String libellePoste) {
        List<Poste> postesVacants = posteRepository.findPostesVacants();
        return postesVacants.stream()
                .anyMatch(poste -> poste.getLibelle().equalsIgnoreCase(libellePoste));
    }

    public List<Poste> findAll() {
        return posteRepository.findAll();
    }
}

