package com.example.entreprise.service;

import com.example.entreprise.repository.*;
import com.example.entreprise.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class TestPassageService {
    @Autowired
    private TestPassageRepository testPassageRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    public boolean aDejaPasseTest(Long utilisateurId, Long annonceId) {
        Optional<Utilisateur> opt = utilisateurRepository.findById(utilisateurId);
        if (opt.isPresent()) {
            Long candidatId = opt.get().getCandidat().getId();
            return testPassageRepository.existsByCandidatIdAndAnnonceId(candidatId, annonceId);
        }
        return false;
    }

    public void save(Long utilisateurId, Long annonceId, Integer score) {
        Optional<Utilisateur> opt = utilisateurRepository.findById(utilisateurId);
        if (opt.isPresent()) {
            Long candidatId = opt.get().getCandidat().getId();
            TestPassage testPassage = testPassageRepository.findByCandidatIdAndAnnonceId(candidatId, annonceId)
                    .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));
            testPassage.setScore(score);
            testPassageRepository.save(testPassage);
        }
    }
}
