package com.example.entreprise.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entreprise.dto.QuestionDTO;
import com.example.entreprise.dto.ReponseDTO;
import com.example.entreprise.entity.Question;
import com.example.entreprise.repository.QuestionRepository;

@Service
public class QuestionService {
    @Autowired
    private QuestionRepository questionRepository;

    public List<Question> findAll() {
        return questionRepository.findAll();
    }
    
    public List<QuestionDTO> findAllDTO() {
        return questionRepository.findAll().stream().map(q -> {
            QuestionDTO dto = new QuestionDTO();
            dto.setId(q.getId());
            dto.setEnonce(q.getEnonce());
            dto.setPoint(q.getPoint());
            dto.setReponses(q.getReponses().stream().map(r -> {
                ReponseDTO rdto = new ReponseDTO();
                rdto.setId(r.getId());
                rdto.setValeur(r.getValeur());
                rdto.setEstCorrect(r.estCorrect(q));
                return rdto;
            }).collect(Collectors.toList()));
            return dto;
        }).collect(Collectors.toList());
    }
}
