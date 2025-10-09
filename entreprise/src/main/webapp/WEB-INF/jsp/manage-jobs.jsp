<%@ page session="true" %>
<%@ page import="java.util.*, java.time.*" %>
<%@ page import="com.example.entreprise.entity.Annonce,
                    com.example.entreprise.entity.Ville,
                    com.example.entreprise.entity.Departement, 
                    com.example.entreprise.entity.Poste,
                    com.example.entreprise.entity.Diplome,
                    com.example.entreprise.entity.Filiere,
                    com.example.entreprise.entity.Langue,
                    com.example.entreprise.entity.Competence,
                    com.example.entreprise.entity.Test
                " %>
<%
    List<Annonce> annonces = (List<Annonce>) request.getAttribute("annonces");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    List<Departement> departements = (List<Departement>) request.getAttribute("departements");
    List<Poste> postes = (List<Poste>) request.getAttribute("postes");
    List<Diplome> diplomes = (List<Diplome>) request.getAttribute("diplomes");
    List<Filiere> filieres = (List<Filiere>) request.getAttribute("filieres");
    List<Langue> langues = (List<Langue>) request.getAttribute("langues");
    List<Competence> competences = (List<Competence>) request.getAttribute("competences");
    List<Test> tests = (List<Test>) request.getAttribute("tests");

    if(session.getAttribute("id_utilisateur") == null) {
        response.sendRedirect("/");
    } 
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <div class="container-fluid px-4 py-4">
                <div class="row">
                    <div class="col-12">
                        <div class="d-flex justify-content-end align-items-center mb-4">
                            <div class="d-flex align-items-center">
                                <button class="btn btn-primary me-2" data-bs-toggle="modal"
                                    data-bs-target="#jobOfferModal">
                                    <i class="bi bi-plus-circle me-1"></i>
                                    Nouvelle annonce
                                </button>
                            </div>
                        </div>

                        <!-- Filters -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="bi bi-search"></i>
                                            </span>
                                            <input type="text" class="form-control" name='poste'  id="filterPoste"
                                                placeholder="Rechercher une annonce...">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select" id="filterStatus" name="status">
                                            <option value="">Statut</option>
                                            <option value="active">Active</option>
                                            <option value="expiree">Expirée</option>
                                            <option value="fermee">Fermée</option>
                                        </select>
                                    </div>

                                    <div class="col-md-2">
                                        <select class="form-select" id="filterVille" name="ville">
                                            <option value="">Ville</option>
                                            <% for(Ville ville : villes) { %>
                                                <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
                                            <% } %>
                                        </select>
                                    </div>

                                    <div class="col-md-2">
                                        <select class="form-select" id="filterDepartement" name="departement">
                                            <option value="">Département</option>
                                            <% for(Departement dep : departements) { %>
                                                <option value="<%= dep.getId() %>"><%= dep.getNom() %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-primary w-100" id="btnFilter">
                                            <i class="bi bi-funnel me-1"></i>
                                            Filtrer
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    <!-- Job Offers Table -->
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-0">
                            <div class="table-responsive" style="overflow: visible !important;">
                                <table class="table table-hover mb-0">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>Poste</th>
                                            <th>Departement</th>
                                            <th>Statut</th>
                                            <th>Candidatures</th>
                                            <th>Date de création</th>
                                            <th>Date d'expiration</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="annonceTableBody">
                                        <% int i = 0;
                                        for(Annonce annonce : annonces) { 
                                            String color = "bg-secondary";
                                            if(i % 3 == 0) {
                                                color = "bg-primary";
                                            } else if(i % 3 == 1) {
                                                color = "bg-info";
                                            }
                                            i++;
                                            %>
                                            <tr>
                                                <td>
                                                    <div class="fw-medium"><%= annonce.getPoste().getLibelle() %></div>
                                                    <small class="text-muted"> <%= annonce.getUrgent() == true && annonce.getFerme() == false ? "<i class=\"bi bi-exclamation-triangle me-1 text-danger\"></i>" : ""%> <%= annonce.getAnneeExperience() != null ? annonce.getAnneeExperience() + " ans" : "" %> <%= annonce.getVille() != null ? " • " + annonce.getVille().getNom() : "" %></small>
                                                </td>
                                                <td>
                                                    <span class="badge <%=color%>"><%= annonce.getPoste().getDepartement().getNom() %></span>
                                                </td>
                                                <td>
                                                    <% 
                                                        if(annonce.getFerme() != null && annonce.getFerme()) { %>
                                                            <span class="badge bg-dark">Fermée</span>
                                                    <% } else if(annonce.getDateLimite() != null && annonce.getDateLimite().isBefore(LocalDate.now())) { %>
                                                            <span class="badge bg-danger">Expirée</span>
                                                    <% } else { %>
                                                            <span class="badge bg-success">Active</span>
                                                    <% } %>

                                                    </td>
                                                    <td>
                                                        <div class="fw-bold"><%= annonce.getCandidatures() != null ? annonce.getCandidatures().size() : 0 %></div>
                                                        <small class="text-muted">candidatures</small>
                                                    </td>
                                                    <td><%= annonce.getDateCreation() %></td>
                                                    <td><%= annonce.getDateLimite() %></td>
                                                    <td>
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                                    type="button" data-bs-toggle="dropdown">
                                                                Actions
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <% if(!annonce.getFerme()) { %>
                                                                    <li><a class="dropdown-item" href="#" onclick="editJobOffer(<%= annonce.getId() %>)"><i class="bi bi-pencil me-2"></i>Modifier</a></li>
                                                                    <li><a class="dropdown-item" href="/candidature/annonce/<%= annonce.getId() %>"><i class="bi bi-eye me-2"></i>Voir les candidatures</a></li>
                                                                    <hr class="dropdown-divider">
                                                                    <li><a class="dropdown-item" href="#" onclick="closeJobOffer(<%= annonce.getId() %>)"><i class="bi bi-x-circle me-2"></i>Fermer l'annonce</a></li>
                                                                <% } else { %>
                                                                    <li><a class="dropdown-item" href="/candidature/annonce/<%= annonce.getId() %>"><i class="bi bi-eye me-2"></i>Voir les candidatures</a></li>
                                                                <% } %>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                            <% } %>
                                            </tbody>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Job Offer Modal -->
    <div class="modal fade" id="jobOfferModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-briefcase me-2"></i>
                        <span id="modalTitle">Nouvelle annonce d'emploi</span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form class="needs-validation" id="annonceForm" method="post" action="${pageContext.request.contextPath}/annonces/create">
                        <div class="row">
                            <div class="col-md-8">
                                <input type="hidden" id="annonceId" name="id">
                                <!-- Basic Information -->
                                <div class="card border-0 bg-light mb-4">
                                    <div class="card-header bg-primary text-white">
                                        <h6 class="mb-0">Informations générales</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <!-- Titre du poste avec autocomplete -->
                                            <div class="col-md-6 position-relative">
                                                <label for="jobTitle" class="form-label">Titre du poste *</label>
                                                <input type="text" class="form-control" id="jobTitle" autocomplete="off" name='poste' required placeholder="Ex: Développeur Java">
                                                <div id="jobTitleList" class="autocomplete-list position-absolute w-100"></div>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="jobDepartment" class="form-label">Département *</label>
                                                <select class="form-select" id="jobDepartment" name="departement" required>
                                                    <option value="">Sélectionner un département</option>
                                                    <% for(Departement dep : departements) { %>
                                                        <option value="<%= dep.getId() %>"><%= dep.getNom() %></option>
                                                    <% } %>
                                                </select>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="age" class="form-label">Âge minimum</label>
                                                <input type="number" class="form-control" name="age" id="age">
                                                <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                    <input class="form-check-input" type="checkbox" id="ageRequired" name="ageObligatoire">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="experience" class="form-label">Expérience requise</label>
                                                <input type="number" class="form-control" name="anneeExperience" id="experience">
                                                <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                    <input class="form-check-input" type="checkbox" id="experienceRequired" name="experienceObligatoire">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="location" class="form-label">Localisation</label>
                                                <select class="form-select" id="location" name="ville">
                                                    <option value="">Sélectionner une ville</option>
                                                    <% for(Ville ville : villes) { %>
                                                        <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
                                                    <% } %>
                                                </select>

                                                <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                    <input class="form-check-input" type="checkbox" id="locationRequired" name="villeObligatoire">
                                                </div>
                                            </div>

                                            <!-- Genre -->
                                            <div class="col-md-6">
                                                <label for="gender" class="form-label">Genre</label>
                                                <select class="form-select" id="gender" name="genre">
                                                    <option value="">Sélectionner</option>
                                                    <option value="homme">Homme</option>
                                                    <option value="femme">Femme</option>
                                                    <option value="autre">Autre</option>
                                                </select>
                                                <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                    <input class="form-check-input" type="checkbox" id="genderRequired" name="genreObligatoire">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="diplome" class="form-label">Diplôme minimum</label>
                                                <select class="form-select" id="diplome" name="diplome">
                                                    <option value="">Sélectionner un diplôme</option>
                                                    <% for(Diplome d : diplomes) { %>
                                                        <option value="<%= d.getId() %>"><%= d.getLibelle() %></option>
                                                    <% } %>
                                                </select>
                                                <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                    <input class="form-check-input" type="checkbox" id="diplomeRequired" name="diplomeObligatoire">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="filiere" class="form-label">Filières *</label>
                                                <select name="filiere" id="filiere" class="form-select" required>
                                                    <option value="">Sélectionner une filière</option>
                                                    <% for(Filiere f : filieres) { %>
                                                            <option value="<%= f.getId() %>"><%= f.getLibelle() %></option>
                                                        <% } %>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Job Description -->
                                <div class="card border-0 bg-light mb-4">
                                    <div class="card-header bg-success text-white">
                                        <h6 class="mb-0">Description du poste</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label for="jobDescription" class="form-label">Description *</label>
                                            <textarea class="form-control" name="description" id="jobDescription" rows="6" required placeholder="Décrivez le poste, les responsabilités principales..."></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <!-- Publication Settings -->
                                <div class="card border-0 bg-light mb-4">
                                    <div class="card-header bg-info text-white">
                                        <h6 class="mb-0">Paramètres de publication</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label for="endDate" class="form-label">Date limite *</label>
                                            <input type="date" class="form-control" id="endDate" name="dateLimite" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="tests" class="form-label">Tests techniques *</label>
                                            <select class="form-select mb-2" id="tests" onchange="addTag('technicalSkills')" name ="test">
                                                <option value="">-- Choisir un test --</option>
                                                <% for(Test t : tests) { %>
                                                    <option value="<%= t.getId() %>"><%= t.getTitre() %> (Durée: <%= t.getTemps() %>)</option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="form-check mb-3">
                                            <input class="form-check-input" type="checkbox" id="urgentJob" name="urgent">
                                            <label class="form-check-label" for="urgentJob">
                                                Recrutement urgent
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Skills -->
                                <div class="card border-0 bg-light mb-4">
                                    <div class="card-header bg-warning text-white">
                                        <h6 class="mb-0">Compétences requises</h6>
                                    </div>
                                    <div class="card-body">
                                        <!-- Compétences techniques -->
                                        <div class="mb-3">
                                            <label for="technicalSkills" class="form-label">Compétences techniques</label>
                                            <select class="form-select mb-2" id="technicalSkills" onchange="addTag('technicalSkills')">
                                                <option value="">-- Choisir une compétence --</option>
                                                <% for(Competence c : competences) { %>
                                                    <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                                                <% } %>
                                            </select>
                                            <div id="technicalSkillsContainer" class="d-flex flex-column gap-2" style="scrollbar-width: thin; max-height: 105px; width: 100%; overflow-y: auto"></div>
                                        </div>

                                        <!-- Langues -->
                                        <div class="mb-3">
                                            <label for="languages" class="form-label">Langues</label>
                                            <select class="form-select mb-2" id="languages" onchange="addTag('languages')">
                                                <option value="">Sélectionner une langue</option>
                                                <% for(Langue l : langues) { %>
                                                    <option value="<%= l.getId() %>"><%= l.getLibelle() %></option>
                                                <% } %>
                                            </select>
                                            <div id="languagesContainer" class="d-flex flex-column gap-2" style="scrollbar-width: thin; max-height: 105px; width: 100%; overflow-y: auto"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                        <button type="submit" class="btn btn-primary">Publier l'annonce</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div aria-live="polite" aria-atomic="true" class="position-relative">
        <div class="toast-container position-fixed top-0 end-0 p-3">
            <% if(request.getAttribute("success") != null) { %>
                <div class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <%= request.getAttribute("success") %>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            <% } %>
            <% if(request.getAttribute("error") != null) { %>
                <div class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <%= request.getAttribute("error") %>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            <% } %>
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
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/manage-job.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tag-job.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>

</html>

