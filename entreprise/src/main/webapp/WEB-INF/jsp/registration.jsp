<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Inscription</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/logo.png">
</head>

<body>
    <div class="container-fluid py-5">
        <div class="row">
            <div class="col-md-8 col-lg-6 col-xl-5 mx-auto">
                <div class="card shadow-lg border-0">
                    <div class="card-body p-5">
                        <div class="text-center mb-4 logo">
                            <img src="img/logo.png" alt="logo" class="logo-img mb-3">
                            <h1 class="fw-bold text-primary" style="margin-left: -15%;">Talent<small style="margin-top: -2%;">Sphere</small></h1>
                            <p class="text-muted">Créer votre compte</p>
                        </div>
                            
                        <form id="registrationForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="nom" class="form-label">Nom</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                        <input type="text" class="form-control" id="nom" placeholder="Dupont" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="prenom" class="form-label">Prénom</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                        <input type="text" class="form-control" id="prenom" placeholder="Jean" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Adresse email</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                                    <input type="email" class="form-control" id="email" placeholder="exemple@email.com"
                                        required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="password" class="form-label">Mot de passe</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                        <input type="password" class="form-control" id="password" placeholder="••••••••"
                                            required>
                                        <button class="btn btn-eye" type="button" id="togglePassword">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                        <input type="password" class="form-control" id="confirmPassword"
                                            placeholder="••••••••" required>
                                        <button class="btn btn-eye" type="button" id="toggleConfirmPassword">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="profile" class="form-label">Type de profil</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person-badge-fill"></i></span>
                                    <select class="form-select" id="profile" required>
                                        <option value="">Sélectionner un profil</option>
                                        <option value="candidat">Candidat</option>
                                        <option value="recruteur">Recruteur</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3 d-none" id="posteField">
                                <label for="poste" class="form-label">Poste</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-briefcase-fill"></i></span>
                                    <select class="form-select" id="poste">
                                        <option value="">Sélectionner un poste</option>
                                        <option value="rh_manager">Manager RH</option>
                                        <option value="recruteur_senior">Recruteur Senior</option>
                                        <option value="recruteur_junior">Recruteur Junior</option>
                                        <option value="consultant_rh">Consultant RH</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="terms" required>
                                    <label class="form-check-label" for="terms">
                                        J'accepte les <a href="#" class="text-primary">conditions d'utilisation</a>
                                    </label>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary btn-lg w-100 mb-3">
                                <i class="bi bi-person-plus me-2"></i>Créer mon compte
                            </button>
                        </form>

                        <div class="text-center">
                            <p class="mb-0">Déjà un compte ?
                                <a href="index.html" class="text-primary text-decoration-none fw-semibold">Se
                                    connecter</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/register.js"></script>
</body>

</html>