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
    <title>TalentSphere - Tableau de bord</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/logo.png">
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
                                247 candidats trouvés
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
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Marie Dubois" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Marie Dubois</h6>
                                                <p class="text-muted mb-1">Développeur Frontend</p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted">Paris, France</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-success">Disponible</span>
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary">3 ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-success">85/100</div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info">27 ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-primary me-1">React</span>
                                            <span class="badge bg-primary me-1">JavaScript</span>
                                            <span class="badge bg-primary">TypeScript</span>
                                            <br>
                                            <span class="badge bg-secondary mt-1 me-1">Anglais</span>
                                            <span class="badge bg-secondary mt-1">Espagnol</span>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                Master en Informatique
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm" onclick="sendEmail('marie-dubois')">
                                                <i class="bi bi-envelope me-1"></i>
                                                Envoyer email
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Candidate 2 -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Thomas Leroy" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Thomas Leroy</h6>
                                                <p class="text-muted mb-1">Chef de projet</p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted">Lyon, France</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-warning">En entretien</span>
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary">5 ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-warning">72/100</div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info">32 ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-success me-1">Agile</span>
                                            <span class="badge bg-success me-1">Scrum</span>
                                            <span class="badge bg-info">Management</span>
                                            <br>
                                            <span class="badge bg-secondary mt-1 me-1">Français</span>
                                            <span class="badge bg-secondary mt-1">Anglais</span>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                École de Commerce
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm" onclick="sendEmail('thomas-leroy')">
                                                <i class="bi bi-envelope me-1"></i>
                                                Envoyer email
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Candidate 3 -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.pexels.com/photos/1036627/pexels-photo-1036627.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Sophie Bernard" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Sophie Bernard</h6>
                                                <p class="text-muted mb-1">Designer UX/UI</p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted">Bordeaux, France</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-success">Disponible</span>
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary">4 ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-success">92/100</div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info">29 ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-info me-1">Figma</span>
                                            <span class="badge bg-info me-1">Sketch</span>
                                            <span class="badge bg-info">Photoshop</span>
                                            <br>
                                            <span class="badge bg-secondary mt-1 me-1">Français</span>
                                            <span class="badge bg-secondary mt-1">Anglais</span>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                École d'Art et Design
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm"
                                                onclick="sendEmail('sophie-bernard')">
                                                <i class="bi bi-envelope me-1"></i>
                                                Envoyer email
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Candidate 4 -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Pierre Martin" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Pierre Martin</h6>
                                                <p class="text-muted mb-1">Développeur Backend</p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted">Télétravail</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-danger">Non retenu</span>
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary">2 ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-danger">58/100</div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info">25 ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-warning me-1">Python</span>
                                            <span class="badge bg-warning me-1">Django</span>
                                            <span class="badge bg-secondary">PostgreSQL</span>
                                            <br>
                                            <span class="badge bg-secondary mt-1">Français</span>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                DUT Informatique
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-secondary btn-sm" disabled>
                                                <i class="bi bi-x-circle me-1"></i>
                                                Non retenu
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Candidate 5 -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.pexels.com/photos/1181690/pexels-photo-1181690.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Lisa Garcia" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Lisa Garcia</h6>
                                                <p class="text-muted mb-1">Commerciale</p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted">Marseille, France</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-info">Recruté</span>
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary">6 ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-success">88/100</div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info">31 ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-success me-1">Vente</span>
                                            <span class="badge bg-success me-1">CRM</span>
                                            <span class="badge bg-success">Négociation</span>
                                            <br>
                                            <span class="badge bg-secondary mt-1 me-1">Français</span>
                                            <span class="badge bg-secondary mt-1 me-1">Anglais</span>
                                            <span class="badge bg-secondary mt-1">Espagnol</span>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                Master Commerce International
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-info btn-sm" disabled>
                                                <i class="bi bi-check-circle me-1"></i>
                                                Recruté
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Candidate 6 -->
                            <div class="col-lg-4 col-md-4">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Alex Johnson" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Alex Johnson</h6>
                                                <p class="text-muted mb-1">Data Analyst</p>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-geo-alt text-muted me-1"></i>
                                                    <small class="text-muted">Nantes, France</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-primary">Nouveau</span>
                                        </div>

                                        <div class="row g-2 mb-3 text-center">
                                            <div class="col-4">
                                                <div class="fw-bold text-primary">3 ans</div>
                                                <small class="text-muted">Expérience</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-success">89/100</div>
                                                <small class="text-muted">Score test</small>
                                            </div>
                                            <div class="col-4">
                                                <div class="fw-bold text-info">28 ans</div>
                                                <small class="text-muted">Âge</small>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-warning me-1">Python</span>
                                            <span class="badge bg-warning me-1">SQL</span>
                                            <span class="badge bg-warning">Tableau</span>
                                            <br>
                                            <span class="badge bg-secondary mt-1 me-1">Français</span>
                                            <span class="badge bg-secondary mt-1">Anglais</span>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <i class="bi bi-mortarboard me-1"></i>
                                                Master Data Science
                                            </small>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm" onclick="sendEmail('alex-johnson')">
                                                <i class="bi bi-envelope me-1"></i>
                                                Envoyer email
                                            </button>

                                        </div>
                                    </div>
                                </div>
                            </div>
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
            initials: "<%= session.getAttribute("nom") != null && session.getAttribute("prenom") != null ? 
                        session.getAttribute("nom").substring(0,1).toUpperCase() + session.getAttribute("prenom").substring(0,1).toUpperCase() 
                        : "" %>",
            avatar: "<%= session.getAttribute("avatarColor")%>",
            id: "<%= session.getAttribute("id_utilisateur") %>",
            poste: "<%= session.getAttribute("poste") %>"
        };
    </script>
<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/candidat-tag.js"></script>
</body>

</html>