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
                <div class="mb-4"></div>

                <div class="row">
                    <!-- Contract Configuration -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="card-title mb-0">
                                    <i class="bi bi-gear me-2"></i>
                                    Configuration du contrat
                                </h5>
                            </div>
                            <div class="card-body">
                                <form>
                                    <div class="mb-3">
                                        <label for="candidateName" class="form-label">Candidat *</label>
                                        <select class="form-select" id="candidateName" required>
                                            <option value="">Sélectionnez un candidat</option>
                                            <option value="marie-dubois" selected>Marie Dubois</option>
                                            <option value="pierre-martin">Pierre Martin</option>
                                            <option value="sophie-bernard">Sophie Bernard</option>
                                            <option value="thomas-leroy">Thomas Leroy</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="position" class="form-label">Poste *</label>
                                        <input type="text" class="form-control" id="position"
                                            value="Développeur Frontend" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="startDate" class="form-label">Date de début *</label>
                                        <input type="date" class="form-control" id="startDate" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="trialDuration" class="form-label">Durée de la période
                                            d'essai</label>
                                        <select class="form-select" id="trialDuration">
                                            <option value="1">1 mois</option>
                                            <option value="2" selected>2 mois</option>
                                            <option value="3">3 mois</option>
                                            <option value="4">4 mois</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="salary" class="form-label">Salaire brut mensuel (€)</label>
                                        <input type="number" class="form-control" id="salary" value="3500" min="0"
                                            step="100">
                                    </div>

                                    <div class="mb-3">
                                        <label for="workingHours" class="form-label">Temps de travail</label>
                                        <select class="form-select" id="workingHours">
                                            <option value="35">35h/semaine - Temps plein</option>
                                            <option value="28">28h/semaine - 80%</option>
                                            <option value="21">21h/semaine - 60%</option>
                                            <option value="17.5">17.5h/semaine - 50%</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="contractType" class="form-label">Type de contrat</label>
                                        <select class="form-select" id="contractType">
                                            <option value="cdi">CDI</option>
                                            <option value="cdd">CDD</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="department" class="form-label">Departement</label>
                                        <input type="text" class="form-control" id="department" value="Développement">
                                    </div>

                                    <div class="mb-3">
                                        <label for="manager" class="form-label">Manager direct</label>
                                        <select class="form-select" id="manager">
                                            <option value="jean-dupont">Jean Dupont</option>
                                            <option value="claire-martin">Claire Martin</option>
                                            <option value="paul-durand">Paul Durand</option>
                                        </select>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <button type="button" class="btn btn-primary" onclick="updateContractPreview()">
                                            <i class="bi bi-arrow-clockwise me-1"></i>
                                            Mettre à jour l'aperçu
                                        </button>
                                        <button type="button" class="btn btn-success" onclick="generatePDF()">
                                            <i class="bi bi-file-earmark-pdf me-1"></i>
                                            Exporter en PDF
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-info text-white">
                                <h6 class="card-title mb-0">
                                    <i class="bi bi-lightning me-2"></i>
                                    Actions rapides
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-primary btn-sm">
                                        <i class="bi bi-envelope me-1"></i>
                                        Envoyer au candidat
                                    </button>
                                    <button class="btn btn-outline-info btn-sm">
                                        <i class="bi bi-printer me-1"></i>
                                        Imprimer
                                    </button>
                                    <button class="btn btn-outline-success btn-sm">
                                        <i class="bi bi-check-circle me-1"></i>
                                        Sauvegarder modèle
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Contract Preview -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header text-white" style="background-color: var(--primary-dark);">
                                <h5 class="card-title mb-0">
                                    <i class="bi bi-file-earmark-text me-2"></i>
                                    Aperçu du contrat
                                </h5>
                            </div>
                            <div class="card-body" style="padding: 5% 10%;">
                                <div class="contract-preview">
                                    <div class="contract-header text-center">
                                        <h4>CONTRAT DE TRAVAIL À DURÉE INDÉTERMINÉE<br> AVEC PÉRIODE D'ESSAI</h4>
                                    </div>

                                    <div class="contract-content">
                                        <div class="mb-4">
                                            <h5>ENTRE LES SOUSSIGNÉS :</h5>
                                            <p><strong>L'EMPLOYEUR :</strong></p>
                                            <p style="margin-left: 5%;">
                                                <strong>TalentSphere SARL</strong><br>
                                                Société au capital de 50 000 €<br>
                                                Siège social : 123 Avenue des Technologies<br>
                                                75001 Paris<br>
                                                SIRET : 123 456 789 00012<br>
                                                Code APE : 6201Z<br>
                                                Représentée par M. Jean Dupont, Directeur Général
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <p><strong>LE SALARIÉ :</strong></p>
                                            <p style="margin-left: 5%;">
                                                <strong>Mme Marie DUBOIS</strong><br>
                                                Née le : [Date de naissance]<br>
                                                Domiciliée : [Adresse du salarié]<br>
                                                Nationalité : Française<br>
                                                N° de Sécurité Sociale : [Numéro]
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 1 - ENGAGEMENT</h4>
                                            <p>
                                                L'Employeur engage le Salarié en qualité de <strong>Développeur
                                                    Frontend</strong>
                                                à compter du <strong>[Date de début]</strong>.
                                            </p>
                                            <p>
                                                Le Salarié sera rattaché au departement
                                                <strong>Développement</strong>
                                                sous la responsabilité de <strong>Jean Dupont</strong>.
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 2 - PÉRIODE D'ESSAI</h4>
                                            <p>
                                                Le présent contrat est conclu avec une période d'essai de
                                                <strong>2 mois</strong>,
                                                soit jusqu'au <strong>[Date de fin d'essai]</strong>.
                                            </p>
                                            <p>
                                                Cette période pourra être renouvelée une fois pour une durée
                                                équivalente,
                                                sous réserve d'un accord écrit des deux parties.
                                            </p>
                                            <p>
                                                Pendant cette période, le contrat pourra être rompu par l'une ou
                                                l'autre
                                                des parties sans préavis ni indemnité, sous réserve du respect
                                                d'un délai
                                                de prévenance.
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 3 - FONCTIONS ET MISSIONS</h4>
                                            <p>Le Salarié exercera les fonctions de Développeur Frontend,
                                                notamment :</p>
                                            <ul>
                                                <li>Développement d'interfaces utilisateur avec React et
                                                    TypeScript</li>
                                                <li>Intégration de maquettes et respect des bonnes pratiques
                                                    UX/UI</li>
                                                <li>Maintenance et optimisation du code frontend existant</li>
                                                <li>Collaboration avec l'équipe backend et les designers</li>
                                                <li>Participation aux réunions d'équipe et reporting d'activité
                                                </li>
                                            </ul>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 4 - DURÉE DU TRAVAIL</h4>
                                            <p>
                                                Le Salarié est engagé à temps plein sur la base de <strong>35
                                                    heures</strong>
                                                par semaine, du lundi au vendredi.
                                            </p>
                                            <p>
                                                Les horaires de travail sont fixés de 9h00 à 18h00 avec une
                                                pause déjeuner
                                                d'une heure, sous réserve des nécessités du departement.
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 5 - RÉMUNÉRATION</h4>
                                            <p>
                                                En contrepartie de ses departements, le Salarié percevra une
                                                rémunération
                                                brute mensuelle de <strong>3 500,00 €</strong>, versée le
                                                dernier jour
                                                ouvrable de chaque mois.
                                            </p>
                                            <p>
                                                Cette rémunération s'entend pour un temps plein et sera adaptée
                                                proportionnellement en cas de temps partiel.
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 6 - CONGÉS PAYÉS</h4>
                                            <p>
                                                Le Salarié bénéficiera des congés payés légaux, soit 2,5 jours
                                                ouvrables
                                                par mois de travail effectif, dans les conditions prévues par la
                                                loi
                                                et la convention collective applicable.
                                            </p>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 7 - OBLIGATIONS PROFESSIONNELLES</h4>
                                            <p>Le Salarié s'engage à :</p>
                                            <ul>
                                                <li>Respecter le règlement intérieur de l'entreprise</li>
                                                <li>Maintenir la confidentialité sur les informations de
                                                    l'entreprise</li>
                                                <li>Ne pas faire concurrence à l'employeur pendant la durée du
                                                    contrat</li>
                                                <li>Signaler tout changement de situation personnelle</li>
                                            </ul>
                                        </div>

                                        <div class="mb-4">
                                            <h4>ARTICLE 8 - DISPOSITIONS GÉNÉRALES</h4>
                                            <p>
                                                Le présent contrat est soumis aux dispositions du Code du
                                                travail
                                                et de la Convention Collective Nationale de la Métallurgie.
                                            </p>
                                            <p>
                                                Toute modification du présent contrat devra faire l'objet d'un
                                                avenant écrit.
                                            </p>
                                        </div>
                                    </div>

                                    <div class="contract-signature mt-5">
                                        <div class="row">
                                            <div class="col-6">
                                                <p><strong>L'Employeur</strong></p>
                                                <p>Fait à Paris</p>
                                                <p>Le : _______________</p>
                                                <br><br>
                                                <p>Signature :</p>
                                                <br><br><br>
                                                <p>Jean DUPONT<br>Directeur Général</p>
                                            </div>
                                            <div class="col-6">
                                                <p><strong>Le Salarié</strong></p>
                                                <p>Lu et approuvé</p>
                                                <p>Le : _______________</p>
                                                <br><br>
                                                <p>Signature :</p>
                                                <br><br><br>
                                                <p>Marie DUBOIS</p>
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
    <script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>
    <script>
        const currentUser = {
            name: "<%= session.getAttribute("nom") %> <%= session.getAttribute("prenom") %>",
            initials: "<%= session.getAttribute("nom") != null && session.getAttribute("prenom") != null ? 
                        session.getAttribute("nom").substring(0,1).toUpperCase() + session.getAttribute("prenom").substring(0,1).toUpperCase() 
                        : "" %>",
            avatar: "<%= session.getAttribute("avatarColor")%>",
            id: "<%= session.getAttribute("id_utilisateur") %>",
            poste: "<%= session.getAttribute("poste") %>"
        };
    </script>
<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>

</html>