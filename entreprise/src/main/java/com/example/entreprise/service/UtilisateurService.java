package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class UtilisateurService {

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private CandidatRepository candidatRepository;

    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private PosteRepository posteRepository;

    @Autowired
    private GenreRepository genreRepository;

    public Optional<Utilisateur> authenticate(String email, String password) {
        return utilisateurRepository.findByEmailAndMotDePasse(email, password);
    }

    public Optional<Candidat> getCandidat(Utilisateur utilisateur) {
        return candidatRepository.findAll()
                .stream()
                .filter(c -> c.getUtilisateur().getId().equals(utilisateur.getId()))
                .findFirst();
    }

    public Optional<Employe> getEmploye(Utilisateur utilisateur) {
        return employeRepository.findAll()
                .stream()
                .filter(e -> e.getUtilisateur().getId().equals(utilisateur.getId()))
                .findFirst();
    }

    public void inscrireUtilisateur(String nom, String prenom, String email, String motDePasse, String profil, Long posteId, Long genreId) throws Exception {
        // Vérifier si l'email existe déjà
        if(utilisateurRepository.findByEmail(email).isPresent()) {
            throw new Exception("Email déjà utilisé");
        }

        // Création utilisateur
        Utilisateur user = new Utilisateur();
        Genre genre = genreRepository.findById(genreId).get();
        user.setNom(nom);
        user.setPrenom(prenom);
        user.setEmail(email);
        user.setGenre(genre);
        user.setMotDePasse(motDePasse);
        user.setCreatedAt(LocalDateTime.now());
        utilisateurRepository.save(user);

        // Selon le profil, créer Candidat ou Employe
        if(profil.equals("candidat")) {
            Candidat candidat = new Candidat();
            candidat.setUtilisateur(user);
            candidatRepository.save(candidat);
        } else if(profil.equals("recruteur")) {
            Employe employe = new Employe();
            employe.setPoste(posteRepository.findById(posteId).get());
            employe.setUtilisateur(user);
            employeRepository.save(employe);
        }
    }
}
