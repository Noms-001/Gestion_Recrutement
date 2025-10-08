// online-test.js - Gestion complète du test QCM côté client
let testData = {};
let timerInterval;

// Clé pour le stockage local
const STORAGE_KEY = 'qcm_test_data';

document.addEventListener('DOMContentLoaded', function () {
    initializeTest();
});

async function initializeTest() {
    await loadTestData();
    startTimer();
    restoreAnswers();
    setupEventListeners();
    updateProgress();
    updateAnswerCounts();
    updateQuestionNavigation();

    // Afficher le corps de la page
    document.querySelector('body').style.display = 'block';
}

async function loadTestData() {
    try {
        const saved = localStorage.getItem(STORAGE_KEY);

        if (saved) {
            testData = JSON.parse(saved);

            // Calculer le temps restant basé sur le temps écoulé
            if (testData.startTime && testData.dureeMin) {
                const elapsedSeconds = Math.floor((Date.now() - testData.startTime) / 1000);
                const totalDuration = testData.dureeMin * 60;
                testData.timeRemaining = Math.max(0, totalDuration - elapsedSeconds);
            }
        } else {
            // Charger les données depuis l'API si pas de sauvegarde locale
            await loadTestDataFromAPI();
        }
    } catch (error) {
        console.error('Erreur lors du chargement des données:', error);
        await loadTestDataFromAPI();
    }

    updateTimerDisplay();
}

async function loadTestDataFromAPI() {
    try {
        // Simulation du chargement des données du test depuis votre API
        const response = await fetch(`/api/test/${testId}`);
        const data = await response.json();

        // Initialiser testData avec les données de l'API
        testData = {
            titre: data.titre,
            totalQuestions: data.totalQuestions,
            dureeMin: data.dureeMinutes,
            scoreMin: data.scoreMinimum,
            startTime: Date.now(),
            timeRemaining: data.dureeMinutes * 60,
            answers: {},
            currentQuestion: 1,
            questions: data.questions || []
        };

        saveTestData();
        generateQuestionNavigation();

    } catch (error) {
        console.error('Erreur lors du chargement des données du test:', error);
        // Fallback vers des données par défaut
        initializeWithDefaultData();
    }
}

function initializeWithDefaultData() {
    testData = {
        titre: "Test de compétences",
        totalQuestions: 20,
        dureeMin: 30,
        scoreMin: 70,
        startTime: Date.now(),
        timeRemaining: 30 * 60,
        answers: {},
        currentQuestion: 1,
        questions: []
    };

    saveTestData();
    generateQuestionNavigation();
}

function generateQuestionNavigation() {
    const questionNav = document.getElementById('questionNav');
    if (!questionNav) return;

    questionNav.innerHTML = '';

    for (let i = 1; i <= testData.totalQuestions; i++) {
        const btn = document.createElement('button');
        btn.className = 'btn btn-outline-secondary btn-sm me-1 mb-1';
        btn.textContent = i;
        btn.style.width = '35px';
        btn.style.height = '35px';

        btn.addEventListener('click', () => {
            testData.currentQuestion = i;
            saveTestData();
            displayQuestion(i);
            updateNavigationButtons();
            updateQuestionNavigation();
        });

        questionNav.appendChild(btn);
    }

    updateQuestionNavigation();
    displayQuestion(testData.currentQuestion);
}

