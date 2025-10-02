let questionCount = 0;
let addedQuestions = new Set(); // 🔑 mémorise les questions déjà ajoutées

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
    questionDiv.setAttribute("data-qindex", qIndex); // 🔑 identifiant unique
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
            answersDiv.appendChild(createAnswer(ans, i === correctIndex, qIndex));
        });
    } else {
        answersDiv.appendChild(createAnswer('', false, qIndex));
    }
}


function createAnswer(text = '', isCorrect = false, qIndex) {
    const div = document.createElement('div');
    div.classList.add('input-group', 'mb-2');
    div.innerHTML = `
        <div class="input-group-text">
          <input type="radio" name="correct${qIndex}" ${isCorrect ? 'checked' : ''}>
        </div>
        <input type="text" class="form-control" placeholder="Réponse" value="${text}" required>
        <button type="button" class="btn btn-outline-danger" onclick="this.parentElement.remove()">X</button>
      `;
    return div;
}


function addAnswer(btn) {
    const answersDiv = btn.parentElement.querySelector('.answers');
    const qIndex = btn.closest('.card').getAttribute("data-qindex");
    answersDiv.appendChild(createAnswer('', false, qIndex));
}

function removeQuestion(btn) {
    if (document.querySelectorAll("#questionsContainer .card").length > 2) {
        const card = btn.closest('.card');
        const title = card.querySelector('input[type="text"]').value;
        addedQuestions.delete(title); // 🔑 libère la question pour pouvoir la réajouter
        card.remove();
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
    if (addedQuestions.has(title)) {
        showToast('warning', 'Cette question a déjà été ajoutée.');
        return;
    }
    addQuestion(title, answers, correctIndex, points);
    addedQuestions.add(title);
}

// Validation formulaire
document.getElementById('testForm').addEventListener('submit', async function (e) {
    e.preventDefault();

    const questions = document.querySelectorAll('#questionsContainer .card');
    if (questions.length < 2) {
        showToast('warning', 'Veuillez ajouter au moins 2 questions.');
        return;
    }

    for (let i = 0; i < questions.length; i++) {
        const answers = questions[i].querySelectorAll('.answers .input-group');
        if (answers.length < 2) {
            showToast('warning', `La question ${i + 1} doit avoir au moins 2 réponses.`);
            return;
        }
    }

    // Si on arrive ici => tout est OK
    const questionsData = [];
    questions.forEach(card => {
        const enonce = card.querySelector('input[type="text"]').value;
        const point = parseInt(card.querySelector('input[type="number"]').value);

        const reponses = [];
        card.querySelectorAll('.answers .input-group').forEach(ans => {
            const valeur = ans.querySelector('input[type="text"]').value;
            const estCorrect = ans.querySelector('input[type="radio"]').checked;
            reponses.push({ valeur, estCorrect });
        });

        questionsData.push({ enonce, point, reponses });
    });

    const test = {
        titre: document.getElementById('testTitle').value,
        temps: parseInt(document.getElementById('testDuration').value), // minutes
        scoreMin: parseInt(document.getElementById('minScore').value),
        questions: questionsData
    };

    const response = await fetch('/tests', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(test)
    });

    if (response.ok) {
        showToast('success', 'Test créé avec succès !');
    } else {
        showToast('danger', 'Erreur lors de la création du test.');
    }
});