<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Erreur de candidature - TalentSphere</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div id="navbar-placeholder"></div>
    
    <div class="d-flex">
        <div id="sidebar-placeholder"></div>
        
        <main class="main-content flex-grow-1">
            <div class="container-fluid px-4 py-4">
                <div class="d-flex justify-content-center align-items-center" style="min-height: 70vh;">
                    <div class="card border-danger" style="max-width: 500px;">
                        <div class="card-body text-center">
                            <div class="text-danger mb-3">
                                <i class="bi bi-x-circle-fill" style="font-size: 4rem;"></i>
                            </div>
                            <h3 class="card-title text-danger mb-3">Candidature non acceptée</h3>
                            
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger mb-4">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            
                            <p class="card-text mb-4 text-muted">
                                Votre profil ne correspond pas aux critères requis pour cette annonce.
                            </p>
                            
                            <div class="d-flex gap-2 justify-content-center">
                                <a href="/job-listings" class="btn btn-primary">
                                    <i class="bi bi-arrow-left me-2"></i>Retour aux annonces
                                </a>
                                <a href="/cv-submission" class="btn btn-outline-secondary">
                                    <i class="bi bi-pencil me-2"></i>Compléter mon CV
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