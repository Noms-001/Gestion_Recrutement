<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Dépôt de CV</title>
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
                <div class="container-fluid">
                    <div class="row">
                            <div class="row">
                                <!-- Candidate Information -->
                                <div class="col-lg-4">
                                    <div class="card border-0 shadow-sm mb-4 sticky-top" style="top: 120px;">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="card-title mb-0">
                                                <i class="bi bi-person me-2"></i>
                                                Informations candidat
                                            </h5>
                                        </div>
                                        <div class="card-body text-center">
                                            <img src="https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=150&h=150&fit=crop"
                                                alt="Photo candidat" class="avatar-lg rounded-circle mb-3">
                                            <h5 class="card-title">Marie Dubois</h5>
                                            <p class="text-muted mb-3">Développeur Frontend</p>

                                            <div class="row text-center mb-3">
                                                <div class="col">
                                                    <div class="fw-bold text-primary">3 ans</div>
                                                    <small class="text-muted">Expérience</small>
                                                </div>
                                                <div class="col">
                                                    <div class="fw-bold text-success">85/100</div>
                                                    <small class="text-muted">Score test</small>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <span class="badge bg-primary me-1">React</span>
                                                <span class="badge bg-primary me-1">JavaScript</span>
                                                <span class="badge bg-primary me-1">TypeScript</span>
                                                <span class="badge bg-secondary">CSS</span>
                                            </div>

                                            <button class="btn btn-outline-primary btn-sm">
                                                <i class="bi bi-file-earmark-pdf me-1"></i>
                                                Voir CV
                                            </button>
                                        </div>

                                        <!-- Score Summary -->
                                        <div class="card-footer bg-light">
                                            <div class="text-center">
                                                <h6>Score total actuel</h6>
                                                <div class="score-display score-good" id="totalScore">
                                                    0/100 (0%)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Evaluation Form -->
                                <div class="col-lg-8">
                                    <form class="needs-validation" novalidate>
                                        <!-- Interview Information -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-info text-white">
                                                <h5 class="card-title mb-0">
                                                    <i class="bi bi-calendar-event me-2"></i>
                                                    Informations entretien
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="row g-3">
                                                    <div class="col-md-6">
                                                        <label for="interviewDate" class="form-label">Date de
                                                            l'entretien</label>
                                                        <input type="date" class="form-control" id="interviewDate"
                                                            required>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="interviewDuration" class="form-label">Durée
                                                            (minutes)</label>
                                                        <input type="number" class="form-control" id="interviewDuration"
                                                            min="15" max="180" value="60">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="interviewType" class="form-label">Type
                                                            d'entretien</label>
                                                        <select class="form-select" id="interviewType">
                                                            <option value="technique">Entretien technique</option>
                                                            <option value="rh">Entretien RH</option>
                                                            <option value="direction">Entretien direction</option>
                                                            <option value="final">Entretien final</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="interviewFormat" class="form-label">Format</label>
                                                        <select class="form-select" id="interviewFormat">
                                                            <option value="presentiel">Présentiel</option>
                                                            <option value="visio">Visioconférence</option>
                                                            <option value="telephone">Téléphone</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Technical Skills -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-success text-white">
                                                <h5 class="card-title mb-0">
                                                    <i class="bi bi-code-slash me-2"></i>
                                                    Compétences techniques
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="row g-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label">Maîtrise des technologies
                                                            requises</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="20" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/20'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/20</span>
                                                            <small class="text-muted">20</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Architecture et bonnes
                                                            pratiques</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="15" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/15'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/15</span>
                                                            <small class="text-muted">15</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Résolution de problèmes</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="15" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/15'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/15</span>
                                                            <small class="text-muted">15</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Veille technologique</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="10" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/10'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/10</span>
                                                            <small class="text-muted">10</small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-3">
                                                    <label for="technicalComments" class="form-label">Commentaires
                                                        techniques</label>
                                                    <textarea class="form-control" id="technicalComments" rows="3"
                                                        placeholder="Notes sur les compétences techniques du candidat..."></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Soft Skills -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-warning text-white">
                                                <h5 class="card-title mb-0">
                                                    <i class="bi bi-people me-2"></i>
                                                    Compétences comportementales
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="row g-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label">Communication</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="10" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/10'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/10</span>
                                                            <small class="text-muted">10</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Esprit d'équipe</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="10" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/10'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/10</span>
                                                            <small class="text-muted">10</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Autonomie</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="10" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/10'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/10</span>
                                                            <small class="text-muted">10</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Motivation</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="10" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/10'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/10</span>
                                                            <small class="text-muted">10</small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-3">
                                                    <label for="softSkillsComments" class="form-label">Commentaires
                                                        comportementaux</label>
                                                    <textarea class="form-control" id="softSkillsComments" rows="3"
                                                        placeholder="Notes sur les soft skills du candidat..."></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Cultural Fit -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-secondary text-white">
                                                <h5 class="card-title mb-0">
                                                    <i class="bi bi-building me-2"></i>
                                                    Adéquation culturelle
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="row g-4">
                                                    <div class="col-md-6">
                                                        <label class="form-label">Adhésion aux valeurs de
                                                            l'entreprise</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="5" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/5'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/5</span>
                                                            <small class="text-muted">5</small>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label">Intégration dans l'équipe</label>
                                                        <input type="range" class="form-range score-input" min="0"
                                                            max="5" value="0"
                                                            oninput="this.nextElementSibling.textContent = this.value + '/5'; updateTotalScore()">
                                                        <div class="d-flex justify-content-between">
                                                            <small class="text-muted">0</small>
                                                            <span class="fw-bold">0/5</span>
                                                            <small class="text-muted">5</small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-3">
                                                    <label for="culturalComments" class="form-label">Commentaires sur
                                                        l'adéquation culturelle</label>
                                                    <textarea class="form-control" id="culturalComments" rows="3"
                                                        placeholder="Évaluation de l'adéquation avec la culture d'entreprise..."></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Final Assessment -->
                                        <div class="card border-0 shadow-sm mb-4">
                                            <div class="card-header bg-dark text-white">
                                                <h5 class="card-title mb-0">
                                                    <i class="bi bi-clipboard-check me-2"></i>
                                                    Évaluation globale
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <div class="mb-3">
                                                    <label for="overallRecommendation"
                                                        class="form-label">Recommandation</label>
                                                    <select class="form-select" id="overallRecommendation" required>
                                                        <option value="">Sélectionnez une recommandation</option>
                                                        <option value="excellent">Excellent candidat - Embauche
                                                            immédiate</option>
                                                        <option value="good">Bon candidat - À recommander</option>
                                                        <option value="average">Candidat moyen - À discuter</option>
                                                        <option value="poor">Ne convient pas - Ne pas retenir</option>
                                                    </select>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="strengths" class="form-label">Points forts</label>
                                                    <textarea class="form-control" id="strengths" rows="3"
                                                        placeholder="Listez les principaux points forts du candidat..."></textarea>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="improvements" class="form-label">Points
                                                        d'amélioration</label>
                                                    <textarea class="form-control" id="improvements" rows="3"
                                                        placeholder="Listez les axes d'amélioration identifiés..."></textarea>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="additionalComments" class="form-label">Commentaires
                                                        supplémentaires</label>
                                                    <textarea class="form-control" id="additionalComments" rows="4"
                                                        placeholder="Toute information complémentaire jugée importante..."></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit Actions -->
                                        <div class="card border-0 shadow-sm">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox"
                                                                id="sendNotification" checked>
                                                            <label class="form-check-label" for="sendNotification">
                                                                Notifier l'équipe RH
                                                            </label>
                                                        </div>
                                                        <small class="text-muted">Une notification sera envoyée avec le
                                                            score et la recommandation</small>
                                                    </div>
                                                    <div>
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="bi bi-send me-1"></i>
                                                            Soumettre l'évaluation
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </main>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/app.js"></script>
    <script>
        loadNavbar();
        loadSidebar();
    </script>
</body>

</html>