<%@ page session="true" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.entreprise.dto.AnnonceDTO" %>
<%@ page import="com.example.entreprise.entity.*" %>

<%
    List<AnnonceDTO> annonces = (List<AnnonceDTO>) request.getAttribute("annonces");
    List<Competence> competences = (List<Competence>) request.getAttribute("competences");
    List<Langue> langues = (List<Langue>) request.getAttribute("langues");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    List<Diplome> diplomes = (List<Diplome>) request.getAttribute("diplomes");

%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Offres d'emploi</title>
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 fw-bold">Offres d'emploi</h1>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-primary" data-bs-toggle="offcanvas" data-bs-target="#filtersOffcanvas">
                            <i class="bi bi-funnel me-2"></i>Filtres
                        </button>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-sort-down me-2"></i>Trier par
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Date de publication</a></li>
                                <li><a class="dropdown-item" href="#">Urgent</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- Search Bar -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-10">
                                <input type="text" class="form-control form-control-lg" placeholder="Rechercher un poste, un département, une ville...">
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary btn-lg w-100" id="btnSearch">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-end mb-2">
                    <small><i class="fs-6 bi bi-exclamation-triangle-fill text-danger me-1"></i> Indique une annonce urgente</small>
                </div>
                <div class="row flex-nowrap" id="jobsRow">
                    <div class="jobs-container" id="jobsContainer">
                        <!-- Jobs List -->
                        <div id="jobsList">
                            <!-- Job Cards dynamiques -->
                            <% if (annonces != null && !annonces.isEmpty()) { %>
                                <% for (AnnonceDTO annonce : annonces) { %>
                                    <div class="card mb-3 job-card" data-job-id="<%= annonce.id %>">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="d-flex align-items-start">
                                                        <div class="company-logo me-3">
                                                            <div class="bg-primary text-white rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                                                <i class="bi bi-building"></i>
                                                            </div>
                                                        </div>
                                                        <div class="flex-grow-1">
                                                            <h5 class="card-title mb-1">
                                                                <%= annonce.posteLibelle %>
                                                            </h5>
                                                            <p class="text-muted mb-2">
                                                                <% if(annonce.urgent != null && annonce.urgent) { %>
                                                                <span class="text-danger">
                                                                    <i class="fs-6 bi bi-exclamation-triangle-fill me-1"></i>
                                                                </span>
                                                                <% } %>
                                                                <%= annonce.departementNom %> • <%= annonce.villeNom %></p>
                                                            <p class="card-text mb-3">
                                                                <% 
                                                                    String description = annonce.description != null ? annonce.description : "";
                                                                    if (description.length() > 150) {
                                                                        description = description.substring(0, 150) + "...";
                                                                    }
                                                                %>
                                                                <%= description %>
                                                            </p>
                                                            <div class="d-flex flex-wrap gap-2">
                                                                <!-- Compétences -->
                                                                 <% if (annonce.competencesObligatoires != null) { %>
                                                                    <% for (String competence : annonce.competencesObligatoires) { %>
                                                                        <span class="badge bg-primary"><%= competence %></span>
                                                                    <% } %>
                                                                <% } %>

                                                                <% if (annonce.competences != null) { %>
                                                                    <% for (String competence : annonce.competences) { %>
                                                                        <span class="badge bg-primary"><%= competence %></span>
                                                                    <% } %>
                                                                <% } %>
                                                                
                                                                <!-- Langues -->
                                                                 <% if (annonce.languesObligatoires != null) { %>
                                                                    <% for (String langue : annonce.languesObligatoires) { %>
                                                                        <span class="badge bg-info"><%= langue %></span>
                                                                    <% } %>
                                                                <% } %>

                                                                <% if (annonce.langues != null) { %>
                                                                    <% for (String langue : annonce.langues) { %>
                                                                        <span class="badge bg-info"><%= langue %></span>
                                                                    <% } %>
                                                                <% } %>
                                                                
                                                                <!-- Expérience -->
                                                                <% if (annonce.anneeExperience != null && annonce.anneeExperience > 0) { %>
                                                                    <span class="badge bg-warning"><%= annonce.anneeExperience %> an(s) exp.</span>
                                                                <% } %>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 text-end">
                                                    <!-- Calcul du temps écoulé -->
                                                    <small class="text-muted date-creation" 
                                                        data-date-creation="<%= annonce.dateCreation != null ? annonce.dateCreation.toString() : "" %>">
                                                        Chargement...
                                                    </small>
                                                    <div class="mt-3 d-flex justify-content-end">
                                                        <button  style="height: 30px; overflow: hidden;" class="btn btn-outline-primary btn-sm me-2 btn-detailler" id="btn-detail-<%= annonce.id %>" onclick="openJobDetails(<%= annonce.id %>)">
                                                            <i class="bi bi-eye me-1"></i>Voir détails
                                                        </button>
                                                        <button class="btn btn-primary btn-sm btn-postuler" onclick="postulerAnnonce(<%= annonce.id %>)">
                                                            <i class="bi bi-send me-1"></i>Postuler
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            <% } else { %>
                                <div class="alert alert-info">
                                    Aucune annonce disponible pour le moment.
                                </div>
                            <% } %>
                        </div>
                        
                        <!-- Pagination -->
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Précédent</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Suivant</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    
                    <!-- Détails de l'annonce -->
                    <div class="job-details d-none" id="jobDetailsPanel">
                        <div class="card shadow-sm h-100">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0" id="jobDetailsTitle">Détails de l'offre</h5>
                                <button class="btn btn-sm btn-outline-secondary" onclick="closeJobDetails()">
                                    <i class="bi bi-x"></i>
                                </button>
                            </div>
                            <div class="card-body" id="jobDetailsContent">
                                <p class="text-muted">Sélectionnez une offre pour voir les détails.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Filters Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="filtersOffcanvas">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">Filtres de recherche</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <form id="form">
                <!-- Villes -->
                <div class="mb-4">
                    <label for="cityFilter" class="form-label fw-semibold">Ville</label>
                    <select class="form-select" id="cityFilter">
                        <option value="">Selectionnez des villes</option>
                        <% if(villes != null) { 
                            for(Ville ville : villes) {  %>
                            <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
                            <% } 
                        } %>
                    </select>
                    <div id="cityTags" class="mt-2"></div>
                </div>

                <!-- Diplôme -->
                <div class="mb-4">
                    <label for="diplomeFilter" class="form-label fw-semibold">Diplôme minimum</label>
                    <select class="form-select" id="diplomeFilter">
                        <option value="">Tous les diplômes</option>
                        <% if(diplomes != null) { 
                            for(Diplome diplome : diplomes) {  %>
                            <option value="<%= diplome.getId() %>"><%= diplome.getLibelle() %></option>
                            <% } 
                        } %>
                    </select>
                </div>

                <!-- Expérience -->
                <div class="mb-4">
                    <label for="experienceFilter" class="form-label fw-semibold">Années d'expérience</label>
                    <div id="experienceValue" class="fw-bold text-primary mb-2">2 ans</div>
                    <input type="range" class="form-range" min="0" max="10" value="2" id="experienceFilter">
                    <div class="d-flex justify-content-between">
                        <span>0 an</span>
                        <span>10+ ans</span>
                    </div>
                </div>

                <!-- Compétences -->
                <div class="mb-4">
                    <label for="skillsFilter" class="form-label fw-semibold">Compétences</label>
                    <select class="form-select" id="skillsFilter">
                        <option value="">Selectionner des compétences</option>
                        <% if(competences != null) { 
                            for(Competence competence : competences) {  %>
                            <option value="<%= competence.getId() %>"><%= competence.getLibelle() %></option>
                            <% } 
                        } %>
                    </select>
                    <div id="skillsTags" class="mt-2"></div>
                </div>

                <!-- Langues -->
                <div class="mb-4">
                    <label for="langsFilter" class="form-label fw-semibold">Langues</label>
                    <select class="form-select" id="langsFilter">
                        <option value="">Selectionner des langues</option>
                        <% if(langues != null) { 
                            for(Langue langue : langues) {  %>
                            <option value="<%= langue.getId() %>"><%= langue.getLibelle() %></option>
                            <% } 
                        } %>
                    </select>
                    <div id="langsTags" class="mt-2"></div>
                </div>
                <!-- Dans votre JSP, ajoutez cette section dans l'offcanvas de filtres -->
                <div class="mb-4">
                    <label class="form-label fw-semibold">Type d'annonce</label>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="urgentFilter">
                        <label class="form-check-label" for="urgentFilter">
                            <i class="fs-6 bi bi-exclamation-triangle-fill text-danger me-1"></i>
                            Afficher seulement les annonces urgentes
                        </label>
                    </div>
                </div>
                <!-- Boutons -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Appliquer les filtres</button>
                    <button type="reset" class="btn btn-outline-secondary">Réinitialiser</button>
                </div>
            </form>
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
        const error = "<%= request.getAttribute("error") %>";
        if(error != 'null') {
            showToast('danger', error);
        }
        
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/job-list.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/system-tag.js"></script>
</body>
</html>