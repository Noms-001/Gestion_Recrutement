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

                <!-- Filters -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" class="form-control" placeholder="Rechercher un candidat...">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select">
                                    <option value="">Tous les postes</option>
                                    <option value="dev-frontend">Développeur Frontend</option>
                                    <option value="dev-backend">Développeur Backend</option>
                                    <option value="designer">Designer UX/UI</option>
                                    <option value="chef-projet">Chef de projet</option>
                                    <option value="commercial">Commercial</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select">
                                    <option value="">Score minimum</option>
                                    <option value="90">90+</option>
                                    <option value="80">80+</option>
                                    <option value="70">70+</option>
                                    <option value="60">60+</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select">
                                    <option value="">Trier par</option>
                                    <option value="date">Date d'entretien</option>
                                    <option value="score">Score total</option>
                                    <option value="name">Nom</option>
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

                <!-- Candidates Table -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-list-check me-2"></i>
                            Liste des candidats en attente de validation
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th>Candidat</th>
                                        <th>Poste</th>
                                        <th>Score test</th>
                                        <th>Score entretien</th>
                                        <th>Score total</th>
                                        <th>Date entretien</th>
                                        <th>Évaluateur</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=40&h=40&fit=crop"
                                                    alt="Marie Dubois" class="avatar rounded-circle me-3">
                                                <div>
                                                    <div class="fw-medium">Marie Dubois</div>
                                                    <small class="text-muted">27 ans • 3 ans d'exp.</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-medium">Développeur Frontend</div>
                                            <small class="text-muted">Développement</small>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">85/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 85%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">88/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 88%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success fs-5">86.5/100</div>
                                            <span class="badge bg-success">Excellent</span>
                                        </td>
                                        <td>
                                            <div>12/01/2025</div>
                                            <small class="text-muted">Il y a 3 jours</small>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar bg-primary rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-2"
                                                    style="width: 30px; height: 30px; font-size: 12px;">
                                                    JD
                                                </div>
                                                <div>
                                                    <div class="fw-medium">Jean Dupont</div>
                                                    <small class="text-muted">Tech Lead</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <button class="btn btn-sm btn-outline-primary"
                                                    onclick="showCandidateDetails(1)">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="validateCandidate(1)">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=40&h=40&fit=crop"
                                                    alt="Thomas Leroy" class="avatar rounded-circle me-3">
                                                <div>
                                                    <div class="fw-medium">Thomas Leroy</div>
                                                    <small class="text-muted">32 ans • 5 ans d'exp.</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-medium">Chef de projet</div>
                                            <small class="text-muted">Management</small>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-warning">72/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-warning" style="width: 72%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">90/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 90%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success fs-5">81/100</div>
                                            <span class="badge bg-info">Très bon</span>
                                        </td>
                                        <td>
                                            <div>10/01/2025</div>
                                            <small class="text-muted">Il y a 5 jours</small>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar bg-success rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-2"
                                                    style="width: 30px; height: 30px; font-size: 12px;">
                                                    CM
                                                </div>
                                                <div>
                                                    <div class="fw-medium">Claire Martin</div>
                                                    <small class="text-muted">RH Manager</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <button class="btn btn-sm btn-outline-primary"
                                                    onclick="showCandidateDetails(2)">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="validateCandidate(2)">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://images.pexels.com/photos/1036627/pexels-photo-1036627.jpeg?auto=compress&cs=tinysrgb&w=40&h=40&fit=crop"
                                                    alt="Sophie Bernard" class="avatar rounded-circle me-3">
                                                <div>
                                                    <div class="fw-medium">Sophie Bernard</div>
                                                    <small class="text-muted">29 ans • 4 ans d'exp.</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-medium">Designer UX/UI</div>
                                            <small class="text-muted">Design</small>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">92/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 92%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">95/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 95%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success fs-5">93.5/100</div>
                                            <span class="badge bg-success">Excellent</span>
                                        </td>
                                        <td>
                                            <div>08/01/2025</div>
                                            <small class="text-muted">Il y a 7 jours</small>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar bg-info rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-2"
                                                    style="width: 30px; height: 30px; font-size: 12px;">
                                                    PD
                                                </div>
                                                <div>
                                                    <div class="fw-medium">Paul Durand</div>
                                                    <small class="text-muted">Directeur</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <button class="btn btn-sm btn-outline-primary"
                                                    onclick="showCandidateDetails(3)">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="validateCandidate(3)">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=40&h=40&fit=crop"
                                                    alt="Pierre Martin" class="avatar rounded-circle me-3">
                                                <div>
                                                    <div class="fw-medium">Pierre Martin</div>
                                                    <small class="text-muted">25 ans • 2 ans d'exp.</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-medium">Développeur Backend</div>
                                            <small class="text-muted">Développement</small>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-danger">58/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-danger" style="width: 58%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-warning">65/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-warning" style="width: 65%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-danger fs-5">61.5/100</div>
                                            <span class="badge bg-warning">Moyen</span>
                                        </td>
                                        <td>
                                            <div>05/01/2025</div>
                                            <small class="text-muted">Il y a 10 jours</small>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar bg-primary rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-2"
                                                    style="width: 30px; height: 30px; font-size: 12px;">
                                                    JD
                                                </div>
                                                <div>
                                                    <div class="fw-medium">Jean Dupont</div>
                                                    <small class="text-muted">Tech Lead</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <button class="btn btn-sm btn-outline-primary"
                                                    onclick="showCandidateDetails(4)">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="validateCandidate(4)">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://images.pexels.com/photos/1181690/pexels-photo-1181690.jpeg?auto=compress&cs=tinysrgb&w=40&h=40&fit=crop"
                                                    alt="Lisa Garcia" class="avatar rounded-circle me-3">
                                                <div>
                                                    <div class="fw-medium">Lisa Garcia</div>
                                                    <small class="text-muted">31 ans • 6 ans d'exp.</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-medium">Commerciale</div>
                                            <small class="text-muted">Commercial</small>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">88/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 88%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success">92/100</div>
                                            <div class="progress mt-1" style="height: 4px;">
                                                <div class="progress-bar bg-success" style="width: 92%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-success fs-5">90/100</div>
                                            <span class="badge bg-success">Excellent</span>
                                        </td>
                                        <td>
                                            <div>03/01/2025</div>
                                            <small class="text-muted">Il y a 12 jours</small>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar bg-warning rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-2"
                                                    style="width: 30px; height: 30px; font-size: 12px;">
                                                    AD
                                                </div>
                                                <div>
                                                    <div class="fw-medium">Anne Dupuis</div>
                                                    <small class="text-muted">Dir. Commercial</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <button class="btn btn-sm btn-outline-primary"
                                                    onclick="showCandidateDetails(5)">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-success" onclick="validateCandidate(5)">
                                                    <i class="bi bi-check"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Candidate Details Modal -->
            <div class="modal fade" id="candidateDetailsModal" tabindex="-1">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-person-circle me-2"></i>
                                Détails du candidat
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <!-- Candidate Info -->
                                <div class="col-md-4">
                                    <div class="text-center mb-4">
                                        <img src="https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=120&h=120&fit=crop"
                                            alt="Marie Dubois" class="rounded-circle mb-3"
                                            style="width: 120px; height: 120px; object-fit: cover;">
                                        <h5>Marie Dubois</h5>
                                        <p class="text-muted">Développeur Frontend</p>
                                        <div class="mb-3">
                                            <span class="badge bg-primary me-1">React</span>
                                            <span class="badge bg-primary me-1">JavaScript</span>
                                            <span class="badge bg-primary">TypeScript</span>
                                        </div>
                                    </div>

                                    <div class="card border-0 bg-light mb-3">
                                        <div class="card-body">
                                            <h6>Informations personnelles</h6>
                                            <div class="mb-2">
                                                <strong>Âge:</strong> 27 ans
                                            </div>
                                            <div class="mb-2">
                                                <strong>Expérience:</strong> 3 ans
                                            </div>
                                            <div class="mb-2">
                                                <strong>Localisation:</strong> Paris, France
                                            </div>
                                            <div class="mb-2">
                                                <strong>Formation:</strong> Master Informatique
                                            </div>
                                            <div class="mb-2">
                                                <strong>Langues:</strong> Français, Anglais, Espagnol
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <button class="btn btn-outline-primary">
                                            <i class="bi bi-file-earmark-pdf me-2"></i>
                                            Télécharger CV
                                        </button>
                                        <button class="btn btn-outline-info">
                                            <i class="bi bi-envelope me-2"></i>
                                            Contacter le candidat
                                        </button>
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
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="card border-0 bg-success text-white">
                                                <div class="card-body text-center">
                                                    <h3 class="mb-1">88/100</h3>
                                                    <p class="mb-0">Score d'entretien</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Interview Evaluation -->
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-header">
                                            <h6 class="mb-0">Évaluation d'entretien</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-3">
                                                <div class="d-flex align-items-start">
                                                    <div
                                                        class="user-avatar bg-primary rounded-circle d-flex align-items-center justify-content-center text-white fw-bold me-3">
                                                        JD
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-1">Jean Dupont <small class="text-muted">- Tech
                                                                Lead</small></h6>
                                                        <p class="mb-2">Excellente candidate avec une très bonne
                                                            maîtrise
                                                            technique. Démontre une grande capacité d'adaptation et une
                                                            approche
                                                            méthodique des problèmes. Communication claire et précise.
                                                        </p>

                                                        <div class="row g-2 mb-2">
                                                            <div class="col-6">
                                                                <small class="text-muted">Compétences
                                                                    techniques:</small>
                                                                <div class="fw-bold text-success">18/50</div>
                                                            </div>
                                                            <div class="col-6">
                                                                <small class="text-muted">Adéquation culturelle:</small>
                                                                <div class="fw-bold text-success">5/10</div>
                                                            </div>
                                                            </div>
                                                            <div class="col-6">
                                                                <small class="text-muted">Compétences
                                                                    comportementales:</small>
                                                                <div class="fw-bold text-success">9/40</div>
                                                        </div>

                                                        <div class="mb-2">
                                                            <strong>Points forts:</strong>
                                                            <ul class="mb-1">
                                                                <li>Excellente maîtrise de React et de l'écosystème
                                                                    JavaScript
                                                                </li>
                                                                <li>Approche méthodique et structurée</li>
                                                                <li>Très bonne communication</li>
                                                            </ul>
                                                        </div>


                                                        <div class="mb-2">
                                                            <strong>Points forts:</strong>
                                                            <ul class="mb-1">
                                                                <li>Excellente maîtrise de React et de l'écosystème
                                                                    JavaScript
                                                                </li>
                                                                <li>Approche méthodique et structurée</li>
                                                                <li>Très bonne communication</li>
                                                            </ul>
                                                        </div>

                                                        <div class="mb-2">
                                                            <strong>Points d'amélioration:</strong>
                                                            <ul class="mb-1">
                                                                <li>Pourrait approfondir ses connaissances en
                                                                    architecture</li>
                                                                <li>Expérience limitée sur les projets à grande échelle
                                                                </li>
                                                            </ul>
                                                        </div>
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
                                Refuser
                            </button>
                            <button type="button" class="btn btn-warning">
                                <i class="bi bi-clock me-1"></i>
                                Reporter la décision
                            </button>
                            <button type="button" class="btn btn-success" onclick="validateCandidate(1)">
                                <i class="bi bi-check-circle me-1"></i>
                                Valider le candidat
                            </button>
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
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>

</html>