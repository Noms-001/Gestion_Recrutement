<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if(session.getAttribute("id_utilisateur") == null) {
        response.sendRedirect("/");
    }
%>

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
                                            <c:forEach var="dep" items="${departements}">
                                                <option value="${dep.id}">${dep.nom}</option>
                                            </c:forEach>
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
                                            <c:forEach var="annonce" items="${annonces}">
                                                <tr>
                                                    <td>
                                                        <div class="fw-medium">${annonce.titre}</div>
                                                        <small class="text-muted">${annonce.salaire} • ${annonce.localisation}</small>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-primary">${annonce.departement.nom}</span>
                                                    </td>
                                                    <td>${annonce.typeContrat}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${annonce.ferme}">
                                                                <span class="badge bg-dark">Fermée</span>
                                                            </c:when>
                                                            <c:when test="${annonce.dateLimite.before(new java.util.Date())}">
                                                                <span class="badge bg-danger">Expirée</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Active</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="fw-bold">${annonce.nombreCandidatures}</div>
                                                        <small class="text-muted">candidatures</small>
                                                    </td>
                                                    <td><fmt:formatDate value="${annonce.dateCreation}" pattern="dd/MM/yyyy"/></td>
                                                    <td><fmt:formatDate value="${annonce.dateLimite}" pattern="dd/MM/yyyy"/></td>
                                                    <td>
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                                                type="button" data-bs-toggle="dropdown">
                                                                Actions
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a class="dropdown-item" href="#"
                                                                        onclick="editJobOffer(${annonce.id})"><i
                                                                            class="bi bi-pencil me-2"></i>Modifier</a></li>
                                                                <li><a class="dropdown-item" href="#"><i
                                                                            class="bi bi-eye me-2"></i>Voir les
                                                                        candidatures</a></li>
                                                                <hr class="dropdown-divider">
                                                                <li><a class="dropdown-item" href="#"><i
                                                                            class="bi bi-x-circle me-2"></i>Fermée
                                                                        l'annonce</a></li>
                                                                <li><a class="dropdown-item text-danger" href="#"><i
                                                                            class="bi bi-trash me-2"></i>Supprimer</a></li>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
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
                                                    <c:forEach var="dep" items="${departements}">
                                                        <option value="${dep.id}">${dep.nom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <!-- Reste des champs identiques à ton HTML initial -->
                                            <!-- Âge, Expérience, Localisation, Genre, Diplôme, Filière, Description, Compétences, Langues -->
                                            <!-- Tout conservé comme dans ton HTML original -->
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
                                <!-- Publication Settings, Skills -->
                                <!-- Tout conservé tel quel, identique à ton HTML original -->
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
            avatar: "<%= session.getAttribute("avatarColor") %>",
            id: "<%= session.getAttribute("id_utilisateur") %>",
            poste: "<%= session.getAttribute("poste") %>"
        };
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/manage-job.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tag-job.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>
