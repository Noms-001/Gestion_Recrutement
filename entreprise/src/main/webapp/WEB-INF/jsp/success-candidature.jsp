<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidature envoyée - TalentSphere</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/error.css" rel="stylesheet">
</head>
<body>
    <div class="success-page">
        <div class="container-fluid h-100">
            <div class="row h-100 align-items-center justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="success-card">
                        <div class="success-icon">
                            <i class="bi bi-check" style="font-size: 70px;"></i>
                        </div>
                        <h3 class="success-title fs-2">Candidature <br/>envoyée !</h3>
                        <p class="success-message">Votre candidature a été enregistrée avec succès.</p>
                         <%
                            Long testId = (Long) request.getAttribute("testId");
                            Long annonceId = (Long) request.getAttribute("annonceId");
                        %>
                        <form class="success-actions" action="/online-test?testId=<%= testId %>&annonceId=<%= annonceId %>" method="post">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-pencil-alt me-2"></i>Passer le test
                            </button>
                            <a href="javascript:history.back()" class="btn btn-outline-primary btn-lg">
                                <i class="bi bi-arrow-left me-2"></i>Go Back
                            </a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
