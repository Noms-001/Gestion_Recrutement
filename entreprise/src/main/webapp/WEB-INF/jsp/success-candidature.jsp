<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Candidature envoyée - TalentSphere</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .success-container {
            min-height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .success-card {
            max-width: 500px;
            text-align: center;
            padding: 2rem;
        }
    </style>
</head>
<body>
    <div id="navbar-placeholder"></div>
    
    <div class="d-flex">
        <div id="sidebar-placeholder"></div>
        
        <main class="main-content flex-grow-1">
            <div class="container-fluid px-4 py-4">
                <div class="success-container">
                    <div class="card success-card border-success">
                        <div class="card-body">
                            <div class="text-success mb-3">
                                <i class="bi bi-check-circle-fill" style="font-size: 4rem;"></i>
                            </div>
                            <h3 class="card-title text-success mb-3">Candidature envoyée avec succès !</h3>
                            <p class="card-text mb-4">
                                Votre candidature a été enregistrée avec succès. 
                                Vous allez maintenant passer le test de sélection.
                            </p>
                            
                            <c:if test="${not empty testId}">
                                <div class="alert alert-info mb-4">
                                    <strong>Test ID :</strong> ${testId}
                                </div>
                            </c:if>
                            
                            <div class="d-flex gap-2 justify-content-center">
                                <a href="/online-test?testId=${testId}&annonceId=${annonceId}" class="btn btn-primary btn-lg">
                                    <i class="bi bi-pencil-square me-2"></i>Passer le test
                                </a>
                                <a href="/job-listings" class="btn btn-outline-secondary btn-lg">
                                    <i class="bi bi-list-ul me-2"></i>Voir les annonces
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
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
</body>
</html>