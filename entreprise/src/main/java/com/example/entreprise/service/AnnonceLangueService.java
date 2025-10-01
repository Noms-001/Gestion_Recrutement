package com.example.entreprise.service;

import com.example.entreprise.entity.AnnonceLangue;
import com.example.entreprise.entity.AnnonceLangueId;
import com.example.entreprise.repository.AnnonceLangueRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Optional;

@Service
public class AnnonceLangueService {
    @Autowired
    private AnnonceLangueRepository repository;

    public List<AnnonceLangue> findAll() {
        return repository.findAll();
    }

    public Optional<AnnonceLangue> findById(AnnonceLangueId id) {
        return repository.findById(id);
    }

    public AnnonceLangue save(AnnonceLangue annonceLangue) {
        return repository.save(annonceLangue);
    }

    public void delete(AnnonceLangue annonceLangue) {
        repository.delete(annonceLangue);
    }

    public List<AnnonceLangue> filterByVille(Long villeId) {
        return repository.findByAnnonceVilleId(villeId);
    }

    public List<AnnonceLangue> filterByTypeContrat(Long typeContratId) {
        return repository.findByAnnonceTypeContratId(typeContratId);
    }
}
