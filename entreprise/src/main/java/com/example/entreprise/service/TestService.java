package com.example.entreprise.service;

import com.example.entreprise.entity.*;
import com.example.entreprise.dto.*;
import com.example.entreprise.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.*;
import java.util.*;;

@Service
public class TestService {

    @Autowired
    private TestRepository testRepository;
    @Autowired
    private TestPassageRepository testPassageRepository;
    @Autowired
    private UtilisateurRepository utilisateurRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ReponseRepository reponseRepository;
    @Autowired
    private AnnonceRepository annonceRepository;
    @Transactional
    public void demarrerTest(Long utilisateurId, Long AnnonceId) throws Exception {
        try {
            // Récupérer le candidat
            Candidat candidat = utilisateurRepository.findById(utilisateurId)
                    .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"))
                    .getCandidat();
            
            // Vérifier si le test existe
            Annonce annonce = annonceRepository.findById(AnnonceId)
                    .orElseThrow(() -> new RuntimeException("Test non trouvé"));
            
            // Vérifier si le candidat a déjà passé ce test
            if (testPassageRepository.existsByCandidatIdAndAnnonceId(candidat.getId(), AnnonceId)) {
                throw new RuntimeException("Vous avez déjà passé ce test");
            }
            
            // Créer le passage de test
            TestPassage testPassage = new TestPassage();
            TestPassageId testPassageId = new TestPassageId();
            testPassageId.setIdCandidat(candidat.getId());
            testPassageId.setIdAnnonce(AnnonceId);
            
            testPassage.setId(testPassageId);
            testPassage.setCandidat(candidat);
            testPassage.setAnnonce(annonce);
            testPassage.setDatePassage(LocalDate.now());
            
            testPassageRepository.save(testPassage);
            
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors du démarrage du test: " + e.getMessage());
        }
    }

    public Map<String, Object> getTestInfo(Long testId) {
        Test test = testRepository.findById(testId).get();
        Map<String, Object> questionsData = new HashMap<>();
        
        questionsData.put("totalQuestions", test.getQuestions().size());
        questionsData.put("dureeMinutes", test.getTemps().getHour() * 60 + test.getTemps().getMinute());
        questionsData.put("scoreMinimum", test.getScoreMin());
        questionsData.put("titre", test.getTitre());
        int id = 1;
        // Préparer chaque question
        ArrayList questions = new ArrayList();
        Long currentQuestion = null;
        for (Question question : test.getQuestions()) {
            Map<String, Object> questionData = new HashMap<>();
            questionData.put("q_id", question.getId());
            questionData.put("id", id);
            questionData.put("text", question.getEnonce());
            questionData.put("points", question.getPoint());
            if(currentQuestion == null || currentQuestion > question.getId())
                currentQuestion = question.getId();
            // Préparer les options de réponse
            Map<String, String> options = new HashMap<>();
            char optionChar = 'a';
            char correct = 'a';
            for (QuestionReponse reponse : question.getQuestionReponses()) {
                options.put(String.valueOf(optionChar), reponse.getReponse().getValeur());
                if(reponse.getEstCorrect()) correct = optionChar;
                optionChar++;
            }
            questionData.put("options", options);
            questionData.put("correct", String.valueOf(correct));
            questions.add(questionData);
            id++;
        }
        questionsData.put("questions", questions);
        return questionsData;
    }

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
            Question question = questionRepository.findFirstByEnonce(qdto.getEnonce())
                    .orElseGet(() -> {
                        Question newQ = new Question();
                        newQ.setEnonce(qdto.getEnonce());
                        newQ.setPoint(qdto.getPoint());
                        newQ = questionRepository.save(newQ);
                        List<QuestionReponse> qrs = new ArrayList<>();

                        for (ReponseDTO rdto : qdto.getReponses()) {
                            // Vérifier si la réponse existe déjà (par valeur)
                            Reponse reponse = reponseRepository.findFirstByValeur(rdto.getValeur())
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

    public List<Test> findAll() {
        return testRepository.findAll();
    }
}
