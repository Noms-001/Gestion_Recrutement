<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Offres d'emploi</title>
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
                                <li><a class="dropdown-item" href="#">Salaire</a></li>
                                <li><a class="dropdown-item" href="#">Pertinence</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- Search Bar -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <input type="text" class="form-control form-control-lg" placeholder="Rechercher un poste, une entreprise...">
                            </div>
                            <div class="col-md-4">
                                <input type="text" class="form-control form-control-lg" placeholder="Ville, région...">
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary btn-lg w-100">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Jobs List -->
                <div id="jobsList">
                    <!-- Job Card 1 -->
                    <div class="card mb-3 job-card" data-job-id="1">
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
                                            <h5 class="card-title mb-1">Développeur Frontend React</h5>
                                            <p class="text-muted mb-2">TechCorp Solutions • Paris, France</p>
                                            <p class="card-text mb-3">Rejoignez notre équipe pour développer des interfaces utilisateur modernes et intuitives avec React et TypeScript...</p>
                                            <div class="d-flex flex-wrap gap-2">
                                                <span class="badge bg-primary">React</span>
                                                <span class="badge bg-primary">TypeScript</span>
                                                <span class="badge bg-primary">CSS</span>
                                                <span class="badge bg-secondary">CDI</span>
                                                <span class="badge bg-success">45-55k €</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 text-end">
                                    <small class="text-muted">Publié il y a 2 jours</small>
                                    <div class="mt-3">
                                        <button class="btn btn-outline-primary btn-sm me-2" onclick="toggleJobDetails(1)">
                                            <i class="bi bi-eye me-1"></i>Voir détails
                                        </button>
                                        <button class="btn btn-primary btn-sm">
                                            <i class="bi bi-send me-1"></i>Postuler
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Job Details (Hidden by default) -->
                            <div class="job-details mt-4 d-none" id="details-1">
                                <hr>
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Critères requis</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Âge minimum: 23 ans</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Diplôme: Bac+3 en Informatique</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Expérience: 2-4 ans</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Langues: Français, Anglais</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Compétences techniques</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="bi bi-dot text-primary"></i>React.js avancé</li>
                                            <li><i class="bi bi-dot text-primary"></i>TypeScript</li>
                                            <li><i class="bi bi-dot text-primary"></i>CSS/SCSS</li>
                                            <li><i class="bi bi-dot text-primary"></i>Git</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Job Card 2 -->
                    <div class="card mb-3 job-card" data-job-id="2">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="d-flex align-items-start">
                                        <div class="company-logo me-3">
                                            <div class="bg-success text-white rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                                <i class="bi bi-briefcase"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h5 class="card-title mb-1">Chef de Projet Digital</h5>
                                            <p class="text-muted mb-2">DigitalAgency • Lyon, France</p>
                                            <p class="card-text mb-3">Nous recherchons un chef de projet expérimenté pour piloter nos projets digitaux et coordonner les équipes...</p>
                                            <div class="d-flex flex-wrap gap-2">
                                                <span class="badge bg-primary">Gestion de projet</span>
                                                <span class="badge bg-primary">Agile</span>
                                                <span class="badge bg-primary">Digital</span>
                                                <span class="badge bg-secondary">CDI</span>
                                                <span class="badge bg-success">50-60k €</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 text-end">
                                    <small class="text-muted">Publié il y a 3 jours</small>
                                    <div class="mt-3">
                                        <button class="btn btn-outline-primary btn-sm me-2" onclick="toggleJobDetails(2)">
                                            <i class="bi bi-eye me-1"></i>Voir détails
                                        </button>
                                        <button class="btn btn-primary btn-sm">
                                            <i class="bi bi-send me-1"></i>Postuler
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Job Details -->
                            <div class="job-details mt-4 d-none" id="details-2">
                                <hr>
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Critères requis</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Âge minimum: 25 ans</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Diplôme: Bac+5 en Management</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Expérience: 5+ ans</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Langues: Français, Anglais</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Compétences techniques</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="bi bi-dot text-primary"></i>Méthodologie Agile</li>
                                            <li><i class="bi bi-dot text-primary"></i>Outils de gestion de projet</li>
                                            <li><i class="bi bi-dot text-primary"></i>Leadership</li>
                                            <li><i class="bi bi-dot text-primary"></i>Communication</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Job Card 3 -->
                    <div class="card mb-3 job-card" data-job-id="3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="d-flex align-items-start">
                                        <div class="company-logo me-3">
                                            <div class="bg-warning text-dark rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                                <i class="bi bi-palette"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h5 class="card-title mb-1">Designer UX/UI Senior</h5>
                                            <p class="text-muted mb-2">CreativeStudio • Bordeaux, France</p>
                                            <p class="card-text mb-3">Créez des expériences utilisateur exceptionnelles pour nos clients dans un environnement créatif et innovant...</p>
                                            <div class="d-flex flex-wrap gap-2">
                                                <span class="badge bg-primary">Figma</span>
                                                <span class="badge bg-primary">Adobe Suite</span>
                                                <span class="badge bg-primary">UI/UX</span>
                                                <span class="badge bg-secondary">CDI</span>
                                                <span class="badge bg-success">40-50k €</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 text-end">
                                    <small class="text-muted">Publié il y a 1 semaine</small>
                                    <div class="mt-3">
                                        <button class="btn btn-outline-primary btn-sm me-2" onclick="toggleJobDetails(3)">
                                            <i class="bi bi-eye me-1"></i>Voir détails
                                        </button>
                                        <button class="btn btn-primary btn-sm">
                                            <i class="bi bi-send me-1"></i>Postuler
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Job Details -->
                            <div class="job-details mt-4 d-none" id="details-3">
                                <hr>
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Critères requis</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Âge minimum: 24 ans</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Diplôme: Bac+3 en Design</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Expérience: 3-5 ans</li>
                                            <li><i class="bi bi-check-circle text-success me-2"></i>Langues: Français</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Compétences techniques</h6>
                                        <ul class="list-unstyled">
                                            <li><i class="bi bi-dot text-primary"></i>Design thinking</li>
                                            <li><i class="bi bi-dot text-primary"></i>Prototypage</li>
                                            <li><i class="bi bi-dot text-primary"></i>Tests utilisateur</li>
                                            <li><i class="bi bi-dot text-primary"></i>Design system</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
        </main>
    </div>
    
    <!-- Filters Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="filtersOffcanvas">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">Filtres de recherche</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <form>
                <div class="mb-4">
                    <label for="cityFilter" class="form-label fw-semibold">Ville</label>
                    <select class="form-select" id="cityFilter" multiple>
                        <option value="paris">Paris</option>
                        <option value="lyon">Lyon</option>
                        <option value="marseille">Marseille</option>
                        <option value="toulouse">Toulouse</option>
                        <option value="bordeaux">Bordeaux</option>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label for="diplomeFilter" class="form-label fw-semibold">Diplôme minimum</label>
                    <select class="form-select" id="diplomeFilter">
                        <option value="">Tous les diplômes</option>
                        <option value="bac">Baccalauréat</option>
                        <option value="bac+2">Bac+2</option>
                        <option value="bac+3">Bac+3</option>
                        <option value="bac+5">Bac+5</option>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label for="experienceFilter" class="form-label fw-semibold">Années d'expérience</label>
                    <input type="range" class="form-range" min="0" max="10" value="2" id="experienceFilter">
                    <div class="d-flex justify-content-between">
                        <span>0 an</span>
                        <span>10+ ans</span>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-semibold">Compétences</label>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="react" id="skillReact">
                        <label class="form-check-label" for="skillReact">React</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="js" id="skillJS">
                        <label class="form-check-label" for="skillJS">JavaScript</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="python" id="skillPython">
                        <label class="form-check-label" for="skillPython">Python</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="design" id="skillDesign">
                        <label class="form-check-label" for="skillDesign">Design</label>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-semibold">Langues</label>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="francais" id="langFR">
                        <label class="form-check-label" for="langFR">Français</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="anglais" id="langEN">
                        <label class="form-check-label" for="langEN">Anglais</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="espagnol" id="langES">
                        <label class="form-check-label" for="langES">Espagnol</label>
                    </div>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Appliquer les filtres</button>
                    <button type="reset" class="btn btn-outline-secondary">Réinitialiser</button>
                </div>
            </form>
        </div>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/app.js"></script>
    <script>
        loadNavbar();
        loadSidebar();
        
        function toggleJobDetails(jobId) {
            const details = document.getElementById(`details-${jobId}`);
            details.classList.toggle('d-none');
        }

        
        document.addEventListener("DOMContentLoaded", () => {
            const jobsList = document.querySelectorAll(".job-card");
            const pagination = document.querySelector(".pagination");
            const itemsPerPage = 5; // jobs par page
            let currentPage = 1;
            const totalPages = Math.ceil(jobsList.length / itemsPerPage);

            // Générer dynamiquement les numéros de page
            function generatePagination() {
                pagination.innerHTML = '';

                // Précédent
                const prevLi = document.createElement('li');
                prevLi.className = 'page-item disabled';
                prevLi.innerHTML = `<a class="page-link" href="#" tabindex="-1">Précédent</a>`;
                pagination.appendChild(prevLi);

                // Numéros de pages
                for (let i = 1; i <= totalPages; i++) {
                    const li = document.createElement('li');
                    li.className = 'page-item';
                    li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
                    li.querySelector('a').addEventListener('click', (e) => {
                        e.preventDefault();
                        showPage(i);
                    });
                    pagination.appendChild(li);
                }

                // Suivant
                const nextLi = document.createElement('li');
                nextLi.className = 'page-item';
                nextLi.innerHTML = `<a class="page-link" href="#">Suivant</a>`;
                pagination.appendChild(nextLi);

                // Clic Précédent
                prevLi.querySelector('a').addEventListener('click', (e) => {
                    e.preventDefault();
                    if (currentPage > 1) showPage(currentPage - 1);
                });

                // Clic Suivant
                nextLi.querySelector('a').addEventListener('click', (e) => {
                    e.preventDefault();
                    if (currentPage < totalPages) showPage(currentPage + 1);
                });
            }

            // Afficher les jobs d'une page
            function showPage(page) {
                currentPage = page;
                const start = (page - 1) * itemsPerPage;
                const end = start + itemsPerPage;

                jobsList.forEach((job, index) => {
                    job.style.display = (index >= start && index < end) ? "block" : "none";
                });

                // Mettre à jour les classes actives et boutons
                updatePagination();
            }

            function updatePagination() {
                const pageItems = pagination.querySelectorAll('.page-item');
                pageItems.forEach((li, idx) => {
                    if (idx === 0) li.classList.toggle('disabled', currentPage === 1); // Précédent
                    else if (idx === pageItems.length - 1) li.classList.toggle('disabled', currentPage === totalPages); // Suivant
                    else li.classList.toggle('active', idx === currentPage); // numéros
                });
            }

            generatePagination();
            showPage(1);
        });

    </script>
</body>
</html>