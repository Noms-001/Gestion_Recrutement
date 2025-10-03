<%@ page session="true" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.entreprise.entity.*" %>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Dépôt de CV</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/logo.png">
</head>

<body>
    <div id="navbar-placeholder"></div>

    <div class="d-flex">
        <div id="sidebar-placeholder"></div>

        <main class="main-content flex-grow-1">
            <div class="container-fluid px-4 py-4">
                <form id="testForm" class="needs-validation" novalidate>

                    <!-- Étape 1 -->
                    <div class="card shadow-sm mb-4 step" id="step1">
                        <div class="card-header bg-primary text-white d-flex justify-content-between">
                            <h5 class="card-title mt-2"><i class="bi bi-gear me-2"></i>Configuration du test</h5>
                            
                            <div>
                                <input type="file" id="fileInput" accept=".pdf,.png,.jpg,.jpeg,.bmp" class="d-none">
                                <button type="button" class="btn btn-outline-primary m-1" id="importBtn">
                                    <i class="bi bi-file-earmark-arrow-down me-2"></i>Importer
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="mb-3">
                                    <label for="testTitle" class="form-label">Titre du test *</label>
                                    <input type="text" class="form-control" id="testTitle" required>
                                </div>
                                <div class="mb-3">
                                    <label for="testDuration" class="form-label">Durée (minutes) *</label>
                                    <input type="number" class="form-control" id="testDuration" min="1" max="1439" required>
                                </div>
                                <div class="mb-3">
                                    <label for="minScore" class="form-label">Score minimal (%) *</label>
                                    <input type="number" class="form-control" id="minScore" min="0" max="100" required>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button type="button" class="btn btn-primary" onclick="goToStep(2)">Suivant</button>
                        </div>
                    </div>

                    <!-- Étape 2 -->
                    <div class="card shadow-sm mb-4 step d-none" id="step2">
                        <div class="d-flex justify-content-between m-3">
                            <button type="button" class="btn btn-secondary" onclick="goToStep(1)">Précédent</button>
                        </div>
                        <div class="card-header text-white d-flex justify-content-between" style="background-color: var(--primary-dark);">
                            <h5 class="card-title mb-0"><i class="bi bi-question-circle me-2"></i>Questions du test</h5>
                            <div>
                                <button type="button" class="btn btn-light btn-sm me-2" onclick="addQuestion()">
                                    <i class="bi bi-plus-circle me-1"></i> Nouvelle question
                                </button>
                                <button type="button" class="btn btn-light btn-sm" data-bs-toggle="modal"
                                    data-bs-target="#questionBankModal">
                                    <i class="bi bi-collection me-1"></i> Banque de questions
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div id="questionsContainer"></div>
                            <p class="text-muted mb-3"> <i class="bi bi-info-circle me-1"></i> Vous pouvez ajouter
                                autant de questions que nécessaire. Chaque question doit avoir au minimum 2 réponses.
                            </p> <button type="button" class="btn btn-primary" onclick="addQuestion()"> <i
                                    class="bi bi-plus-circle me-2"></i> Ajouter une question </button>
                        </div>
                        <div class="card-footer text-end">
                            <button type="submit" class="btn btn-success"><i class="bi bi-check-circle me-1"></i>Créer
                                le
                                test</button>
                        </div>
                    </div>

                </form>
            </div>
        </main>

        <!-- Modal Banque de questions -->
        <div class="modal fade" id="questionBankModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title"><i class="bi bi-collection me-2"></i>Banque de questions</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="list-group">
                            <% 
                                List<Question> questions = (List<Question>) request.getAttribute("questions");
                                int qIndex = 0;
                                if (questions != null) {
                                    for (Question question : questions) {
                                        qIndex++;
                            %>
                            <div class="list-group-item d-flex justify-content-between align-items-center" id="bank-question-<%= question.getId() %>">
                                <div>
                                    <h6><%= question.getEnonce() %></h6>
                                    <small><%= question.getReponses().size() %> réponses • <%= question.getPoint() %> points</small>
                                </div>
                                <button type="button" class="btn btn-sm btn-outline-primary"
                                        onclick="addFromBank(
                                            '<%= question.getEnonce().replace("'", "\\'") %>',
                                            <%= question.getId() %>,
                                            [<%=
                                                question.getReponses().stream()
                                                    .map(r -> "{ valeur: '" + r.getValeur().replace("'", "\\'") + "', estCorrect: " + r.estCorrect(question) + " }")
                                                    .reduce((a,b) -> a + "," + b).orElse("")
                                            %>],
                                            <%= question.getPoint() %>
                                        )"
                                        data-bs-dismiss="modal">
                                    Ajouter
                                </button>

                            </div>
                            <%      }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>
    <script>
        const currentUser = {
            name: "<%= session.getAttribute("nom") %> <%= session.getAttribute("prenom") %>",
            initials: "<%= session.getAttribute("initiales") != null ? session.getAttribute("initiales") : "" %>",
           avatar: "<%= session.getAttribute("avatarColor")%>",
            id: "<%= session.getAttribute("id_utilisateur") %>",
            poste: "<%= session.getAttribute("poste") %>"
        };
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/create-test.js"></script>
    <!-- PDF.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.9.179/pdf.min.js"></script>
    <!-- Tesseract.js -->
    <script src="https://cdn.jsdelivr.net/npm/tesseract.js@4.1.1/dist/tesseract.min.js"></script>

    <script>
        function parseQCM(text) {
            const lines = text.split("\n").map(l => l.trim()).filter(l => l.length > 0);
            let questions = [], meta = { title: null, duration: null };
            let currentQ = null;
            let detectedQuestionRegex = null;
            let detectedAnswerRegex = null;

            const possibleQuestionRegexes = [
                /^\d+\./, /^\d\s/, /^Q\d+[:\)]/, /^Question\s*n[°]?\s*\d+/i, /^[IVXLCDM]+\./i
            ];
            const possibleAnswerRegexes = [
                /^[a-d]\)/i, /^\{\s*/, /^\-\s*/, /^R\d+/i
            ];
            meta.title = lines[0];

            for (let i = 0; i < lines.length; i++) {
                let line = lines[i];
                line = line.replace(/[◗❍]/g, '');

                // Meta
                if (!meta.title && /QCM|EXAMEN|Sujets/i.test(line)) meta.title = line;
                if (!meta.duration && /durée|temps/i.test(line)) {
                    const match = line.match(/(\d+)\s*(h|H|mn|minutes)?/);
                    if (match) {
                        let value = parseInt(match[1], 10);
                        if (match[2] && /h/i.test(match[2])) value = value * 60;
                        meta.duration = value;
                    }
                }

                // Détection dynamique
                if (!detectedQuestionRegex) {
                    for (let qR of possibleQuestionRegexes) {
                        if (qR.test(line)) {
                            detectedQuestionRegex = qR;
                            break;
                        }
                    }
                }
                if (!detectedAnswerRegex) {
                    for (let aR of possibleAnswerRegexes) {
                        if (aR.test(line)) {
                            detectedAnswerRegex = aR;
                            break;
                        }
                    }
                }

                // Cas 1 : question détectée
                if (detectedQuestionRegex && detectedQuestionRegex.test(line)) {
                    if (currentQ && currentQ.answers.length > 0) questions.push(currentQ);
                    currentQ = { question: line.replace(detectedQuestionRegex, '').trim(), answers: [] };
                    continue;
                }

                // Cas 2 : réponses détectées
                if (detectedAnswerRegex && detectedAnswerRegex.test(line)) {
                    if (!currentQ) currentQ = { question: lines[i - 1] || "", answers: [] };
                    const splitted = line.split(/(?=[a-d]\))/i)
                        .map(s => s.replace(detectedAnswerRegex, '').trim())
                        .filter(s => s);
                    currentQ.answers.push(...splitted);
                    continue;
                }

                // Cas 3 : question sans regex mais finissant par ?
                if (!detectedQuestionRegex && line.match(/[?]$/)) {
                    if (currentQ) questions.push(currentQ);
                    currentQ = { question: line.trim(), answers: [] };
                    continue;
                }

                // Cas 4 : réponses sans regex
                if (currentQ && !detectedAnswerRegex && i > 0) {
                    const splitted = line.split(/(?=[a-d]\.|\(?[a-d]\))/i)
                        .map(s => s.trim())
                        .filter(s => s);
                    if (splitted.length) currentQ.answers.push(...splitted);
                }
            }
            if (currentQ && currentQ.answers.length > 0) questions.push(currentQ);
            return { meta, questions };
        }

        // =======================
        // Extraction PDF
        // =======================
        async function extractTextFromPDF(file) {
            const arrayBuffer = await file.arrayBuffer();
            const pdf = await pdfjsLib.getDocument({ data: arrayBuffer }).promise;
            let textContent = "";

            for (let i = 1; i <= pdf.numPages; i++) {
                const page = await pdf.getPage(i);
                const text = await page.getTextContent();
                let linesMap = {};

                text.items.forEach(item => {
                    if (!item.str) return;
                    if (!item.transform || item.transform.length < 6) return;
                    const y = item.transform[5].toFixed(2);
                    if (!linesMap[y]) linesMap[y] = [];
                    linesMap[y].push(item.str);
                });

                const sortedKeys = Object.keys(linesMap).map(k => parseFloat(k)).sort((a, b) => b - a);
                sortedKeys.forEach(y => {
                    if (linesMap[y]) textContent += linesMap[y].join(" ") + "\n";
                });

                textContent += "\n";
            }
            return textContent;
        }

        // =======================
        // Remplissage formulaire
        // =======================
        function fillForm(parsed) {
            // Titre
            questionCount = 0;
            document.getElementById('testTitle').value = parsed.meta.title;
            // Durée
            if (parsed.meta.duration) document.getElementById('testDuration').value = parsed.meta.duration;

            // Questions
            const container = document.getElementById('questionsContainer');
            container.innerHTML = '';
            // Réinitialiser les questions
            container.innerHTML = '';

            // Ajouter les questions avec leurs réponses
            parsed.questions.forEach(q => {
                addQuestion(
                    q.question,                              // énoncé
                    q.answers.map(r => r),                   // réponses
                    0,                                       // index ou param optionnel
                    5                                        // points par défaut
                );
            });

            showToast("success", "PDF impoté avec succès !");

        }

        // =======================
        // Gestion import
        // =======================
        const fileInput = document.getElementById('fileInput');
        const importBtn = document.getElementById('importBtn');

        importBtn.addEventListener('click', () => fileInput.click());

        fileInput.addEventListener('change', async (evt) => {
            const file = evt.target.files[0];
            if (!file) return;
            try {
                const text = await extractTextFromPDF(file);
                const parsed = parseQCM(text);
                fillForm(parsed);
            } catch (err) {
                console.error("Erreur PDF :", err);
                showToast("danger", "Erreur lors de la lecture du PDF.");
            }
        });
    </script>

</body>

</html>