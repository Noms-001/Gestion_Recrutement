<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Tableau de bord</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/logo.png">
</head>

<body>
    <div id="navbar-placeholder"></div>

    <div class="d-flex">
        <div id="sidebar-placeholder"></div>

        <main class="main-content flex-grow-1">
            <div class="container-fluid px-4 py-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 fw-bold">Tableau de bord</h1>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4 mb-5">
                    <div class="col-xl-3 col-md-6">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title opacity-75">Candidats actifs</h6>
                                        <h2 class="mb-0">1,247</h2>
                                    </div>
                                    <i class="bi bi-people-fill" style="font-size: 2.5rem; opacity: 0.3;"></i>
                                </div>
                                <div class="mt-2">
                                    <small class="opacity-75">+12% ce mois</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title opacity-75">Postes ouverts</h6>
                                        <h2 class="mb-0">23</h2>
                                    </div>
                                    <i class="bi bi-briefcase-fill" style="font-size: 2.5rem; opacity: 0.3;"></i>
                                </div>
                                <div class="mt-2">
                                    <small class="opacity-75">5 nouveaux</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title opacity-75">Entretiens prévus</h6>
                                        <h2 class="mb-0">18</h2>
                                    </div>
                                    <i class="bi bi-calendar-event" style="font-size: 2.5rem; opacity: 0.3;"></i>
                                </div>
                                <div class="mt-2">
                                    <small class="opacity-75">Cette semaine</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title opacity-75">Période d'essai</h6>
                                        <h2 class="mb-0">7</h2>
                                    </div>
                                    <i class="bi bi-hourglass-split" style="font-size: 2.5rem; opacity: 0.3;"></i>
                                </div>
                                <div class="mt-2">
                                    <small class="opacity-75">En cours</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row g-4 mb-5">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Actions rapides</h5>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <a href="candidates.html" class="card h-100 text-decoration-none hover-card">
                                            <div class="card-body text-center">
                                                <i class="bi bi-file-person text-primary mb-2"
                                                    style="font-size: 2rem;"></i>
                                                <h6 class="card-title">Voir les candidats</h6>
                                                <p class="card-text text-muted small">Lire le registre des candidats</p>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-4">
                                        <a href="job-listings.html" class="card h-100 text-decoration-none hover-card">
                                            <div class="card-body text-center">
                                                <i class="bi bi-search text-success mb-2" style="font-size: 2rem;"></i>
                                                <h6 class="card-title">Rechercher un emploi</h6>
                                                <p class="card-text text-muted small">Parcourir les offres</p>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-md-4">
                                        <a href="manage-jobs.html" class="card h-100 text-decoration-none hover-card">
                                            <div class="card-body text-center">
                                                <i class="bi bi-plus-square text-warning mb-2"
                                                    style="font-size: 2rem;"></i>
                                                <h6 class="card-title">Publier une annonce</h6>
                                                <p class="card-text text-muted small">Créer une offre d'emploi</p>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="row g-4">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Activités récentes</h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-primary"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Nouvelle candidature reçue</h6>
                                            <p class="text-muted mb-1">Marie Dubois a postulé pour Développeur Frontend
                                            </p>
                                            <small class="text-muted">Il y a 2 heures</small>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-success"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Entretien planifié</h6>
                                            <p class="text-muted mb-1">Entretien avec Jean Martin programmé pour demain
                                            </p>
                                            <small class="text-muted">Il y a 4 heures</small>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-warning"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Test complété</h6>
                                            <p class="text-muted mb-1">Sophie Bernard a terminé le test technique</p>
                                            <small class="text-muted">Il y a 6 heures</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Prochains entretiens</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm bg-primary text-white rounded-circle me-3">
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Paul Durand</h6>
                                                <small class="text-muted">14:00 - Designer UX</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm bg-success text-white rounded-circle me-3">
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Emma Laurent</h6>
                                                <small class="text-muted">16:30 - Chef de projet</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="list-group-item px-0">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm bg-warning text-white rounded-circle me-3">
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Lucas Martin</h6>
                                                <small class="text-muted">Demain 10:00 - Analyste</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script>
        loadNavbar();
        loadSidebar();
    </script>
</body>

</html>