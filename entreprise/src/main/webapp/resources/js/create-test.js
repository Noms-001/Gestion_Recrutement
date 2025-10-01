let questionCount = 0;

function goToStep(step) {
    if (step === 2) {
        // Vérification config remplie
        if (!document.getElementById('testForm').checkValidity()) {
            document.getElementById('testForm').reportValidity();
            return;
        }
    }
    document.querySelectorAll('.step').forEach(el => el.classList.add('d-none'));
    document.getElementById('step' + step).classList.remove('d-none');
    if (questionCount < 2) {
        addQuestion();
        addQuestion();
    }
}

function addQuestion(title = '', answers = [], correctIndex = 0, points = 5) {
    questionCount++;
    const qIndex = questionCount;
    const container = document.getElementById('questionsContainer');

    const questionDiv = document.createElement('div');
    questionDiv.classList.add('card', 'mb-3');
    questionDiv.innerHTML = `
        <div class="card-header d-flex justify-content-between align-items-center">
          <span class="fw-bold">Question ${qIndex}</span>
          <button type="button" class="btn btn-sm btn-danger" onclick="removeQuestion(this)"><i class="bi bi-trash-fill"></i></button>
        </div>
        <div class="card-body">
          <input type="text" class="form-control mb-2" placeholder="Intitulé de la question" value="${title}" required>
          <div class="answers"></div>
          <button type="button" class="btn btn-sm btn-outline-primary mt-2" onclick="addAnswer(this)">+ Réponse</button>
          <input type="number" class="form-control mt-2" placeholder="Points" value="${points}" required>
        </div>
      `;

    container.appendChild(questionDiv);

    const answersDiv = questionDiv.querySelector('.answers');
    if (answers.length > 0) {
        answers.forEach((ans, i) => {
            answersDiv.appendChild(createAnswer(ans, i === correctIndex));
        });
    } else {
        answersDiv.appendChild(createAnswer());
    }
}

function createAnswer(text = '', isCorrect = false) {
    const div = document.createElement('div');
    div.classList.add('input-group', 'mb-2');
    div.innerHTML = `
        <div class="input-group-text">
          <input type="radio" name="correct${questionCount}" ${isCorrect ? 'checked' : ''}>
        </div>
        <input type="text" class="form-control" placeholder="Réponse" value="${text}" required>
        <button type="button" class="btn btn-outline-danger" onclick="this.parentElement.remove()">X</button>
      `;
    return div;
}

function addAnswer(btn) {
    const answersDiv = btn.parentElement.querySelector('.answers');
    answersDiv.appendChild(createAnswer());
}

function removeQuestion(btn) {
    if (document.querySelectorAll("#questionsContainer .card").length > 2) {
        btn.closest('.card').remove();
        renumberQuestions();
    }
}

function renumberQuestions() {
    questionCount = 0;
    document.querySelectorAll('#questionsContainer .card').forEach((card, i) => {
        questionCount++;
        card.querySelector('.card-header span').innerText = 'Question ' + questionCount;
    });
}

function addFromBank(title, answers, correctIndex, points) {
    addQuestion(title, answers, correctIndex, points);
}

// Validation formulaire
document.getElementById('testForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const totalQuestions = document.querySelectorAll('#questionsContainer .card').length;
    if (totalQuestions < 2) {
        alert('Veuillez ajouter au moins 2 questions.');
        return;
    }
});