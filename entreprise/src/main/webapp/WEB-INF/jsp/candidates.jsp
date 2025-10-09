<%@ page session="true" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import= "com.example.entreprise.dto.*, java.util.List" %>
<% List<CandidatureDTO> candidatures = (List<CandidatureDTO>) request.getAttribute("candidatures");%>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Tableau de bord</title>
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
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="mb-4"></div>

                        <!-- Filters Panel -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="card-title mb-0">
                                    <i class="bi bi-funnel me-2"></i>
                                    Filtres de recherche
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <!-- Nom -->
                                    <div class="col-md-3">
                                        <label for="searchName" class="form-label">Nom / Prénom</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                                            <input type="text" class="form-control" id="searchName"
                                                placeholder="Rechercher...">
                                        </div>
                                    </div>

                                    <!-- Expérience -->
                                    <div class="col-md-2">
                                        <label for="experienceFilter" class="form-label">Expérience (années)</label>
                                        <input type="number" class="form-control" id="experienceFilter" min="0"
                                            placeholder="ex: 3">
                                    </div>

                                    <!-- Âge -->
                                    <div class="col-md-2">
                                        <label for="ageFilter" class="form-label">Âge</label>
                                        <input type="number" class="form-control" id="ageFilter" min="18"
                                            placeholder="ex: 25">
                                    </div>

                                    <!-- Proximité -->
                                    <div class="col-md-2">
                                        <label for="proximityFilter" class="form-label">Proximité</label>
                                        <select class="form-select" id="proximityFilter">
                                            <option value="">Toute localisation</option>
                                            <option value="local">Local (Paris)</option>
                                            <option value="idf">Île-de-France</option>
                                            <option value="france">France</option>
                                            <option value="remote">Télétravail</option>
                                        </select>
                                    </div>

                                    <!-- Diplôme -->
                                    <div class="col-md-3">
                                        <label for="degreeFilter" class="form-label">Diplôme minimum</label>
                                        <select class="form-select" id="degreeFilter">
                                            <option value="">Tous niveaux</option>
                                            <option value="bac">Baccalauréat</option>
                                            <option value="bac2">Bac+2</option>
                                            <option value="bac3">Bac+3</option>
                                            <option value="bac5">Bac+5</option>
                                            <option value="doctorat">Doctorat</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Compétences & Langues -->
                                <div class="row g-3 mt-3">
                                    <!-- Compétences -->
                                    <div class="col-md-6">
                                        <label for="skillsFilter" class="form-label">Compétences</label>
                                        <div class="input-group">
                                            <select class="form-select" id="skillsFilter">
                                                <option value="">Choisir...</option>
                                                <option value="javascript">JavaScript</option>
                                                <option value="react">React</option>
                                                <option value="typescript">TypeScript</option>
                                                <option value="python">Python</option>
                                                <option value="php">PHP</option>
                                                <option value="java">Java</option>
                                                <option value="css">CSS</option>
                                                <option value="html">HTML</option>
                                                <option value="nodejs">Node.js</option>
                                                <option value="angular">Angular</option>
                                            </select>
                                            <button type="button" class="btn btn-outline-primary"
                                                onclick="addTag('skills')">
                                                <i class="bi bi-plus-circle"></i>
                                            </button>
                                        </div>
                                        <div id="skillsContainer" class="mt-2 d-flex flex-wrap gap-2"></div>
                                    </div>

                                    <!-- Langues -->
                                    <div class="col-md-6">
                                        <label for="languagesFilter" class="form-label">Langues</label>
                                        <div class="input-group">
                                            <select class="form-select" id="languagesFilter">
                                                <option value="">Choisir...</option>
                                                <option value="francais">Français</option>
                                                <option value="anglais">Anglais</option>
                                                <option value="espagnol">Espagnol</option>
                                                <option value="allemand">Allemand</option>
                                                <option value="italien">Italien</option>
                                                <option value="chinois">Chinois</option>
                                                <option value="japonais">Japonais</option>
                                            </select>
                                            <button type="button" class="btn btn-outline-primary"
                                                onclick="addTag('languages')">
                                                <i class="bi bi-plus-circle"></i>
                                            </button>
                                        </div>
                                        <div id="languagesContainer" class="mt-2 d-flex flex-wrap gap-2"></div>
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="row g-3 mt-3">
                                    <div class="col-md-12 d-flex justify-content-end">
                                        <button class="btn btn-primary me-2">
                                            <i class="bi bi-search me-1"></i> Rechercher
                                        </button>
                                        <button type="reset" class="btn btn-outline-secondary" onclick="resetFilters()">
                                            <i class="bi bi-arrow-clockwise me-1"></i> Réinitialiser
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>




                        <!-- Results Summary -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="text-muted">
                                <i class="bi bi-info-circle me-1"></i>
                                <% if(candidatures != null) { %> <%= candidatures.size() %> <% } %> candidats trouvés
                            </div>
                            <div class="d-flex align-items-center">
                                <span class="text-muted me-2">Trier par:</span>
                                <select class="form-select form-select-sm" style="width: auto;">
                                    <option value="recent">Plus récent</option>
                                    <option value="name">Nom</option>
                                    <option value="experience">Expérience</option>
                                    <option value="score">Score</option>
                                </select>
                            </div>
                        </div>

                        <!-- Candidates List -->
                        <div class="row g-4">
                            <!-- Candidate 1 -->
                             <% if(candidatures != null) { %>
                                <% for(CandidatureDTO candidature : candidatures) { %>
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="${pageContext.request.contextPath}/<%= candidature.photo %>"
                                                alt="Photo" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1"><%= candidature.nom %> <%= candidature.prenom %></h6>
                                                <p class="text-muted mb-1"><%= candidature.descriptionExperience %></p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted"><%= candidature.adresse %></small>
                                                </div>
                                            </div>
                                            <!-- <span class="badge bg-success">Disponible</span> -->
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary"><%= candidature.anneeExperience %> ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-success"><%= candidature.scoreTest %></div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info"><%= candidature.age %> ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <% if(candidature.competences != null) { %>
                                                <% for(String competence : candidature.competences) { %>
                                                    <span class="badge bg-primary me-1"><%= competence %></span>
                                                <% } %>
                                            <% } else { %>
                                                <small class="text-center">Aucune compétence technique</small>
                                            <% } %>
                                            <br>
                                            <% if (candidature.langues != null) { %>
                                                <% for (String langue : candidature.langues) { %>
                                                    <span class="badge bg-secondary mt-1 me-1"><%= langue %></span>
                                                <% } %>
                                            <% } else { %>
                                                <small class="text-center">Aucune compétence linguistique</small>
                                            <% } %>

                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                <%= candidature.filiere %>
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm" onclick="sendEmail('marie-dubois')">
                                                <i class="bi bi-search me-1"></i>
                                                Voir compatibilité
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                            <% } %>
                        </div>

                        <!-- Pagination -->
                        <div class="d-flex justify-content-center mt-4">
                            <nav>
                                <ul class="pagination">
                                    <li class="page-item disabled">
                                        <span class="page-link">Précédent</span>
                                    </li>
                                    <li class="page-item active">
                                        <span class="page-link">1</span>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">2</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">3</a>
                                    </li>
                                    <li class="page-item">
                                        <span class="page-link">...</span>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">12</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Suivant</a>
                                    </li>
                                </ul>
                            </nav>
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
    <script src="${pageContext.request.contextPath}/resources/js/candidat-tag.js"></script>
</body>

</html>