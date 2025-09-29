<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TalentSphere - Tableau de bord</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/logo.png">
</head>

<body>
    <div id="navbar-placeholder"></div>

    <div class="d-flex">
        <div id="sidebar-placeholder"></div>

        <main class="main-content flex-grow-1">
            <div class="row container-fluid px-4 py-4">
                <div class="side col-md-4">
                    <h5 id="date">Entretiens du jour</h5>
                    <div id="events-list">
                        <p style="color: rgb(119, 160, 206); ">Sélectionnez une date pour voir les entretiens.</p>
                    </div>
                </div>
                <div class="calendar col-md-8">
                    <div class="calendar-header">
                        <button id="prevMonth" class="btn btn-outline-secondary">&lt;</button>
                        <h4 id="monthYear"></h4>
                        <button id="nextMonth" class="btn btn-outline-secondary">&gt;</button>
                    </div>
                    <div class="calendar-days" id="calendarDays">
                        <!-- Jours générés par JS -->
                    </div>
                </div>
            </div>


        </main>
    </div>

        <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/planning.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
        <script>
            loadNavbar();
            loadSidebar();
        </script>
</body>

</html>