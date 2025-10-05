<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success - HR Portal</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="success-page">
        <div class="container-fluid h-100">
            <div class="row h-100 align-items-center justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="success-card">
                        <div class="success-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h1 class="success-title">Success!</h1>
                        <p class="success-message">Your action has been completed successfully.</p>
                        <div class="success-actions">
                            <a href="/online-test" class="btn btn-primary btn-lg">
                                <i class="fas fa-home me-2"></i>Passer le test
                            </a>
                            <a href="javascript:history.back()" class="btn btn-outline-primary btn-lg">
                                <i class="fas fa-arrow-left me-2"></i>Go Back
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>