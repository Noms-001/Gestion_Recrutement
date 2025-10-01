<%@ page session="true" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.entreprise.entity.*" %>

<% Candidat candidat = (Candidat) request.getAttribute("candidatData"); %>

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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 fw-bold">Dépôt de CV</h1>
                </div>

                <form id="cvForm" class="needs-validation" novalidate>
                    <input type="hidden" id="candidatId" value="<%= candidat != null ? candidat.getId() : "" %>">
                    
                    <div class="row g-4">
                        <!-- Photo et CV -->
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Photo</h5>
                                </div>
                                <div class="card-body text-center">
                                    <div class="photo-upload text-center">
                                        <div id="photoPreview" class="photo-preview mb-4">
                                            <%
                                                if (candidat != null && candidat.getPhoto() != null && !candidat.getPhoto().isEmpty()) {
                                            %>
                                                <img src="${pageContext.request.contextPath}/<%= candidat.getPhoto() %>" alt="Photo"
                                                    style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                                            <%
                                                } else {
                                            %>
                                                <i class="bi bi-person-circle" style="font-size: 6rem; color: #dee2e6;"></i>
                                            <%
                                                }
                                            %>
                                        </div>
                                        <input type="file" id="photoInput" name="photo" class="d-none" accept="image/*">
                                        <button type="button" class="btn btn-outline-primary btn-sm mb-4"
                                                onclick="document.getElementById('photoInput').click()">
                                            <i class="bi bi-camera me-2"></i>Changer la photo
                                        </button>
                                    </div>
                                    <div class="cv-upload"> 
                                        <div id="cvPreview" class="p-4 border border-dashed rounded mb-3"> 
                                            <p class="text-muted mt-2 mb-0">Veuillez importer une photo récente.</p> 
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Informations personnelles -->
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Informations personnelles</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="nom" class="form-label">Nom *</label>
                                            <input type="text" class="form-control" id="nom"
                                                value="<%= candidat != null ? candidat.getUtilisateur().getNom() : "" %>"
                                                required>
                                            <div class="invalid-feedback">Veuillez saisir votre nom.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="prenom" class="form-label">Prénom *</label>
                                            <input type="text" class="form-control" id="prenom"
                                                value="<%= candidat != null ? candidat.getUtilisateur().getPrenom() : "" %>"
                                                required>
                                            <div class="invalid-feedback">Veuillez saisir votre prénom.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="email" class="form-label">Email *</label>
                                            <input type="email" class="form-control" id="email"
                                                value="<%= candidat != null ? candidat.getUtilisateur().getEmail() : "" %>"
                                                required>
                                            <div class="invalid-feedback">Veuillez saisir une adresse email valide.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="telephone" class="form-label">Téléphone *</label>
                                            <input type="tel" class="form-control" id="telephone"
                                                value="<%= candidat != null && candidat.getTelephone() != null ? candidat.getTelephone() : "" %>"
                                                required>
                                            <div class="invalid-feedback">Veuillez saisir votre numéro de téléphone.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="dateNaissance" class="form-label">Date de naissance</label>
                                            <input type="date" class="form-control" id="dateNaissance"
                                                value="<%= (candidat != null && candidat.getDateNaissance() != null) 
                                                            ? candidat.getDateNaissance().toString() 
                                                            : "" %>">

                                        </div>
                                        <div class="col-md-6">
                                            <label for="ville" class="form-label">Ville</label>
                                            <select class="form-select" id="ville" name="villeId">
                                                <option value="">Sélectionner une ville</option>
                                                <%
                                                    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
                                                    Long selectedVilleId = (candidat != null && candidat.getVille() != null? candidat.getVille().getId() : null);
                                                    if (villes != null) {
                                                        for (Ville f : villes) {
                                                            String selected = (selectedVilleId != null && selectedVilleId.equals(f.getId())) ? "selected" : "";
                                                %>
                                                            <option value="<%= f.getId() %>" <%= selected %>><%= f.getNom() %></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label for="adresse" class="form-label">Adresse</label>
                                            <textarea class="form-control" id="adresse" rows="2"><%= 
                                                    candidat != null && candidat.getAdresse() != null ? candidat.getAdresse() : "" %></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Expériences -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Expériences professionnelles</h5>
                                    <button type="button" class="btn btn-sm btn-outline-primary" id="addExperience">
                                        <i class="bi bi-plus-circle me-1"></i>Ajouter
                                    </button>
                                </div>
                                <div class="card-body" id="experienceForm">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Date de début</label>
                                            <input type="month" class="form-control" id="startMonth">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Date de fin</label>
                                            <input type="month" class="form-control" id="endMonth">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Lieu/Entreprise</label>
                                            <input type="text" class="form-control" id="company">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Filière</label>
                                            <select class="form-select" id="field" name="filiereId">
                                                <option value="">Sélectionner une filière</option>
                                                <%
                                                    List<Filiere> filieres = (List<Filiere>) request.getAttribute("filieres");
                                                    if (filieres != null) {
                                                        for (Filiere f : filieres) {
                                                %>
                                                            <option value="<%= f.getId() %>"><%= f.getLibelle() %></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Description du poste</label>
                                            <textarea class="form-control" rows="2" id="description"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card" style="height: 345px; overflow-y: auto;">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Aperçu des expériences</h5>
                                </div>
                                <div class="card-body" id="previewContainer">
                                    <p class="text-muted">Vos expériences ajoutées apparaîtront ici.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Formation -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Formation</h5>
                                    <button type="button" class="btn btn-sm btn-outline-primary" id="addEducation">
                                        <i class="bi bi-plus-circle me-1"></i>Ajouter
                                    </button>
                                </div>
                                <div class="card-body" id="educationForm">
                                    <div class="d-flex justify-content-between mb-3">
                                            <div class="col-md-5 input-with-icon">
                                                <label for="startYear" class="form-label">Année début</label>
                                                <input class="form-control" id="startYear" name="startYear">
                                                <i class="bi bi-calendar"></i>
                                                <div id="startYearPicker" class="year-picker-dropdown">
                                                    <div class="year-grid"></div>
                                                    <div class="year-nav text-center mt-2">
                                                        <button type="button" class="btn btn-sm btn-outline-secondary me-2" id="prevStartYear"><span class="bi bi-chevron-left"></span></button>
                                                        <button type="button" class="btn btn-sm btn-outline-primary" id="nextStartYear"><span class="bi bi-chevron-right"></span></button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-5 input-with-icon">
                                                <label for="endYear" class="form-label">Année fin</label>
                                                <input class="form-control" id="endYear" name="endYear">
                                                <i class="bi bi-calendar"></i>
                                                <div id="endYearPicker" class="year-picker-dropdown">
                                                    <div class="year-grid"></div>
                                                    <div class="year-nav text-center mt-2">
                                                        <button type="button" class="btn btn-sm btn-outline-secondary me-2" id="prevEndYear"><span class="bi bi-chevron-left"></span></button>
                                                        <button type="button" class="btn btn-sm btn-outline-primary" id="nextEndYear"><span class="bi bi-chevron-right"></span></button>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>

                                    
                                    <div class="mb-3">
                                        <label class="form-label">Diplôme</label>
                                        <select class="form-select" id="degree" name="diplomeId">
                                            <option value="">Sélectionner un diplôme</option>
                                            <%
                                                List<Diplome> diplomes = (List<Diplome>) request.getAttribute("diplomes");
                                                if (diplomes != null) {
                                                    for (Diplome d : diplomes) {
                                            %>
                                                        <option value="<%= d.getId() %>"><%= d.getLibelle() %></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Filière</label>
                                        <select class="form-select" id="major" name="filiereId">
                                            <option value="">Sélectionner une filière</option>
                                            <%
                                                if (filieres != null) {
                                                    for (Filiere f : filieres) {
                                            %>
                                                        <option value="<%= f.getId() %>"><%= f.getLibelle() %></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Lieu/École</label>
                                        <input type="text" class="form-control" id="school">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card" style="height: 425px; overflow-y: auto;">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Aperçu des formations</h5>
                                </div>
                                <div class="card-body" id="educationPreview">
                                    <p class="text-muted">Vos formations ajoutées apparaîtront ici.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Compétences et Langues -->
                    <div class="row g-4 mt-1">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Compétences</h5>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex mb-3">
                                        <select class="form-select me-2" id="skillSelect" name="competenceId">
                                            <option value="">Sélectionner une compétence</option>
                                            <%
                                                List<Competence> competences = (List<Competence>) request.getAttribute("competences");
                                                if (competences != null) {
                                                    for (Competence c : competences) {
                                            %>
                                                        <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <button type="button" class="btn btn-primary" id="addSkillBtn"><i class="bi bi-plus"></i></button>
                                    </div>
                                    <div id="skillsTags" class="tags-container d-flex flex-wrap gap-2"></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Langues</h5>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex mb-3">
                                        <select class="form-select me-2" id="languageSelect" name="langueId">
                                            <option value="">Sélectionner une langue</option>
                                            <%
                                                List<Langue> langues = (List<Langue>) request.getAttribute("langues");
                                                if (langues != null) {
                                                    for (Langue l : langues) {
                                            %>
                                                        <option value="<%= l.getId() %>"><%= l.getLibelle() %></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <button type="button" class="btn btn-primary" id="addLanguageBtn"><i class="bi bi-plus"></i></button>
                                    </div>
                                    <div id="languagesTags" class="tags-container d-flex flex-wrap gap-2"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-end mt-4">
                        <a href="/cv-preview">
                            <button type="button" class="btn btn-outline-secondary me-2">
                                <i class="bi bi-eye me-2"></i>Aperçu du CV
                            </button>
                        </a>
                        <button type="button" id="submitCv" class="btn btn-primary">
                            <i class="bi bi-check-circle me-2"></i>Déposer mon CV
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/upload-photo.js"></script>
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
    <script src="${pageContext.request.contextPath}/resources/js/experience.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/education.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/skills.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/languages.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/cv-submission.js"></script>
    <script>
        function setupYearPicker(inputId, pickerId, displayId, prevBtnId, nextBtnId, minYear=1901, maxYear=new Date().getFullYear()) {
            const input = document.getElementById(inputId);
            const picker = document.getElementById(pickerId);
            const display =document.getElementById(displayId);
            const grid = picker.querySelector(".year-grid");
            const prevBtn = document.getElementById(prevBtnId);
            const nextBtn = document.getElementById(nextBtnId);

            const years = [];
            for (let y = minYear; y <= maxYear; y++) years.push(y);

            const pageSize = 9;
            let currentPage = 0;

            function renderPage(page) {
                grid.innerHTML = "";
                const start = page * pageSize;
                const end = Math.min(start + pageSize, years.length);

                for (let i = start; i < end; i++) {
                    const div = document.createElement("div");
                    div.textContent = years[i];
                    div.dataset.value = years[i];
                    div.addEventListener("click", (e) => {
                        e.stopPropagation();
                        input.value = div.dataset.value;
                        grid.querySelectorAll("div").forEach(d => d.classList.remove("selected"));
                        div.classList.add("selected");
                        picker.style.display = "none";
                    });
                    grid.appendChild(div);
                }

                // activer / désactiver les boutons selon la page
                prevBtn.disabled = page === 0;
                nextBtn.disabled = end >= years.length;
            }

            prevBtn.addEventListener("click", (e) => {
                e.stopPropagation();
                if (currentPage > 0) {
                    currentPage--;
                    renderPage(currentPage);
                }
            });

            nextBtn.addEventListener("click", (e) => {
                e.stopPropagation();
                if ((currentPage + 1) * pageSize < years.length) {
                    currentPage++;
                    renderPage(currentPage);
                }
            });

            [input, input.parentElement.querySelector("i")].forEach(el => {
                el.addEventListener("click", (e) => {
                    e.stopPropagation();
                    picker.style.display = picker.style.display === "grid" ? "none" : "grid";
                    display.style.display = "none";
                    if (picker.style.display === "grid") renderPage(currentPage);
                });
            });

            document.addEventListener("click", () => {
                picker.style.display = "none";
            });
        }

        // Initialisation
        setupYearPicker("startYear", "startYearPicker", "endYearPicker", "prevStartYear", "nextStartYear");
        setupYearPicker("endYear", "endYearPicker", "startYearPicker", "prevEndYear", "nextEndYear");

    </script>

</body>
</html>     