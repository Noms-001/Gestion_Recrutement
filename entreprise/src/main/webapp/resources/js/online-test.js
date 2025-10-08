// Online Test JavaScript
let testData = {};

let timerInterval;

document.addEventListener('DOMContentLoaded', function () {
    initializeTest();
});

async function initializeTest() {
    generateSampleQuestions().then(data => {
        testData = data;
        document.getElementById('titre').textContent = testData.titre;
        document.getElementById('info').textContent = `${testData.totalQuestions} questions • Durée: ${testData.dureeMin} minutes • Score minimum: ${testData.scoreMin}%`
        document.getElementById('sur').textContent = `sur ${testData.totalQuestions}`;
        document.getElementById('remainingCount').textContent = `${testData.totalQuestions}`;
        updateTimerDisplay();
        displayQuestion(testData.currentQuestion);
        document.querySelector('body').style.display = 'block';
        updateNavigationButtons();
        startTimer();
        setupEventListeners();
        generateQuestionNavigation();
        updateProgress();
    });
}

function generateSampleQuestions() {
    return fetch(`/api/test/${testId}`)
        .then(res => res.json())
        .then(data => {
            return {
                titre: data.titre,
                totalQuestions: data.totalQuestions,
                currentQuestion: 1,
                dureeMin: data.dureeMinutes,
                timeRemaining: data.dureeMinutes * 60,
                answers: {},
                questions: data.questions,
                scoreMin: data.scoreMinimum
            };
        })
        .catch(() => {
            console.log("Erreur");
        });
}