function displayQuestion(questionNumber) {
    const questionContent = document.getElementById('questionContent');
    if (!questionContent) return;

    if (testData.questions && testData.questions.length > 0) {
        const question = testData.questions.find(q => q.id === questionNumber);
        if (question) {
            questionContent.innerHTML = `
                <div class="mb-4">
                    <div class="badge bg-primary mb-2 d-flex justify-content-between align-items-center">
                        <h6>Question ${questionNumber}</h6>
                        <h6>${question.points} ${question.points > 1 ? 'points' : 'point'}</h6>
                    </div>
                    <h5 class="fw-semibold">${question.text}</h5>
                </div>
                
                <div class="answers-container">
                    ${Object.entries(question.options).map(([key, value]) => `
                        <div class="form-check mb-3 p-3 border rounded answer-option" data-answer="${key}">
                            <input class="form-check-input" type="radio" name="q${questionNumber}" id="q${questionNumber}${key}" value="${key}">
                            <label class="form-check-label w-100" for="q${questionNumber}${key}">
                                <strong>${key.toUpperCase()})</strong> ${value}
                            </label>
                        </div>
                    `).join('')}
                </div>
            `;
        }
    } else {
        // Fallback pour les questions par défaut
        questionContent.innerHTML = `
            <div class="mb-4">
                <span class="badge bg-primary mb-2">Question ${questionNumber}</span>
                <h5 class="fw-semibold">Contenu de la question ${questionNumber}</h5>
            </div>
            
            <div class="answers-container">
                <div class="form-check mb-3 p-3 border rounded answer-option">
                    <input class="form-check-input" type="radio" name="q${questionNumber}" id="q${questionNumber}a" value="a">
                    <label class="form-check-label w-100" for="q${questionNumber}a">
                        <strong>A)</strong> Option A
                    </label>
                </div>
                <div class="form-check mb-3 p-3 border rounded answer-option">
                    <input class="form-check-input" type="radio" name="q${questionNumber}" id="q${questionNumber}b" value="b">
                    <label class="form-check-label w-100" for="q${questionNumber}b">
                        <strong>B)</strong> Option B
                    </label>
                </div>
                <div class="form-check mb-3 p-3 border rounded answer-option">
                    <input class="form-check-input" type="radio" name="q${questionNumber}" id="q${questionNumber}c" value="c">
                    <label class="form-check-label w-100" for="q${questionNumber}c">
                        <strong>C)</strong> Option C
                    </label>
                </div>
                <div class="form-check mb-3 p-3 border rounded answer-option">
                    <input class="form-check-input" type="radio" name="q${questionNumber}" id="q${questionNumber}d" value="d">
                    <label class="form-check-label w-100" for="q${questionNumber}d">
                        <strong>D)</strong> Option D
                    </label>
                </div>
            </div>
        `;
    }

    // Restaurer la réponse précédente si elle existe
    if (testData.answers[questionNumber]) {
        restoreAnswerToDOM(questionNumber, testData.answers[questionNumber]);
    }

    // Mettre à jour l'affichage de la question courante
    const currentQuestionElement = document.getElementById('currentQuestion');
    if (currentQuestionElement) {
        currentQuestionElement.textContent = questionNumber;
    }

    // Ajouter les event listeners pour les nouvelles options
    addAnswerOptionListeners();
}

function addAnswerOptionListeners() {
    // Gestion des clics sur les options de réponse
    const answerOptions = document.querySelectorAll('.answer-option');
    answerOptions.forEach(option => {
        option.addEventListener('click', function () {
            const radio = this.querySelector('input[type="radio"]');
            if (radio) {
                radio.checked = true;

                // Mise à jour visuelle
                answerOptions.forEach(opt => {
                    opt.classList.remove('border-primary', 'bg-light');
                });
                this.classList.add('border-primary', 'bg-light');

                // Sauvegarder la réponse
                saveAnswerFromElement(radio);
            }
        });
    });
}

function saveTestData() {
    try {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(testData));
    } catch (error) {
        console.error('Erreur lors de la sauvegarde des données:', error);
    }
}

function startTimer() {
    if (timerInterval) {
        clearInterval(timerInterval);
    }

    timerInterval = setInterval(() => {
        if (testData.timeRemaining > 0)
            testData.timeRemaining--;

        if (testData.timeRemaining <= 0) {
            clearInterval(timerInterval);
            finishTest();
            return;
        }

        updateTimerDisplay();
        saveTestData();

        // Alertes de temps
        if (testData.timeRemaining === 30) {
            showToast('danger', 'Attention: Il ne vous reste que 30 secondes !');
        } else if (testData.timeRemaining === 60) {
            showToast('warning', 'Attention: Il ne vous reste qu\'1 minute !');
        } else if (testData.timeRemaining === 300) {
            showToast('warning', 'Attention: Il ne vous reste que 5 minutes !');
        }
    }, 1000);
}

function updateTimerDisplay() {
    // Mettre à jour les informations du test
    if (testData.titre) {
        document.getElementById('titre').textContent = testData.titre;
    }
    if (testData.totalQuestions && testData.dureeMin && testData.scoreMin) {
        document.getElementById('info').textContent = `${testData.totalQuestions} questions • Durée: ${testData.dureeMin} minutes • Score minimum: ${testData.scoreMin}%`;
        document.getElementById('sur').textContent = `sur ${testData.totalQuestions}`;
        document.getElementById('remainingCount').textContent = `${testData.totalQuestions}`;
        document.getElementById('totalCount').textContent = `${testData.totalQuestions}`;
    }

    // Mettre à jour le timer
    const minutes = Math.floor(testData.timeRemaining / 60);
    const seconds = testData.timeRemaining % 60;
    const display = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

    const timerElement = document.getElementById('timeDisplay');
    if (timerElement) {
        timerElement.textContent = display;

        // Changer la couleur selon le temps restant
        if (testData.timeRemaining <= 300) { // 5 minutes
            timerElement.className = 'h4 mb-1 text-danger';
        } else if (testData.timeRemaining <= 600) { // 10 minutes
            timerElement.className = 'h4 mb-1 text-warning';
        } else {
            timerElement.className = 'h4 mb-1 text-primary';
        }
    }
}

