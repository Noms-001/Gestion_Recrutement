<%@ page session="true" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0"><i class="bi bi-gear me-2"></i>Configuration du test</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="mb-3">
                                    <label for="testTitle" class="form-label">Titre du test *</label>
                                    <input type="text" class="form-control" id="testTitle" required>
                                </div>
                                <div class="mb-3">
                                    <label for="testDuration" class="form-label">Durée (minutes) *</label>
                                    <input type="number" class="form-control" id="testDuration" required>
                                </div>
                                <div class="mb-3">
                                    <label for="minScore" class="form-label">Score minimal (%) *</label>
                                    <input type="number" class="form-control" id="minScore" required>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-end">
                            <button type="button" class="btn btn-primary" onclick="goToStep(2)">Suivant</button>
                        </div>
                    </div>

                    <!-- Étape 2 -->
                    <div class="card shadow-sm mb-4 step d-none" id="step2">
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
                        <div class="card-footer d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" onclick="goToStep(1)">Précédent</button>
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
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <h6>Qu'est-ce que le DOM ?</h6>
                                    <small>JavaScript • 15 points</small>
                                </div>
                                <button class="btn btn-sm btn-outline-primary"
                                    onclick="addFromBank('Qu\'est-ce que le DOM ?', ['Une API du navigateur','Un langage','Une base de données'], 0, 15)"
                                    data-bs-dismiss="modal">Ajouter</button>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <h6>Différence entre let et var ?</h6>
                                    <small>JavaScript • 10 points</small>
                                </div>
                                <button class="btn btn-sm btn-outline-primary"
                                    onclick="addFromBank('Différence entre let et var ?', ['let est bloc-scopé','var est fonction-scopé','aucune différence'], 2, 10)"
                                    data-bs-dismiss="modal">Ajouter</button>
                            </div>
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
            initials: "<%= session.getAttribute("nom") != null && session.getAttribute("prenom") != null ? 
                        session.getAttribute("nom").substring(0,1).toUpperCase() + session.getAttribute("prenom").substring(0,1).toUpperCase() 
                        : "" %>",
            avatar: "<%= session.getAttribute("avatarColor")%>",
            id: "<%= session.getAttribute("id_utilisateur") %>",
            poste: "<%= session.getAttribute("poste") %>"
        };
    </script>
<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/create-test.js"></script>
</body>

</html>