<%@ page session="true" %>
<% if(session.getAttribute("id_utilisateur") == null) {
    response.sendRedirect("/");
} %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Modèle CV — Clean (avec photo)</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cv.css">
</head>

<body>
    <div class="download-wrapper d-flex">
        <a href="${pageContext.request.contextPath}/cv-submission" style="color: var(--muted)">
            <i class="bi bi-arrow-left  fs-1" style="font-size:2.5rem; -webkit-text-stroke:1px;"></i>
        </a>

        <button class="btn btn-sm download-btn" id="downloadPdf">
            <i class="bi bi-file-earmark-pdf-fill me-1"></i> Télécharger PDF
        </button>
    </div>

    <div class="cv-frame" id="cvFrame">
        <div class="cv-row">
            <aside class="cv-left">
                <div class="photo-wrap" id="photoWrap"><img id="cvPhoto" alt="photo"></div>
                <div class="name" id="cvName">Prénom Nom</div>
                <div class="role" id="cvRole">Titre / Poste</div>

                <div class="contact mt-3">
                    <div class="section-title">Contact</div>
                    <p id="cvEmail" class="mb-1"><i class="bi bi-envelope me-2"></i>email@example.com</p>
                    <p id="cvPhone" class="mb-1"><i class="bi bi-telephone me-2"></i>+33 6 12 34 56 78</p>
                    <p id="cvLocation" class="mb-1"><i class="bi bi-geo-alt me-2"></i>Paris, France</p>
                </div>

                <div class="skills mt-3">
                    <div class="section-title">Compétences</div>
                    <div class="skill-list" id="cvSkills">
                        <span class="skill-pill">JavaScript</span>
                        <span class="skill-pill">React</span>
                        <span class="skill-pill">CSS</span>
                    </div>
                </div>

                <div class="languages mt-3">
                    <div class="section-title">Langues</div>
                    <div id="cvLangs">
                        <span class="skill-pill">Français (Natif)</span>
                    </div>
                </div>
            </aside>

            <section class="cv-right">
                <h4 style="margin:0" id="cvTitle">Profil</h4>
                <div class="summary" id="cvSummary">Brève description professionnelle, points forts et objectif.</div>

                <div class="block" id="experienceBlock">
                    <h5 class="job-title">Expériences</h5>
                    <div id="cvExperience"></div>
                </div>

                <div class="block" id="educationBlock">
                    <h5 class="job-title">Formation</h5>
                    <div id="cvEducation"></div>
                </div>
            </section>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/html2canvas.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap/jspdf.umd.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>
    <script>
        const utilisateurId = "<%= session.getAttribute("id_utilisateur") %>"
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/show-cv.js"></script>
</body>

</html>