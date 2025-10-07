<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Test en ligne</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/logo.png">
</head>

<body style="display: none">
    <div id="navbar-placeholder"></div>

    <div class="d-flex">
        <div id="sidebar-placeholder"></div>

        <main class="main-content flex-grow-1">
            <div class="container-fluid px-4 py-4">
                <!-- Test Header -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-7">
                                <h1 class="h4 fw-bold mb-1" id="titre"></h1>
                                <p class="text-muted mb-0" id="info"></p>
                            </div>
                            <div class="col-md-5 text-end">
                                <div class="d-flex align-items-center justify-content-end gap-3">
                                    <div class="test-timer card" id="testTimer">
                                        <div class="text-center">
                                            <div class="h4 mb-1 text-primary" id="timeDisplay"></div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <div class="h5 mb-0 text-primary" id="currentQuestion">1</div>
                                        <small class="text-muted" id="sur"></small>
                                    </div>
                                    <button class="btn btn-warning" data-bs-toggle="modal"
                                        data-bs-target="#finishModal">
                                        <i class="bi bi-flag me-2"></i>Terminer maintenant
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Question Area -->
                    <div class="col-lg-9">
                        <div class="card">
                            <div class="card-body p-4">
                                <div class="question-content" id="questionContent">
                                    <div class="mb-4">
                                        <span class="badge bg-primary mb-2">Question 1</span>
                                        <h5 class="fw-semibold">Quelle est la méthode recommandée pour gérer l'état
                                            local dans un composant React?</h5>
                                    </div>

                                    <div class="answers-container">
                                        <div class="form-check mb-3 p-3 border rounded">
                                            <input class="form-check-input" type="radio" name="q1" id="q1a" value="a">
                                            <label class="form-check-label w-100" for="q1a">
                                                <strong>A)</strong> Utiliser des variables globales
                                            </label>
                                        </div>
                                        <div class="form-check mb-3 p-3 border rounded">
                                            <input class="form-check-input" type="radio" name="q1" id="q1b" value="b">
                                            <label class="form-check-label w-100" for="q1b">
                                                <strong>B)</strong> Utiliser le hook useState()
                                            </label>
                                        </div>
                                        <div class="form-check mb-3 p-3 border rounded">
                                            <input class="form-check-input" type="radio" name="q1" id="q1c" value="c">
                                            <label class="form-check-label w-100" for="q1c">
                                                <strong>C)</strong> Stocker les données dans localStorage
                                            </label>
                                        </div>
                                        <div class="form-check mb-3 p-3 border rounded">
                                            <input class="form-check-input" type="radio" name="q1" id="q1d" value="d">
                                            <label class="form-check-label w-100" for="q1d">
                                                <strong>D)</strong> Utiliser des cookies
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Navigation Buttons -->
                                <div class="d-flex justify-content-between mt-4 pt-3 border-top">
                                    <button class="btn btn-outline-secondary" id="prevBtn" disabled>
                                        <i class="bi bi-chevron-left me-2"></i>Précédent
                                    </button>
                                    <button class="btn btn-primary" id="nextBtn">
                                        Suivant<i class="bi bi-chevron-right ms-2"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Questions Navigation -->
                    <div class="col-lg-3">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="card-title mb-0">Navigation des questions</h6>
                            </div>
                            <div class="card-body">
                                <div class="question-nav d-flex flex-wrap" id="questionNav">
                                    <!-- Question buttons will be generated here -->
                                </div>

                                <div class="mt-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="btn btn-primary btn-sm me-2" style="width: 30px; height: 30px;">
                                        </div>
                                        <small>Question actuelle</small>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="btn btn-success btn-sm me-2" style="width: 30px; height: 30px;">
                                        </div>
                                        <small>Répondue</small>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="btn btn-outline-secondary btn-sm me-2"
                                            style="width: 30px; height: 30px;"></div>
                                        <small>Non répondue</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Progress -->
                        <div class="card mt-3">
                            <div class="card-body text-center">
                                <h6 class="card-title">Progression</h6>
                                <div class="position-relative">
                                    <svg class="progress-ring" width="80" height="80">
                                        <circle class="progress-ring-circle" cx="40" cy="40" r="35" fill="transparent"
                                            stroke="#e9ecef" stroke-width="6" />
                                        <circle class="progress-ring-progress" cx="40" cy="40" r="35" fill="transparent"
                                            stroke="#0d6efd" stroke-width="6" stroke-linecap="round"
                                            stroke-dasharray="220" stroke-dashoffset="220" id="progressCircle" />
                                    </svg>
                                    <div class="position-absolute top-50 start-50 translate-middle">
                                        <div class="h5 mb-0" id="progressPercent">0%</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Finish Test Modal -->
    <div class="modal fade" id="finishModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Terminer le test</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle me-2"></i>
                        Êtes-vous sûr de vouloir terminer le test maintenant ?
                    </div>
                    <div class="row text-center">
                        <div class="col-4">
                            <div class="h4 text-success" id="answeredCount">0</div>
                            <small class="text-muted">Répondues</small>
                        </div>
                        <div class="col-4">
                            <div class="h4 text-warning" id="remainingCount">20</div>
                            <small class="text-muted">Restantes</small>
                        </div>
                        <div class="col-4">
                            <div class="h4 text-primary" id="totalCount">20</div>
                            <small class="text-muted">Total</small>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Continuer le
                        test</button>
                    <button type="button" class="btn btn-warning" onclick="finishTest()">
                        <i class="bi bi-flag me-2"></i>Terminer maintenant
                    </button>
                </div>
            </div>
        </div>
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
        const testId = "<%= request.getParameter("testId") %>";
    </script>
<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/online-test.js"></script>
</body>

</html>