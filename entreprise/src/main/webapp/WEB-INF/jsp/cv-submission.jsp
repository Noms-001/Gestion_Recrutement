<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Dépôt de CV</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-icons.css" rel="stylesheet">
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
                    <div class="row g-4">
                        <!-- Photo et CV -->
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Photo</h5>
                                </div>
                                <div class="card-body text-center">
                                    <div class="mb-4">
                                        <div class="photo-upload">
                                            <div id="photoPreview" class="photo-preview mb-3">
                                                <i class="bi bi-person-circle"
                                                    style="font-size: 6rem; color: #dee2e6;"></i>
                                            </div>
                                            <input type="file" id="photoInput" class="d-none" accept="image/*">
                                            <button type="button" class="btn btn-outline-primary btn-sm"
                                                onclick="document.getElementById('photoInput').click()">
                                                <i class="bi bi-camera me-2"></i>Ajouter une photo
                                            </button>
                                        </div>
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
                                            <input type="text" class="form-control" id="nom" required>
                                            <div class="invalid-feedback">Veuillez saisir votre nom.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="prenom" class="form-label">Prénom *</label>
                                            <input type="text" class="form-control" id="prenom" required>
                                            <div class="invalid-feedback">Veuillez saisir votre prénom.</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="email" class="form-label">Email *</label>
                                            <input type="email" class="form-control" id="email" required>
                                            <div class="invalid-feedback">Veuillez saisir une adresse email valide.
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="telephone" class="form-label">Téléphone *</label>
                                            <input type="tel" class="form-control" id="telephone" required>
                                            <div class="invalid-feedback">Veuillez saisir votre numéro de téléphone.
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="dateNaissance" class="form-label">Date de naissance</label>
                                            <input type="date" class="form-control" id="dateNaissance">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="ville" class="form-label">Ville</label>
                                            <input type="text" class="form-control" id="ville">
                                        </div>
                                        <div class="col-12">
                                            <label for="adresse" class="form-label">Adresse</label>
                                            <textarea class="form-control" id="adresse" rows="2"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Expériences -->
                    <div class="row mt-4">
                        <!-- Formulaire -->
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
                                            <select class="form-select" id="field">
                                                <option value="">Sélectionner une filière</option>
                                                <option value="informatique">Informatique</option>
                                                <option value="marketing">Marketing</option>
                                                <option value="finance">Finance</option>
                                                <option value="rh">Ressources Humaines</option>
                                                <option value="commercial">Commercial</option>
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

                        <!-- Aperçu dynamique -->
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
                        <!-- Formulaire Formation -->
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Formation</h5>
                                    <button type="button" class="btn btn-sm btn-outline-primary" id="addEducation">
                                        <i class="bi bi-plus-circle me-1"></i>Ajouter
                                    </button>
                                </div>
                                <div class="card-body" id="educationForm">
                                    <div class="mb-3">
                                        <label class="form-label">Diplôme</label>
                                        <select class="form-select" id="degree">
                                            <option value="">Sélectionner un diplôme</option>
                                            <option value="Bac">Baccalauréat</option>
                                            <option value="Bac+2">Bac+2 (BTS, DUT)</option>
                                            <option value="Bac+3">Bac+3 (Licence)</option>
                                            <option value="Bac+5">Bac+5 (Master)</option>
                                            <option value="Doctorat">Doctorat</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Filière</label>
                                        <select class="form-select" id="major">
                                            <option value="">Sélectionner une filière</option>
                                            <option value="informatique">Informatique</option>
                                            <option value="marketing">Marketing</option>
                                            <option value="finance">Finance</option>
                                            <option value="rh">Ressources Humaines</option>
                                            <option value="commercial">Commercial</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Lieu/École</label>
                                        <input type="text" class="form-control" id="school">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Aperçu dynamique -->
                        <div class="col-md-6">
                            <div class="card" style="height: 345px; overflow-y: auto;">
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
                                        <select class="form-select me-2" id="skillSelect">
                                            <option value="">Sélectionner une compétence</option>
                                            <option value="HTML">HTML</option>
                                            <option value="CSS">CSS</option>
                                            <option value="JavaScript">JavaScript</option>
                                            <option value="Python">Python</option>
                                            <option value="Java">Java</option>
                                        </select>
                                        <button type="button" class="btn btn-primary" id="addSkillBtn"><i
                                                class="bi bi-plus"></i></button>
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
                                        <select class="form-select me-2" id="languageSelect">
                                            <option value="">Sélectionner une langue</option>
                                            <option value="Français">Français</option>
                                            <option value="Anglais">Anglais</option>
                                            <option value="Espagnol">Espagnol</option>
                                            <option value="Allemand">Allemand</option>
                                        </select>
                                        <button type="button" class="btn btn-primary" id="addLanguageBtn"><i
                                                class="bi bi-plus"></i></button>
                                    </div>
                                    <div id="languagesTags" class="tags-container d-flex flex-wrap gap-2"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-end mt-4">
                        <a href="view-cv.html">
                            <button type="button" class="btn btn-outline-secondary me-2">
                                <i class="bi bi-eye me-2"></i>Aperçu du CV
                            </button>
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle me-2"></i>Déposer mon CV
                        </button>
                    </div>

                </form>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/cv-submission.js"></script>
    <script>
        loadNavbar();
        loadSidebar();
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/experience.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/formation.js"></script>
</body>

</html>