package com.example.entreprise.service;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.entreprise.dto.QuestionDTO;
import com.example.entreprise.dto.ReponseDTO;
import com.example.entreprise.dto.TestDTO;
import com.example.entreprise.entity.Question;
import com.example.entreprise.entity.QuestionReponse;
import com.example.entreprise.entity.QuestionReponseId;
import com.example.entreprise.entity.Reponse;
import com.example.entreprise.entity.Test;
import com.example.entreprise.repository.QuestionRepository;
import com.example.entreprise.repository.ReponseRepository;
import com.example.entreprise.repository.TestRepository;

@Service
public class TestService {
    @Autowired
    private TestRepository testRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ReponseRepository reponseRepository;

    @Transactional
    public Test createTest(TestDTO dto) {
        // Création du test
        Test test = new Test();
        test.setTitre(dto.getTitre());
        int totalMinutes = dto.getTemps();
        int heures = totalMinutes / 60;
        int minutes = totalMinutes % 60;

        test.setTemps(LocalTime.of(heures, minutes));
        test.setScoreMin(dto.getScoreMin());

        List<Question> questions = new ArrayList<>();

        for (QuestionDTO qdto : dto.getQuestions()) {
            // Vérifier si la question existe déjà (par enonce)
            Question question = questionRepository.findByEnonce(qdto.getEnonce())
                    .orElseGet(() -> {
                        Question newQ = new Question();
                        newQ.setEnonce(qdto.getEnonce());
                        newQ.setPoint(qdto.getPoint());
                        newQ = questionRepository.save(newQ);
                        List<QuestionReponse> qrs = new ArrayList<>();

                        for (ReponseDTO rdto : qdto.getReponses()) {
                            // Vérifier si la réponse existe déjà (par valeur)
                            Reponse reponse = reponseRepository.findByValeur(rdto.getValeur())
                                    .orElseGet(() -> {
                                        Reponse newR = new Reponse();
                                        newR.setValeur(rdto.getValeur());
                                        return reponseRepository.save(newR);
                                    });
                            QuestionReponse qr = new QuestionReponse();
                            QuestionReponseId qrId = new QuestionReponseId(newQ.getId(), reponse.getId());
                            qr.setId(qrId);
                            qr.setQuestion(newQ); // 🔹 IMPORTANT
                            qr.setReponse(reponse);
                            qr.setEstCorrect(Boolean.TRUE.equals(rdto.getEstCorrect()));
                            qrs.add(qr);
                        }

                        newQ.setQuestionReponses(qrs);
                        return newQ;
                    });
            questions.add(question);

        }

        // Associer les questions au test
        test.setQuestions(questions);

        return testRepository.save(test);
    }

    public List<Test> getAllTests() {
        return testRepository.findAll();
    }

    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

    public List<QuestionDTO> getAllQuestionsDTO() {
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
