    <%@ page session="true" %>
    <%@ page import="java.util.*, java.time.*" %>
    <%@ page import="com.example.entreprise.entity.*" %>
    <%
        List<Annonce> annonces = (List<Annonce>) request.getAttribute("annonces");
        List<Ville> villes = (List<Ville>) request.getAttribute("villes");
        List<Departement> departements = (List<Departement>) request.getAttribute("departements");

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
                                                <input type="text" class="form-control"
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
                                            <select class="form-select" id="filterVille" name="ville">
                                                <option value="">Ville</option>
                                                <% for(Ville ville : villes) { %>
                                                    <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
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
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead class="bg-light">
                                                <tr>
                                                    <th>Poste</th>
                                                    <th>Departement</th>
                                                    <th>Type</th>
                                                    <th>Statut</th>
                                                    <th>Candidatures</th>
                                                    <th>Date de création</th>
                                                    <th>Date d'expiration</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% int rowIndex = 0;
                                                for(Annonce annonce : annonces) { 
                                                    String badgeColor = "";
                                                    switch (rowIndex % 3) { // 5 couleurs différentes
                                                        case 0: badgeColor = "bg-primary"; break;
                                                        case 1: badgeColor = "bg-info"; break;
                                                        case 2: badgeColor = "bg-secondary"; break;
                                                    } rowIndex ++;%>
                                                    <tr>
                                                        <td>
                                                            <div class="fw-medium"><%= annonce.getPoste().getLibelle() %></div>
                                                            <small class="text-muted"><%= annonce.getAnneeExperience() != null ? annonce.getAnneeExperience() + " ans" : "" %> • <%= annonce.getVille() != null ? annonce.getVille().getNom() : "" %></small>
                                                        </td>
                                                        <td>
                                                            <span class="badge <%= badgeColor %>"><%= annonce.getPoste().getDepartement().getNom() %></span>
                                                        </td>
                                                        <td>CDI</td> <!-- ou autre type selon ton modèle -->
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
                                                                    <li><a class="dropdown-item" href="#" onclick="editJobOffer(<%= annonce.getId() %>)"><i class="bi bi-pencil me-2"></i>Modifier</a></li>
                                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-eye me-2"></i>Voir les candidatures</a></li>
                                                                    <hr class="dropdown-divider">
                                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-x-circle me-2"></i>Fermer l'annonce</a></li>
                                                                    <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash me-2"></i>Supprimer</a></li>
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
                        <form class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-8">
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
                                                    <input type="text" class="form-control" id="jobTitle" autocomplete="off" required placeholder="Ex: Développeur Java">
                                                    <div id="jobTitleList" class="autocomplete-list position-absolute w-100"></div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="jobDepartment" class="form-label">Département *</label>
                                                    <select class="form-select" id="jobDepartment" required>
                                                        <option value="">Sélectionner un département</option>
                                                        <option value="dev">Développement</option>
                                                        <option value="design">Design</option>
                                                        <option value="marketing">Marketing</option>
                                                        <option value="commercial">Commercial</option>
                                                        <option value="rh">Ressources Humaines</option>
                                                        <option value="finance">Finance</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="age" class="form-label">Âge minimum</label>
                                                    <input type="number" class="form-control" name="age" id="age">
                                                    <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                        <input class="form-check-input" type="checkbox" id="ageRequired">
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="experience" class="form-label">Expérience requise</label>
                                                    <input type="number" class="form-control" name="experience" id="experience">
                                                    <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                        <input class="form-check-input" type="checkbox" id="experienceRequired">
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="location" class="form-label">Localisation *</label>
                                                    <input type="text" class="form-control" id="location" required placeholder="Ex: Paris, Lyon, Télétravail">
                                                    <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                        <input class="form-check-input" type="checkbox" id="locationRequired">
                                                    </div>
                                                </div>

                                                <!-- Genre -->
                                                <div class="col-md-6">
                                                    <label for="gender" class="form-label">Genre</label>
                                                    <select class="form-select" id="gender" name="gender">
                                                        <option value="">Sélectionner</option>
                                                        <option value="homme">Homme</option>
                                                        <option value="femme">Femme</option>
                                                        <option value="autre">Autre</option>
                                                    </select>
                                                    <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                        <input class="form-check-input" type="checkbox" id="genderRequired">
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="diplome" class="form-label">Diplôme minimum</label>
                                                    <input type="number" class="form-control" id="diplome" name="diplome">
                                                    <div class="form-check form-switch mt-1 toggle-required" data-info="Spécifie si c'est obligatoire">
                                                        <input class="form-check-input" type="checkbox" id="diplomeRequired">
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="filiere" class="form-label">Filières</label>
                                                    <select name="filiere" id="filiere" class="form-control">
                                                        <option value="">Sélectionner une filière</option>
                                                        <option value="Informatique">Informatique</option>
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
                                                <textarea class="form-control" id="jobDescription" rows="6" required placeholder="Décrivez le poste, les responsabilités principales..."></textarea>
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
                                                <label for="endDate" class="form-label">Date limite</label>
                                                <input type="date" class="form-control" id="endDate">
                                            </div>
                                            <div class="form-check mb-3">
                                                <input class="form-check-input" type="checkbox" id="urgentJob">
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
                                                <div id="technicalSkillsContainer" class="d-flex flex-column gap-2" style="scrollbar-width: thin; max-height: 160px; width: 100%; overflow-y: auto"></div>
                                            </div>

                                            <!-- Langues -->
                                            <div class="mb-3">
                                                <label for="languages" class="form-label">Langues</label>
                                                <select class="form-select mb-2" id="languages" onchange="addTag('languages')">
                                                    <option value="">-- Choisir une langue --</option>
                                                    <option value="francais">Français</option>
                                                    <option value="anglais">Anglais</option>
                                                    <option value="espagnol">Espagnol</option>
                                                    <option value="allemand">Allemand</option>
                                                    <option value="italien">Italien</option>
                                                </select>
                                                <div id="languagesContainer" class="d-flex flex-column gap-2" style="scrollbar-width: thin; max-height: 160px; width: 100%; overflow-y: auto"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                        <button type="button" class="btn btn-primary">Publier l'annonce</button>
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

            document.getElementById('btnFilter').addEventListener('click', function() {
                const villeId = document.getElementById('filterVille').value;
                const departementId = document.getElementById('filterDepartement').value;
                const poste = document.getElementById('filterPoste').value;
                const status = document.getElementById('filterStatus').value;

                // Construire l'URL avec query params
                const params = new URLSearchParams();
                if(villeId) params.append('villeId', villeId);
                if(departementId) params.append('departementId', departementId);
                if(poste) params.append('poste', poste);
                if(status) params.append('status', status);

                fetch(`${window.location.origin}/api/annonces?${params.toString()}`)
                    .then(response => response.json())
                    .then(data => {
                        // data est la liste des annonces
                        updateAnnonceTable(data);
                    })
                    .catch(error => console.error('Erreur fetch annonces:', error));
            });
            function updateAnnonceTable(annonces) {
                const tbody = document.getElementById('annonceTableBody');
                tbody.innerHTML = ''; // vider l'ancien contenu

                let rowIndex = 0;
                annonces.forEach(annonce => {
                    let badgeColor = '';
                    switch(rowIndex % 3) {
                        case 0: badgeColor = 'bg-primary'; break;
                        case 1: badgeColor = 'bg-info'; break;
                        case 2: badgeColor = 'bg-secondary'; break;
                    }
                    rowIndex++;

                    let statusBadge = '';
                    if(annonce.ferme) {
                        statusBadge = '<span class="badge bg-dark">Fermée</span>';
                    } else if(annonce.dateLimite && new Date(annonce.dateLimite) < new Date()) {
                        statusBadge = '<span class="badge bg-danger">Expirée</span>';
                    } else {
                        statusBadge = '<span class="badge bg-success">Active</span>';
                    }

                    tbody.innerHTML += `
                        <tr>
                            <td>
                                <div class="fw-medium">${annonce.poste.libelle}</div>
                                <small class="text-muted">${annonce.anneeExperience ? annonce.anneeExperience + ' ans' : ''} • ${annonce.ville ? annonce.ville.nom : ''}</small>
                            </td>
                            <td><span class="badge ${badgeColor}">${annonce.poste.departement.nom}</span></td>
                            <td>CDI</td>
                            <td>${statusBadge}</td>
                            <td><div class="fw-bold">${annonce.candidatures ? annonce.candidatures.length : 0}</div><small class="text-muted">candidatures</small></td>
                            <td>${annonce.dateCreation || ''}</td>
                            <td>${annonce.dateLimite || ''}</td>
                            <td>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        Actions
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#" onclick="editJobOffer(${annonce.id})"><i class="bi bi-pencil me-2"></i>Modifier</a></li>
                                        <li><a class="dropdown-item" href="#"><i class="bi bi-eye me-2"></i>Voir les candidatures</a></li>
                                        <hr class="dropdown-divider">
                                        <li><a class="dropdown-item" href="#"><i class="bi bi-x-circle me-2"></i>Fermer l'annonce</a></li>
                                        <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash me-2"></i>Supprimer</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    `;
                });
            }


        </script>
        <script src="${pageContext.request.contextPath}/resources/js/manage-job.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/tag-job.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    </body>

    </html>

