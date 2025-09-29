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
                <div class="row">
                        
                        <!-- Filters and Search -->
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="bi bi-search"></i>
                                            </span>
                                            <input type="text" class="form-control"
                                                placeholder="Rechercher un employé...">
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option value="">Tous les departements</option>
                                            <option value="dev">Développement</option>
                                            <option value="design">Design</option>
                                            <option value="marketing">Marketing</option>
                                            <option value="rh">RH</option>
                                            <option value="commercial">Commercial</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option value="">Tous les statuts</option>
                                            <option value="en-cours">En cours</option>
                                            <option value="fin-proche">Fin proche</option>
                                            <option value="evaluation">Évaluation</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option value="">Durée essai</option>
                                            <option value="1">1 mois</option>
                                            <option value="2">2 mois</option>
                                            <option value="3">3 mois</option>
                                            <option value="4">4 mois</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-outline-secondary w-100">
                                            <i class="bi bi-funnel me-1"></i>
                                            Filtrer
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Employees Grid -->
                        <div class="row g-4">
                            <!-- Employee 1 -->
                            <div class="col-lg-4 col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-header bg-light border-0">
                                        <div class="d-flex align-items-center">
                                            <img src="https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Marie Dubois" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">Marie Dubois</h6>
                                                <small class="text-muted">Développeur Frontend</small>
                                            </div>
                                            <span class="badge bg-success">En cours</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-primary">15 Nov</div>
                                                    <small class="text-muted">Début</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-warning">15 Jan</div>
                                                    <small class="text-muted">Fin prévue</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progression</small>
                                                <small class="fw-bold">85%</small>
                                            </div>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar bg-success" style="width: 85%"></div>
                                            </div>
                                            <small class="text-muted">3 jours restants</small>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">85/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-info">88/100</div>
                                                    <small class="text-muted">Score entretien</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-primary me-1">React</span>
                                            <span class="badge bg-primary me-1">TypeScript</span>
                                            <span class="badge bg-secondary">CSS</span>
                                        </div>

                                        <div class="text-muted small mb-3">
                                            <div><i class="bi bi-person me-1"></i> Manager: Jean Dupont</div>
                                            <div><i class="bi bi-building me-1"></i> Departement: Développement</div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm" data-bs-toggle="modal"
                                                data-bs-target="#employeeDetailsModal">
                                                <i class="bi bi-eye me-1"></i>
                                                Voir détails
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Employee 2 -->
                            <div class="col-lg-4 col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-header bg-light border-0">
                                        <div class="d-flex align-items-center">
                                            <img src="https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Thomas Leroy" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">Thomas Leroy</h6>
                                                <small class="text-muted">Chef de projet</small>
                                            </div>
                                            <span class="badge bg-warning">Évaluation</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-primary">01 Déc</div>
                                                    <small class="text-muted">Début</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-danger">01 Fév</div>
                                                    <small class="text-muted">Fin prévue</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progression</small>
                                                <small class="fw-bold">50%</small>
                                            </div>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar bg-warning" style="width: 50%"></div>
                                            </div>
                                            <small class="text-muted">17 jours restants</small>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-warning">72/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">90/100</div>
                                                    <small class="text-muted">Score entretien</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-success me-1">Agile</span>
                                            <span class="badge bg-info me-1">Leadership</span>
                                            <span class="badge bg-secondary">Gestion</span>
                                        </div>

                                        <div class="text-muted small mb-3">
                                            <div><i class="bi bi-person me-1"></i> Manager: Claire Martin</div>
                                            <div><i class="bi bi-building me-1"></i> Departement: Management</div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm">
                                                <i class="bi bi-eye me-1"></i>
                                                Voir détails
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Employee 3 -->
                            <div class="col-lg-4 col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-header bg-light border-0">
                                        <div class="d-flex align-items-center">
                                            <img src="https://images.pexels.com/photos/1036627/pexels-photo-1036627.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Sophie Bernard" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">Sophie Bernard</h6>
                                                <small class="text-muted">Designer UX</small>
                                            </div>
                                            <span class="badge bg-success">En cours</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-primary">20 Déc</div>
                                                    <small class="text-muted">Début</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-warning">20 Fév</div>
                                                    <small class="text-muted">Fin prévue</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progression</small>
                                                <small class="fw-bold">25%</small>
                                            </div>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar bg-primary" style="width: 25%"></div>
                                            </div>
                                            <small class="text-muted">36 jours restants</small>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">92/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">95/100</div>
                                                    <small class="text-muted">Score entretien</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-info me-1">Figma</span>
                                            <span class="badge bg-info me-1">UX Research</span>
                                            <span class="badge bg-secondary">Prototype</span>
                                        </div>

                                        <div class="text-muted small mb-3">
                                            <div><i class="bi bi-person me-1"></i> Manager: Paul Durand</div>
                                            <div><i class="bi bi-building me-1"></i> Departement: Design</div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm">
                                                <i class="bi bi-eye me-1"></i>
                                                Voir détails
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Employee 4 -->
                            <div class="col-lg-4 col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-header bg-light border-0">
                                        <div class="d-flex align-items-center">
                                            <img src="https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Pierre Martin" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">Pierre Martin</h6>
                                                <small class="text-muted">Développeur Backend</small>
                                            </div>
                                            <span class="badge bg-danger">Attention</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-primary">05 Jan</div>
                                                    <small class="text-muted">Début</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-danger">05 Mar</div>
                                                    <small class="text-muted">Fin prévue</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progression</small>
                                                <small class="fw-bold">15%</small>
                                            </div>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar bg-danger" style="width: 15%"></div>
                                            </div>
                                            <small class="text-muted">49 jours restants</small>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-danger">58/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-warning">65/100</div>
                                                    <small class="text-muted">Score entretien</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-primary me-1">Python</span>
                                            <span class="badge bg-primary me-1">Django</span>
                                            <span class="badge bg-secondary">API</span>
                                        </div>

                                        <div class="text-muted small mb-3">
                                            <div><i class="bi bi-person me-1"></i> Manager: Jean Dupont</div>
                                            <div><i class="bi bi-building me-1"></i> Departement: Développement</div>
                                        </div>

                                        <div class="alert alert-warning py-2 mb-0">
                                            <small><i class="bi bi-exclamation-triangle me-1"></i> Accompagnement
                                                renforcé recommandé</small>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm">
                                                <i class="bi bi-eye me-1"></i>
                                                Voir détails
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Employee 5 -->
                            <div class="col-lg-4 col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-header bg-light border-0">
                                        <div class="d-flex align-items-center">
                                            <img src="https://images.pexels.com/photos/1181690/pexels-photo-1181690.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Lisa Garcia" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">Lisa Garcia</h6>
                                                <small class="text-muted">Commerciale</small>
                                            </div>
                                            <span class="badge bg-success">En cours</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-primary">10 Jan</div>
                                                    <small class="text-muted">Début</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-warning">10 Mar</div>
                                                    <small class="text-muted">Fin prévue</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progression</small>
                                                <small class="fw-bold">8%</small>
                                            </div>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar bg-primary" style="width: 8%"></div>
                                            </div>
                                            <small class="text-muted">54 jours restants</small>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">88/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">92/100</div>
                                                    <small class="text-muted">Score entretien</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-success me-1">Vente</span>
                                            <span class="badge bg-info me-1">Négociation</span>
                                            <span class="badge bg-secondary">CRM</span>
                                        </div>

                                        <div class="text-muted small mb-3">
                                            <div><i class="bi bi-person me-1"></i> Manager: Anne Dupuis</div>
                                            <div><i class="bi bi-building me-1"></i> Departement: Commercial</div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm">
                                                <i class="bi bi-eye me-1"></i>
                                                Voir détails
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Employee 6 -->
                            <div class="col-lg-4 col-md-6">
                                <div class="card border-0 shadow-sm h-100">
                                    <div class="card-header bg-light border-0">
                                        <div class="d-flex align-items-center">
                                            <img src="https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=60&h=60&fit=crop"
                                                alt="Alex Johnson" class="avatar rounded-circle me-3">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">Alex Johnson</h6>
                                                <small class="text-muted">Data Analyst</small>
                                            </div>
                                            <span class="badge bg-info">Nouveau</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-primary">13 Jan</div>
                                                    <small class="text-muted">Début</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-warning">13 Avr</div>
                                                    <small class="text-muted">Fin prévue</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progression</small>
                                                <small class="fw-bold">2%</small>
                                            </div>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar bg-info" style="width: 2%"></div>
                                            </div>
                                            <small class="text-muted">88 jours restants</small>
                                        </div>

                                        <div class="row g-2 mb-3">
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-success">89/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="text-center">
                                                    <div class="fw-bold text-info">86/100</div>
                                                    <small class="text-muted">Score entretien</small>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <span class="badge bg-warning me-1">Python</span>
                                            <span class="badge bg-warning me-1">SQL</span>
                                            <span class="badge bg-secondary">BI</span>
                                        </div>

                                        <div class="text-muted small mb-3">
                                            <div><i class="bi bi-person me-1"></i> Manager: Marie Leroy</div>
                                            <div><i class="bi bi-building me-1"></i> Departement: Data</div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-sm">
                                                <i class="bi bi-eye me-1"></i>
                                                Voir détails
                                            </button>
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

    <!-- Employee Details Modal -->
    <div class="modal fade" id="employeeDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-person-badge me-2"></i>
                        Détails de l'employé en période d'essai
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <!-- Employee Info -->
                        <div class="col-md-4">
                            <div class="text-center mb-4">
                                <img src="https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=120&h=120&fit=crop"
                                    alt="Marie Dubois" class="rounded-circle mb-3"
                                    style="width: 120px; height: 120px; object-fit: cover;">
                                <h5>Marie Dubois</h5>
                                <p class="text-muted">Développeur Frontend</p>
                                <span class="badge bg-success">En cours</span>
                            </div>

                            <div class="card border-0 bg-light mb-3">
                                <div class="card-body">
                                    <h6>Informations générales</h6>
                                    <div class="mb-2">
                                        <strong>Departement:</strong> Développement
                                    </div>
                                    <div class="mb-2">
                                        <strong>Manager:</strong> Jean Dupont
                                    </div>
                                    <div class="mb-2">
                                        <strong>Date de début:</strong> 15 Novembre 2024
                                    </div>
                                    <div class="mb-2">
                                        <strong>Fin prévue:</strong> 15 Janvier 2025
                                    </div>
                                    <div class="mb-2">
                                        <strong>Durée:</strong> 2 mois
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Performance Details -->
                        <div class="col-md-8">
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <div class="card border-0 bg-primary text-white">
                                        <div class="card-body text-center">
                                            <h3 class="mb-1">85/100</h3>
                                            <p class="mb-0">Score du test</p>
                                            <small>Excellent niveau</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-0 bg-success text-white">
                                        <div class="card-body text-center">
                                            <h3 class="mb-1">88/100</h3>
                                            <p class="mb-0">Score d'entretien</p>
                                            <small>Très bon profil</small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Progress -->
                            <div class="card border-0 shadow-sm mb-3">
                                <div class="card-header">
                                    <h6 class="mb-0">Progression de la période d'essai</h6>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Progression générale</span>
                                        <span class="fw-bold">85%</span>
                                    </div>
                                    <div class="progress mb-3" style="height: 10px;">
                                        <div class="progress-bar bg-success" style="width: 85%"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <small class="text-muted">Temps écoulé: 58 jours</small>
                                        </div>
                                        <div class="col-6 text-end">
                                            <small class="text-muted">Temps restant: 3 jours</small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- CV and Documents -->
                            <div class="card border-0 shadow-sm mb-3">
                                <div class="card-header">
                                    <h6 class="mb-0">Documents et CV</h6>
                                </div>
                                <div class="card-body">
                                    <div class="d-grid gap-2">
                                        <button class="btn btn-outline-primary">
                                            <i class="bi bi-file-earmark-pdf me-2"></i>
                                            Télécharger CV - Marie_Dubois.pdf
                                        </button>
                                        <button class="btn btn-outline-success">
                                            <i class="bi bi-file-earmark-text me-2"></i>
                                            Voir contrat d'essai
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Evaluator Comments -->
                            <div class="card border-0 shadow-sm">
                                <div class="card-header">
                                    <h6 class="mb-0">Commentaires des évaluateurs</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <div class="d-flex align-items-start">
                                            <div
                                                class="user-avatar bg-primary rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-3">
                                                JD
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Jean Dupont <small class="text-muted">- Entretien
                                                        technique</small></h6>
                                                <p class="mb-1">Excellente maîtrise de React et TypeScript. Très bonne
                                                    compréhension des concepts avancés. Candidate prometteuse avec de
                                                    très bonnes capacités d'adaptation.</p>
                                                <small class="text-muted">Score: 88/100</small>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                    <div>
                                        <div class="d-flex align-items-start">
                                            <div
                                                class="user-avatar bg-success rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-3">
                                                CM
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1">Claire Martin <small class="text-muted">- Entretien
                                                        RH</small></h6>
                                                <p class="mb-1">Profil très motivé, excellente communication et esprit
                                                    d'équipe. S'intègre parfaitement dans notre culture d'entreprise.
                                                    Très bonne attitude professionnelle.</p>
                                                <small class="text-muted">Recommandation: Validation</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger">
                        <i class="bi bi-x-circle me-1"></i>
                        Ne pas valider
                    </button>
                    <button type="button" class="btn btn-warning">
                        <i class="bi bi-clock me-1"></i>
                        Prolonger période
                    </button>
                    <button type="button" class="btn btn-success">
                        <i class="bi bi-check-circle me-1"></i>
                        Valider l'essai
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
    <script>
        loadNavbar();
        loadSidebar();
    </script>
</body>

</html>