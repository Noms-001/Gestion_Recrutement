package com.example.entreprise.service;

import com.example.entreprise.entity.Candidat;
import com.example.entreprise.entity.Employe;
import com.example.entreprise.entity.Utilisateur;
import com.example.entreprise.repository.CandidatRepository;
import com.example.entreprise.repository.EmployeRepository;
import com.example.entreprise.repository.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private CandidatRepository candidatRepository;

    @Autowired
    private EmployeRepository employeRepository;

    /**
     * Vérifie les identifiants et retourne l'utilisateur si correct
     */
    public Optional<Utilisateur> authenticate(String email, String password) {
        return utilisateurRepository.findByEmailAndMotDePasse(email, password);
    }

    /**
     * Vérifie si un utilisateur est un candidat
     */
    public Optional<Candidat> getCandidat(Utilisateur utilisateur) {
        return candidatRepository.findAll()
                .stream()
                .filter(c -> c.getUtilisateur().getId().equals(utilisateur.getId()))
                .findFirst();
    }

    /**
     * Vérifie si un utilisateur est un employé
     */
    public Optional<Employe> getEmploye(Utilisateur utilisateur) {
        return employeRepository.findAll()
                .stream()
                .filter(e -> e.getUtilisateur().getId().equals(utilisateur.getId()))
                .findFirst();
    }
}