function setupEventListeners() {
    // Écouteurs pour tous les types de réponses
    document.addEventListener('change', (e) => {
        const target = e.target;

        if (target.matches('input[type="radio"], input[type="checkbox"], select')) {
            saveAnswerFromElement(target);
        }
    });

    // Sauvegarde pour les inputs texte et textarea (avec debounce)
    let textInputTimeout;
    document.addEventListener('input', (e) => {
        const target = e.target;

        if (target.matches('input[type="text"], textarea')) {
            clearTimeout(textInputTimeout);
            textInputTimeout = setTimeout(() => {
                saveAnswerFromElement(target);
            }, 500);
        }
    });

    // Navigation entre questions
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');

    if (prevBtn) {
        prevBtn.addEventListener('click', navigateToPreviousQuestion);
    }

    if (nextBtn) {
        nextBtn.addEventListener('click', navigateToNextQuestion);
    }

    // Navigation par clavier
    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft') {
            navigateToPreviousQuestion();
        } else if (e.key === 'ArrowRight') {
            navigateToNextQuestion();
        }
    });

    // Sauvegarder avant déchargement de la page
    window.addEventListener('beforeunload', saveTestData);
}

function saveAnswerFromElement(element) {
    const questionId = getQuestionIdFromElement(element);

    if (!questionId) return;

    let value;

    if (element.type === 'radio') {
        if (element.checked) {
            value = element.value;
        } else {
            return; // Ne pas sauvegarder si radio non coché
        }
    } else if (element.type === 'checkbox') {
        const checkboxes = document.querySelectorAll(`input[name="${element.name}"]:checked`);
        value = Array.from(checkboxes).map(cb => cb.value);
    } else {
        value = element.value;
    }

    saveAnswer(questionId, value);
}

function getQuestionIdFromElement(element) {
    // Extraire l'ID de la question du name ou id de l'élément
    if (element.name) {
        const match = element.name.match(/q(\d+)/);
        if (match) return match[1];
    }

    if (element.id) {
        const match = element.id.match(/q(\d+)/);
        if (match) return match[1];
    }

    return null;
}

function saveAnswer(questionId, answer) {
    if (!questionId) return;

    testData.answers[questionId] = answer;
    saveTestData();
    updateProgress();
    updateAnswerCounts();
    updateQuestionNavigation();
}

function restoreAnswers() {
    Object.keys(testData.answers).forEach(questionId => {
        const answer = testData.answers[questionId];
        restoreAnswerToDOM(questionId, answer);
    });
}

function restoreAnswerToDOM(questionId, answer) {
    if (Array.isArray(answer)) {
        // Cas des checkboxes
        answer.forEach(value => {
            const element = document.querySelector(`input[name="q${questionId}"][value="${value}"]`);
            if (element) {
                element.checked = true;

                // Mise à jour visuelle
                const option = element.closest('.answer-option');
                if (option) {
                    option.classList.add('border-success', 'bg-light');
                }
            }
        });
    } else {
        // Cas des radios
        const radio = document.querySelector(`input[type="radio"][name="q${questionId}"][value="${answer}"]`);
        if (radio) {
            radio.checked = true;

            // Mise à jour visuelle
            const option = radio.closest('.answer-option');
            if (option) {
                option.classList.add('border-primary', 'bg-light');
            }
        } else {
            // Cas des inputs texte
            const textInput = document.querySelector(`input[type="text"][name="q${questionId}"]`);
            if (textInput) {
                textInput.value = answer;
            } else {
                // Cas des textareas
                const textarea = document.querySelector(`textarea[name="q${questionId}"]`);
                if (textarea) {
                    textarea.value = answer;
                } else {
                    // Cas des selects
                    const select = document.querySelector(`select[name="q${questionId}"]`);
                    if (select) {
                        select.value = answer;
                    }
                }
            }
        }
    }
}

function navigateToPreviousQuestion() {
    if (testData.currentQuestion > 1) {
        testData.currentQuestion--;
        saveTestData();
        displayQuestion(testData.currentQuestion);
        updateNavigationButtons();
        updateQuestionNavigation();
    }
}

function navigateToNextQuestion() {
    if (testData.currentQuestion < testData.totalQuestions) {
        testData.currentQuestion++;
        saveTestData();
        displayQuestion(testData.currentQuestion);
        updateNavigationButtons();
        updateQuestionNavigation();
    } else {
        showFinishConfirmation();
    }
}

function updateNavigationButtons() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');

    if (prevBtn) {
        prevBtn.disabled = testData.currentQuestion <= 1;
    }

    if (nextBtn) {
        nextBtn.disabled = testData.currentQuestion >= testData.totalQuestions;
    }
}

