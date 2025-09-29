<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Tableau de bord</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/logo.png">
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
                                        <select class="form-select">
                                            <option value="">Tous les statuts</option>
                                            <option value="active">Active</option>
                                            <option value="expired">Expirée</option>
                                            <option value="closed">Fermée</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option value="">Tous les Departements</option>
                                            <option value="dev">Développement</option>
                                            <option value="design">Design</option>
                                            <option value="marketing">Marketing</option>
                                            <option value="commercial">Commercial</option>
                                            <option value="rh">RH</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option value="">Type de contrat</option>
                                            <option value="cdi">CDI</option>
                                            <option value="cdd">CDD</option>
                                            <option value="stage">Stage</option>
                                            <option value="freelance">Freelance</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-primary w-100">
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
                                            <tr>
                                                <td>
                                                    <div class="fw-medium">Développeur Frontend React</div>
                                                    <small class="text-muted">35-45K€ • Paris</small>
                                                </td>
                                                <td>
                                                    <span class="badge bg-primary">Développement</span>
                                                </td>
                                                <td>CDI</td>
                                                <td>
                                                    <span class="badge bg-success">Active</span>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">23</div>
                                                    <small class="text-muted">candidatures</small>
                                                </td>
                                                <td>15/12/2024</td>
                                                <td>15/02/2025</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                            type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item" href="#"
                                                                    onclick="editJobOffer(1)"><i
                                                                        class="bi bi-pencil me-2"></i>Modifier</a></li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-eye me-2"></i>Voir les
                                                                    candidatures</a></li>
                                                            <hr class="dropdown-divider">
                                                            </li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-x-circle me-2"></i>Fermée
                                                                    l'annonce</a>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="bi bi-trash me-2"></i>Supprimer</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="fw-medium">Designer UX/UI</div>
                                                    <small class="text-muted">32-42K€ • Paris</small>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info">Design</span>
                                                </td>
                                                <td>CDI</td>
                                                <td>
                                                    <span class="badge bg-success">Active</span>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">18</div>
                                                    <small class="text-muted">candidatures</small>
                                                </td>
                                                <td>10/12/2024</td>
                                                <td>10/02/2025</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                            type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item" href="#"
                                                                    onclick="editJobOffer(2)"><i
                                                                        class="bi bi-pencil me-2"></i>Modifier</a></li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-eye me-2"></i>Voir les
                                                                    candidatures</a></li>
                                                            <hr class="dropdown-divider">
                                                            </li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-x-circle me-2"></i>Fermée
                                                                    l'annonce</a>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="bi bi-trash me-2"></i>Supprimer</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="fw-medium">Développeur Backend Python</div>
                                                    <small class="text-muted">40-50K€ • Télétravail</small>
                                                </td>
                                                <td>
                                                    <span class="badge bg-primary">Développement</span>
                                                </td>
                                                <td>CDI</td>
                                                <td>
                                                    <span class="badge bg-danger">Expirée</span>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">12</div>
                                                    <small class="text-muted">candidatures</small>
                                                </td>
                                                <td>20/11/2024</td>
                                                <td>20/01/2025</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                            type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item" href="#"
                                                                    onclick="editJobOffer(4)">
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-eye me-2"></i>Voir les
                                                                    candidatures</a></li>
                                                            <li>
                                                                <hr class="dropdown-divider">
                                                            </li>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="bi bi-trash me-2"></i>Supprimer</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="fw-medium">Commercial B2B</div>
                                                    <small class="text-muted">35-45K€ + commissions • Marseille</small>
                                                </td>
                                                <td>
                                                    <span class="badge bg-success">Commercial</span>
                                                </td>
                                                <td>CDI</td>
                                                <td>
                                                    <span class="badge bg-success">Active</span>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">27</div>
                                                    <small class="text-muted">candidatures</small>
                                                </td>
                                                <td>01/12/2024</td>
                                                <td>01/03/2025</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                            type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item" href="#"
                                                                    onclick="editJobOffer(5)"><i
                                                                        class="bi bi-pencil me-2"></i>Modifier</a></li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-eye me-2"></i>Voir les
                                                                    candidatures</a></li>
                                                            <hr class="dropdown-divider">
                                                            </li>
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-x-circle me-2"></i>Fermée
                                                                    l'annonce</a>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="bi bi-trash me-2"></i>Supprimer</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div class="fw-medium">Data Analyst</div>
                                                    <small class="text-muted">38-48K€ • Paris</small>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary">Data</span>
                                                </td>
                                                <td>CDI</td>
                                                <td>
                                                    <span class="badge bg-dark">Fermée</span>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">45</div>
                                                    <small class="text-muted">candidatures</small>
                                                </td>
                                                <td>15/11/2024</td>
                                                <td>15/01/2025</td>
                                                <td>
                                                    <div class="dropdown">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                            type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu">
                                                            <li><a class="dropdown-item" href="#"><i
                                                                        class="bi bi-eye me-2"></i>Voir les
                                                                    candidatures</a></li>
                                                            <hr class="dropdown-divider">
                                                            </li>
                                                            <li><a class="dropdown-item text-danger" href="#"><i
                                                                        class="bi bi-trash me-2"></i>Supprimer</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
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
                                            <div class="col-md-6">
                                                <label for="jobTitle" class="form-label">Titre du poste *</label>
                                                <input type="text" class="form-control" id="jobTitle" required>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="jobDepartment" class="form-label">Departement *</label>
                                                <select class="form-select" id="jobDepartment" required>
                                                    <option value="">Sélectionner un departement</option>
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
                                            </div>
                                            <div class="col-md-6">
                                                <label for="experience" class="form-label">Expérience requise</label>
                                                <input type="number" class="form-control" name="experience"
                                                    id="experience">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="location" class="form-label">Localisation *</label>
                                                <input type="text" class="form-control" id="location" required
                                                    placeholder="Ex: Paris, Lyon, Télétravail">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="salary" class="form-label">Fourchette salariale</label>
                                                <input type="text" class="form-control" id="salary"
                                                    placeholder="Ex: 35-45K€">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="diplome" class="form-label">Diplôme minimum</label>
                                                <input type="number" class="form-control" id="diplome" name="diplome">
                                            </div>
                                            <div class="col-md-6">
                                                <label for="filiere" class="form-label">Filières</label>
                                                <select name="filiere" id="filiere" class="form-control">
                                                    <option value="">Selectionner une filière</option>
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
                                            <textarea class="form-control" id="jobDescription" rows="6" required
                                                placeholder="Décrivez le poste, les responsabilités principales..."></textarea>
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
                                        <div class="mb-3">
                                            <label for="technicalSkills" class="form-label">Compétences
                                                techniques</label>
                                        </div>
                                        <select class="form-select mb-2" id="technicalSkills"
                                            onchange="addTag('technicalSkills')">
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
                                        <div id="technicalSkillsContainer" class="d-flex flex-wrap gap-1">
                                        </div>

                                        <div class="mb-3">
                                            <label for="languages" class="form-label">Langues</label>
                                            <select class="form-select mb-2" id="languages"
                                                onchange="addTag('languages')">
                                                <option value="">-- Choisir une langue --</option>
                                                <option value="francais">Français</option>
                                                <option value="anglais">Anglais</option>
                                                <option value="espagnol">Espagnol</option>
                                                <option value="allemand">Allemand</option>
                                                <option value="italien">Italien</option>
                                            </select>
                                            <div id="languagesContainer" class="d-flex flex-wrap gap-1 mb-2"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="button" class="btn btn-outline-primary">Sauvegarder brouillon</button>
                    <button type="button" class="btn btn-primary">Publier l'annonce</button>
                </div>
            </div>
        </div>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/app.js"></script>
    <script>
        loadNavbar();
        loadSidebar();


        function addTag(type) {
            const select = document.getElementById(type);
            const container = document.getElementById(type + 'Container');
            const value = select.value;
            const text = select.options[select.selectedIndex]?.text;

            if (!value) return;

            // éviter doublons
            if (container.querySelector(`[data-value="${value}"]`)) return;

            const tag = document.createElement('span');
            tag.className = "badge bg-light text-dark border d-flex align-items-center";
            tag.dataset.value = value;
            tag.innerHTML = text + ` <i class="bi bi-x ms-2" style="cursor:pointer;" onclick="this.parentElement.remove()"></i>`;

            container.appendChild(tag);

            // réinitialiser le select
            select.value = '';
        }
    </script>
</body>

</html>