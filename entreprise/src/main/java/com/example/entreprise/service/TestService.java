package com.example.entreprise.service;

import com.example.entreprise.dto.*;
import com.example.entreprise.entity.*;
import com.example.entreprise.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalTime;
import java.util.List;

@Service
public class TestService {
    private final TestRepository testRepository;
    private final QuestionRepository questionRepository;
    private final ReponseRepository reponseRepository;
    private final TestQcmRepository testQcmRepository;

    public TestService(TestRepository testRepository, QuestionRepository questionRepository,
            ReponseRepository reponseRepository, TestQcmRepository testQcmRepository) {
        this.testRepository = testRepository;
        this.questionRepository = questionRepository;
        this.reponseRepository = reponseRepository;
        this.testQcmRepository = testQcmRepository;
    }

    @Transactional
    public Test createTest(TestDTO dto) {
        // Création du test
        Test test = new Test();
        test.setTitre(dto.getTitre());
        test.setTemps(LocalTime.of(dto.getTemps(), 0)); // ex: 30 minutes = 00:30:00
        test.setScoreMin(dto.getScoreMin());
        testRepository.save(test);

        // Ajout des questions et réponses
        for (QuestionDTO qdto : dto.getQuestions()) {
            Question question = new Question();
            question.setEnonce(qdto.getEnonce());
            question.setPoint(qdto.getPoint());
            questionRepository.save(question);

            // Réponses
            for (ReponseDTO rdto : qdto.getReponses()) {
                Reponse reponse = new Reponse();
                reponse.setValeur(rdto.getValeur());
                reponse.setEstCorrect(rdto.getEstCorrect());
                reponse.setQuestion(question);
                reponseRepository.save(reponse);
            }

            // Liaison Test ↔ Question
            TestQcm link = new TestQcm();
            TestQcmId id = new TestQcmId();
            id.setIdTest(test.getId());
            id.setIdQuestion(question.getId());
            link.setId(id);
            link.setTest(test);
            link.setQuestion(question);
            testQcmRepository.save(link);
        }

        return test;
    }

    public List<Test> getAllTests() {
        return testRepository.findAll();
    }

    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

}
