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
        const id = card.getAttribute("data-qid"); // 🔑 récupérer id banque
        addedQuestions.delete(id);
        card.remove();
        renumberQuestions();

        // 🔑 réafficher la question dans la banque
        const bankItem = document.getElementById("bank-question-" + id);
        if (bankItem) {
            bankItem.classList.remove("d-none");
            bankItem.classList.add("d-flex");
        } 
    }
}


function renumberQuestions() {
    questionCount = 0;
    document.querySelectorAll('#questionsContainer .card').forEach((card, i) => {
        questionCount++;
        card.querySelector('.card-header span').innerText = 'Question ' + questionCount;
    });
}

function addFromBank(title, id, answers, points) {
    if (addedQuestions.has(id)) {
        return; // plus besoin de message
    }
    questionCount++;
    const qIndex = questionCount;
    const container = document.getElementById('questionsContainer');

    const questionDiv = document.createElement('div');
    questionDiv.classList.add('card', 'mb-3');
    questionDiv.setAttribute("data-qindex", qIndex);
    questionDiv.setAttribute("data-qid", id); // 🔑 stocker l’id

    questionDiv.innerHTML = `
        <div class="card-header d-flex justify-content-between align-items-center">
          <span class="fw-bold">Question ${qIndex}</span>
          <button type="button" class="btn btn-sm btn-danger" onclick="removeQuestion(this)">
            <i class="bi bi-trash-fill"></i>
          </button>
        </div>
        <div class="card-body">
          <input type="text" class="form-control mb-2" value="${title}" required>
          <div class="answers"></div>
          <button type="button" class="btn btn-sm btn-outline-primary mt-2" onclick="addAnswer(this)">+ Réponse</button>
          <input type="number" class="form-control mt-2" value="${points}" required>
        </div>
    `;

    container.appendChild(questionDiv);

    const answersDiv = questionDiv.querySelector('.answers');
    answers.forEach(ans => {
        answersDiv.appendChild(createAnswer(ans.valeur, ans.estCorrect, qIndex));
    });

    addedQuestions.add(id);

    // 🔑 cacher l’item de la banque
    const item = document.getElementById("bank-question-" + id);
    if (item) {
        item.classList.remove("d-flex");
        item.classList.add("d-none");
    }
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
        const card = questions[i];
        const enonce = card.querySelector('input[type="text"]').value.trim();
        const point = card.querySelector('input[type="number"]').value;

        if (!enonce) {
            showToast('warning', `La question ${i + 1} doit avoir un intitulé.`);
            return;
        }
        if (!point || point <= 0) {
            showToast('warning', `La question ${i + 1} doit avoir un nombre de points valide.`);
            return;
        }

        const answers = card.querySelectorAll('.answers .input-group');
        if (answers.length < 2) {
            showToast('warning', `La question ${i + 1} doit avoir au moins 2 réponses.`);
            return;
        }

        let hasCorrect = false;
        for (const ans of answers) {
            const valeur = ans.querySelector('input[type="text"]').value.trim();
            const estCorrect = ans.querySelector('input[type="radio"]').checked;
            if (!valeur) {
                showToast('warning', `Toutes les réponses de la question ${i + 1} doivent être remplies.`);
                return;
            }
            if (estCorrect) hasCorrect = true;
        }
        if (!hasCorrect) {
            showToast('warning', `La question ${i + 1} doit avoir une réponse correcte.`);
            return;
        }
    }

    // Si tout est OK -> préparer données
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
        reloadQuestionBank();
        resetTestForm();
    } else {
        showToast('danger', 'Erreur lors de la création du test.');
    }
});

async function reloadQuestionBank() {
    try {
        const response = await fetch('/tests/questions');
        if (!response.ok) throw new Error('Erreur lors du chargement des questions');
        const questions = await response.json();

        const listGroup = document.querySelector('#questionBankModal .list-group');
        listGroup.innerHTML = ''; // vider la liste

        questions.forEach(question => {
            console.log(question.reponses);
            const item = document.createElement('div');
            item.classList.add('list-group-item', 'd-flex', 'justify-content-between', 'align-items-center');
            item.setAttribute("id", "bank-question-" + question.id); // 🔑 identifiant unique
            item.innerHTML = `
        <div>
            <h6>${question.enonce}</h6>
            <small>${question.reponses.length} réponses • ${question.point} points</small>
        </div>
        <button type="button" class="btn btn-sm btn-outline-primary"
            onclick="addFromBank('${question.enonce.replace(/'/g, "\\'")}', ${question.id}, [${question.reponses.map(r => `{valeur: '${r.valeur}', estCorrect: ${r.estCorrect}}`).join(", ")}], ${question.point})"
            data-bs-dismiss="modal">
            Ajouter
        </button>
    `;
            listGroup.appendChild(item);
        });

    } catch (error) {
        console.error(error);
        showToast('danger', 'Impossible de recharger la banque de questions.');
    }
}

function resetTestForm() {
    // Réinitialiser les champs de configuration
    document.getElementById('testForm').reset();

    // Cacher toutes les étapes et afficher la première
    document.querySelectorAll('.step').forEach(el => el.classList.add('d-none'));
    document.getElementById('step1').classList.remove('d-none');

    // Vider toutes les questions ajoutées
    const container = document.getElementById('questionsContainer');
    container.innerHTML = '';

    // Réinitialiser les compteurs et la liste des questions ajoutées
    questionCount = 0;
    addedQuestions.clear();
}