function displayQuestion(questionNumber) {
    const question = testData.questions.find(q => q.id === questionNumber);
    if (!question) return;

    const questionContent = document.getElementById('questionContent');
    questionContent.innerHTML = `
        <div class="mb-4">
            <span class="badge bg-primary mb-2">Question ${questionNumber}</span>
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

    // Restore previous answer if exists
    if (testData.answers[questionNumber]) {
        const radio = questionContent.querySelector(`input[value="${testData.answers[questionNumber]}"]`);
        if (radio) {
            radio.checked = true;
            radio.closest('.answer-option').classList.add('border-primary', 'bg-light');
        }
    }

    // Add click handlers for answer options
    const answerOptions = questionContent.querySelectorAll('.answer-option');
    answerOptions.forEach(option => {
        option.addEventListener('click', function () {
            const radio = this.querySelector('input[type="radio"]');
            radio.checked = true;

            // Remove previous selection styling
            answerOptions.forEach(opt => opt.classList.remove('border-primary', 'bg-light'));

            // Style selected option
            this.classList.add('border-primary', 'bg-light');

            // Save answer
            saveAnswer(questionNumber, radio.value);
        });
    });

    // Update current question display
    document.getElementById('currentQuestion').textContent = questionNumber;
    document.getElementById('totalCount').textContent = testData.totalQuestions;
}

function saveAnswer(questionNumber, answer) {
    testData.answers[questionNumber] = answer;
    updateQuestionNavigation();
    updateProgress();
    updateAnswerCounts();
}

function setupEventListeners() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');

    prevBtn.addEventListener('click', () => {
        if (testData.currentQuestion > 1) {
            testData.currentQuestion--;
            displayQuestion(testData.currentQuestion);
            updateNavigationButtons();
            updateQuestionNavigation();
        }
    });

    nextBtn.addEventListener('click', () => {
        if (testData.currentQuestion < testData.totalQuestions) {
            testData.currentQuestion++;
            displayQuestion(testData.currentQuestion);
            updateNavigationButtons();
            updateQuestionNavigation();
        } else {
            // Last question reached
            showModal(
                'Fin du test',
                'Vous avez atteint la dernière question. Souhaitez-vous terminer le test maintenant ?',
                `
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Revoir mes réponses</button>
                <button type="button" class="btn btn-primary" onclick="finishTest(); bootstrap.Modal.getInstance(document.querySelector('.modal')).hide();">Terminer le test</button>
                `, false
            );
        }
    });
}

function generateQuestionNavigation() {
    const questionNav = document.getElementById('questionNav');
    questionNav.innerHTML = '';

    testData.totalQuestions = testData.questions.length; // mise à jour

    for (let i = 1; i <= testData.questions.length; i++) {
        const btn = document.createElement('button');
        btn.className = 'btn btn-outline-secondary btn-sm me-1 mb-1';
        btn.textContent = i;
        btn.style.width = '35px';
        btn.style.height = '35px';

        btn.addEventListener('click', () => {
            testData.currentQuestion = i;
            displayQuestion(i);
            updateNavigationButtons();
            updateQuestionNavigation();
        });

        questionNav.appendChild(btn);
    }

    updateQuestionNavigation();
}

function updateNavigationButtons() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');

    // Désactiver le bouton précédent si on est à la première question
    prevBtn.disabled = testData.currentQuestion === 1;

    // Désactiver le bouton suivant si on est à la dernière question
    nextBtn.disabled = testData.currentQuestion === testData.totalQuestions;
}


function generateQuestionNavigation() {
    const questionNav = document.getElementById('questionNav');
    questionNav.innerHTML = '';

    for (let i = 1; i <= testData.totalQuestions; i++) {
        const btn = document.createElement('button');
        btn.className = 'btn btn-outline-secondary btn-sm me-1 mb-1';
        btn.textContent = i;
        btn.style.width = '35px';
        btn.style.height = '35px';

        btn.addEventListener('click', () => {
            testData.currentQuestion = i;
            displayQuestion(i);
            updateNavigationButtons();
            updateQuestionNavigation();
        });

        questionNav.appendChild(btn);
    }

    updateQuestionNavigation();
}

function updateQuestionNavigation() {
    const questionNav = document.getElementById('questionNav');
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

function updateProgress() {
    const answeredQuestions = Object.keys(testData.answers).length;
    const percentage = (answeredQuestions / testData.totalQuestions) * 100;

    // Update progress circle
    const progressCircle = document.getElementById('progressCircle');
    const circumference = 2 * Math.PI * 35; // radius = 35
    const offset = circumference - (percentage / 100) * circumference;

    progressCircle.style.strokeDashoffset = offset;

    // Update percentage text
    document.getElementById('progressPercent').textContent = Math.round(percentage) + '%';
}

function updateAnswerCounts() {
    const answeredCount = Object.keys(testData.answers).length;
    const remainingCount = testData.totalQuestions - answeredCount;

    document.getElementById('answeredCount').textContent = answeredCount;
    document.getElementById('remainingCount').textContent = remainingCount;
}

function startTimer() {
    timerInterval = setInterval(() => {
        testData.timeRemaining--;

        if (testData.timeRemaining <= 0) {
            clearInterval(timerInterval);
            showModal(
                'Temps écoulé',
                'Le temps imparti pour ce test est écoulé. Votre test va être automatiquement soumis.',
                '<button type="button" class="btn btn-primary" onclick="finishTest(); bootstrap.Modal.getInstance(document.querySelector(\'.modal\')).hide();">Voir les résultats</button>'
            );
            return;
        }

        updateTimerDisplay();

        if (testData.timeRemaining === 30) {
            showToast('danger', 'Attention: Il ne vous reste que 30 secondes !');
        }

        // Warning when 1 minute left
        if (testData.timeRemaining === 60) {
            showToast('warning', 'Attention: Il ne vous reste qu\'1 minute !');
        }
    }, 1000);
}

function updateTimerDisplay() {
    const minutes = Math.floor(testData.timeRemaining / 60);
    const seconds = testData.timeRemaining % 60;
    const display = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

    document.getElementById('timeDisplay').textContent = display;

    // Change color based on time remaining
    const timerElement = document.getElementById('timeDisplay');
    if (testData.timeRemaining <= 300) { // 5 minutes
        timerElement.className = 'h4 mb-1 text-danger';
    } else if (testData.timeRemaining <= 600) { // 10 minutes
        timerElement.className = 'h4 mb-1 text-warning';
    } else {
        timerElement.className = 'h4 mb-1 text-primary';
    }
}

function setReadOnlyMode() {
    // Désactiver tous les boutons
    document.querySelectorAll('button').forEach(btn => {
        btn.disabled = true;
        btn.classList.add('disabled');
    });

    // Désactiver tous les inputs (radio, etc.)
    document.querySelectorAll('input, select, textarea').forEach(el => {
        el.disabled = true;
    });

    // Enlever tous les listeners de clic sur les réponses
    document.querySelectorAll('.answer-option').forEach(opt => {
        opt.style.pointerEvents = 'none';
        opt.classList.add('opacity-75');
    });

    // Griser la zone principale
    const mainCard = document.querySelector('.main-content');
    if (mainCard) {
        mainCard.classList.add('readonly-mode');
        mainCard.style.opacity = '0.7';
    }

    // Supprimer le timer visuellement
    const timer = document.getElementById('testTimer');
    if (timer) {
        timer.style.opacity = '0.5';
    }

    // Empêcher toute interaction clavier
    document.addEventListener('keydown', e => e.preventDefault(), { capture: true });

    // Optionnel : message visuel
    showToast('info', 'Le test est maintenant en lecture seule.');
}

function finishTest() {
    clearInterval(timerInterval);

    let correctAnswers = 0;
    testData.questions.forEach(question => {
        if (testData.answers[question.id] === question.correct) {
            correctAnswers++;
        }
    });

    const score = Math.round((correctAnswers / testData.totalQuestions) * 100);
    const passed = score >= testData.scoreMin;

    fetch(`/annonces/${testData.annonceId}/soumettre`, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({
            score: score
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            setReadOnlyMode();
            showTestResults(score, correctAnswers, passed);
        } else {
            alert("Erreur : " + data.error);
        }
    })
    .catch(error => {
        console.error("Erreur lors de l’envoi du score :", error);
        alert("Une erreur est survenue lors de la soumission du test.");
    });
}

function showTestResults(score, correctAnswers, passed) {
    const resultContent = `
        <div class="text-center">
            <div class="mb-4">
                <div class="display-1 ${passed ? 'text-success' : 'text-danger'}">${score}%</div>
                <h4>Votre score final</h4>
            </div>
            
            <div class="row mb-4">
                <div class="col-4">
                    <div class="h3 text-success">${correctAnswers}</div>
                    <small class="text-muted">Bonnes réponses</small>
                </div>
                <div class="col-4">
                    <div class="h3 text-danger">${testData.totalQuestions - correctAnswers}</div>
                    <small class="text-muted">Mauvaises réponses</small>
                </div>
                <div class="col-4">
                    <div class="h3 text-primary">${testData.totalQuestions}</div>
                    <small class="text-muted">Total</small>
                </div>
            </div>
            
            <div class="alert ${passed ? 'alert-success' : 'alert-danger'}">
                <i class="bi ${passed ? 'bi-check-circle' : 'bi-x-circle'} me-2"></i>
                ${passed ? 'Félicitations ! Vous avez réussi le test.' : `Vous n\'avez pas atteint le score minimum requis (${testData.scoreMin}%).`}
            </div>
        </div>
    `;

    showModal(
        'Résultats du test',
        resultContent,
        `
        <button type="button" class="btn btn-outline-primary" onclick="reviewAnswers()">Réviser les réponses</button>
        <button type="button" class="btn btn-primary" onclick="window.location.href='dashboard.html'">Retour au tableau de bord</button>
        `
    );
}

function reviewAnswers() {
    // Implementation for reviewing answers
    console.log('Review answers functionality');
}

// Handle page visibility change (prevent cheating)
document.addEventListener('visibilitychange', function () {
    if (document.hidden) {
        console.log('User switched tab/window');
        // You could implement warnings or automatic submission here
    }
});

// Prevent right-click context menu
document.addEventListener('contextmenu', function (e) {
    e.preventDefault();
});

// Prevent common keyboard shortcuts
document.addEventListener('keydown', function (e) {
    // Prevent F12, Ctrl+Shift+I, Ctrl+U, etc.
    if (e.key === 'F12' ||
        (e.ctrlKey && e.shiftKey && e.key === 'I') ||
        (e.ctrlKey && e.key === 'u')) {
        e.preventDefault();
    }
});