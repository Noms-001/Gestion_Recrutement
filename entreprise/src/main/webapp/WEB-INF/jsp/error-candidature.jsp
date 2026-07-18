<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur de candidature - TalentSphere</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/error.css" rel="stylesheet">
</head>
<body>
    <div class="d-flex error-page">
        <div class="container-fluid h-100">
            <div class="row h-100 align-items-center justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="error-card">
                        <div class="error-icon">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                        <h3 class="error-title fs-2">Candidature <br/> refusée!</h3>
                        <p class="error-message fs-6">Malheureusement, votre profil ne correspond pas aux exigences de cette offre.</p>
                        <div class="error-actions">
                            <a href="/job-listings" class="btn btn-primary btn-lg">
                                <i class="bi bi-arrow-left me-2"></i>Retour aux annonces
                            </a>
                            <a href="/cv-submission" class="btn btn-outline-primary btn-lg">
                                <i class="bi bi-pencil me-2"></i>Compléter mon CV
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>

    <script>
        const error = "<%= request.getAttribute("errorMessage") %>";
        console.log(error);
        if(error != 'null' && error != null && error != '') {
            setTimeout(() => {
                showToast('danger', error);
            }, 1000);
        }
    </script>
</body>
</html>