function updateProgress() {
    const answeredQuestions = Object.keys(testData.answers).length;
    const totalQuestions = testData.totalQuestions;
    const percentage = totalQuestions > 0 ? (answeredQuestions / totalQuestions) * 100 : 0;

    // Mettre à jour le cercle de progression
    const progressCircle = document.getElementById('progressCircle');
    if (progressCircle) {
        const circumference = 2 * Math.PI * 35;
        const offset = circumference - (percentage / 100) * circumference;
        progressCircle.style.strokeDashoffset = offset;
    }

    // Mettre à jour le pourcentage
    const progressPercent = document.getElementById('progressPercent');
    if (progressPercent) {
        progressPercent.textContent = Math.round(percentage) + '%';
    }
}

function updateAnswerCounts() {
    const answeredCount = Object.keys(testData.answers).length;
    const totalQuestions = testData.totalQuestions;
    const remainingCount = totalQuestions - answeredCount;

    const answeredCountElement = document.getElementById('answeredCount');
    const remainingCountElement = document.getElementById('remainingCount');
    const totalCountElement = document.getElementById('totalCount');

    if (answeredCountElement) answeredCountElement.textContent = answeredCount;
    if (remainingCountElement) remainingCountElement.textContent = remainingCount;
    if (totalCountElement) totalCountElement.textContent = totalQuestions;
}

function updateQuestionNavigation() {
    const questionNav = document.getElementById('questionNav');
    if (!questionNav) return;

    const buttons = questionNav.querySelectorAll('button');
    buttons.forEach((btn, index) => {
        const questionNumber = index + 1;

        // Reset classes
        btn.className = 'btn btn-sm me-1 mb-1';
        btn.style.width = '35px';
        btn.style.height = '35px';

        if (questionNumber === testData.currentQuestion) {
            btn.classList.add('btn-primary');
        } else if (testData.answers[questionNumber]) {
            btn.classList.add('btn-success');
        } else {
            btn.classList.add('btn-outline-secondary');
        }
    });
}

function showFinishConfirmation() {
    updateAnswerCounts(); // Mettre à jour les compteurs dans la modal
    const finishModal = new bootstrap.Modal(document.getElementById('finishModal'));
    finishModal.show();
}

function finishTest() {
    clearInterval(timerInterval);

    // Calculer le score
    const score = calculateScore();

    // Afficher les résultats
    showTestResults(score);

    // Nettoyer le localStorage
    localStorage.removeItem(STORAGE_KEY);

    // Mettre en mode lecture seule
    setReadOnlyMode();
}

function calculateScore() {
    // Logique de calcul du score basée sur les réponses correctes
    let correctAnswers = 0;
    let totalPoints = 0;
    let pointsEarned = 0;

    if (testData.questions && testData.questions.length > 0) {
        testData.questions.forEach(question => {
            if (testData.answers[question.id] === question.correct) {
                correctAnswers++;
                pointsEarned += question.points;
            }
            totalPoints += question.points;
        });

        fetch(`/api/test/${annonceId}/soumettre`, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({
                score: pointsEarned
            })
        });

        return totalPoints > 0 ? Math.round((pointsEarned / totalPoints) * 100) : 0;
    } else {
        // Fallback : calcul basé sur le nombre de réponses
        const answeredQuestions = Object.keys(testData.answers).length;
        const baseScore = Math.round((answeredQuestions / testData.totalQuestions) * 100);
        return Math.min(100, Math.max(0, baseScore + (Math.random() * 20 - 10)));
    }
}

function showTestResults(score) {
    const answeredCount = Object.keys(testData.answers).length;
    const totalQuestions = testData.totalQuestions;
    const passed = score >= testData.scoreMin;

    const resultContent = `
        <div class="text-center">
            <div class="mb-4">
                <div class="display-1 ${passed ? 'text-success' : 'text-danger'}">${score}%</div>
                <h4>Votre score final</h4>
            </div>
            
            <div class="row mb-4">
                <div class="col-4">
                    <div class="h3 text-success">${answeredCount}</div>
                    <small class="text-muted">Questions répondues</small>
                </div>
                <div class="col-4">
                    <div class="h3 text-warning">${totalQuestions - answeredCount}</div>
                    <small class="text-muted">Questions non répondues</small>
                </div>
                <div class="col-4">
                    <div class="h3 text-primary">${totalQuestions}</div>
                    <small class="text-muted">Total</small>
                </div>
            </div>
            
            <div class="alert ${passed ? 'alert-success' : 'alert-danger'}">
                <i class="bi ${passed ? 'bi-check-circle' : 'bi-x-circle'} me-2"></i>
                ${passed ? 'Félicitations ! Vous avez réussi le test.' : `Vous n'avez pas atteint le score minimum requis (${testData.scoreMin}%).`}
            </div>
        </div>
    `;

    showModal(
        'Résultats du test',
        resultContent,
        '<button type="button" class="btn btn-primary" onclick="/job-listings">Voir les annonces</button>'
    );
}

window.finishTest = finishTest;