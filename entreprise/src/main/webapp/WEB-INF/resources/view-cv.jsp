<!doctype html>
<html lang="fr">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Modèle CV — Clean (avec photo)</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #1ca3a3;
            --primary-dark: #0e6470;
            --muted: #6c757d;
            --bg: #f7fafc;
            --card: #ffffff;
            --accent: #0d3b56;
            --gap: 18px;
            font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
        }

        body {
            background: var(--bg);
            padding: 24px;
            color: #222;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* CV A4 */
        .cv-frame {
            width: 210mm;
            height: 297mm;
            background: var(--card);
            overflow: hidden;
            display: flex;
            flex-direction: row;
            box-shadow: 0 8px 30px rgba(13, 59, 86, 0.08);
        }


        .cv-row {
            display: flex;
            flex-wrap: nowrap;
            width: 100%
        }

        .cv-left {
            width: 280px;
            background: linear-gradient(180deg, var(--primary), var(--primary-dark));
            color: #fff;
            padding: 28px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 14px
        }

        .photo-wrap {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            /* photo ronde */
            overflow: hidden;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.12);
            border: 4px solid rgba(255, 255, 255, 0.12);
            margin-bottom: 12px;
        }

        .photo-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block
        }

        .name {
            font-size: 1.25rem;
            font-weight: 700;
            text-align: center;
            margin: 0
        }

        .role {
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.9);
            text-align: center;
            margin: 0
        }

        .contact,
        .skills,
        .languages {
            background: transparent;
            width: 100%;
        }

        .section-title {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: rgba(255, 255, 255, 0.85);
            margin-bottom: 6px
        }

        .contact p,
        .skill-item {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.95);
            margin: 0
        }


        .skill-list {
            display: flex;
            flex-direction: column;
            gap: 8px
        }

        .skill-pill {
            background: rgba(255, 255, 255, 0.12);
            padding: 6px 8px;
            border-radius: 999px;
            font-size: 0.85rem;
            display: inline-block
        }

        .cv-right {
            flex: 1;
            padding: 28px 28px 32px 28px
        }

        .summary {
            font-size: 0.95rem;
            color: var(--muted);
            margin-bottom: 12px
        }

        .block {
            margin-bottom: 18px
        }

        .job-title {
            font-weight: 700;
            color: var(--accent)
        }

        .job-meta {
            font-size: 0.85rem;
            color: var(--muted);
        }

        .edu-item {
            font-size: 0.95rem
        }

        .download-btn {
            background: var(--primary);
            border: none;
            color: #fff
        }

        /* bouton en haut à droite absolu */
        .download-wrapper {
            width: 210mm;
            display: flex;
            justify-content: flex-end;
            margin-bottom: 8px;
        }

        /* responsive écran */
        @media(max-width:900px) {
            .cv-frame {
                width: 100%;
                height: auto;
                flex-direction: column;
            }

            .cv-left {
                width: 100%;
                flex-direction: column;
                align-items: center;
                padding: 18px;
            }

            .cv-right {
                padding: 18px;
            }

            .download-wrapper {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="download-wrapper">
        <button class="btn btn-sm download-btn" id="downloadPdf">
            <i class="bi bi-download me-1"></i> Télécharger PDF
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
                    <p id="cvEmail"><i class="bi bi-envelope me-2"></i>email@example.com</p>
                    <p id="cvPhone"><i class="bi bi-telephone me-2"></i>+33 6 12 34 56 78</p>
                    <p id="cvLocation"><i class="bi bi-geo-alt me-2"></i>Paris, France</p>
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.3/html2pdf.bundle.min.js"></script>
    <script>
        
        const sampleCV = {
            photo: 'img/logo.png',
            prenom: 'Alice',
            nom: 'Dupont',
            role: 'Développeuse Frontend',
            email: 'alice.dupont@example.com',
            phone: '+33 6 12 34 56 78',
            location: 'Paris, France',
            summary: 'Développeuse passionnée avec 4 ans d\'expérience en front-end, spécialisée React et UX.',
            skills: ['JavaScript', 'React', 'TypeScript', 'CSS', 'HTML'],
            languages: ['Français', 'Anglais'],
            experiences: [
                { company: 'Startup X', title: 'Frontend Developer', period: '2021 - Présent', desc: 'Conception et développement d\'applications React.' },
                { company: 'Agence Y', title: 'Développeuse Web', period: '2019 - 2021', desc: 'Intégration front-end et optimisation performances.' }
            ],
            education: [
                { school: 'Université Z', degree: 'Master Informatique', period: '2016 - 2019' }
            ]
        };

        function renderFromJson(data) {
            document.getElementById('cvPhoto').src = data.photo || '';
            document.getElementById('cvName').textContent = (data.prenom ? data.prenom + ' ' : '') + (data.nom || '');
            document.getElementById('cvRole').textContent = data.role || '';
            document.getElementById('cvEmail').innerHTML = '<i class="bi bi-envelope me-2"></i>' + (data.email || '');
            document.getElementById('cvPhone').innerHTML = '<i class="bi bi-telephone me-2"></i>' + (data.phone || '');
            document.getElementById('cvLocation').innerHTML = '<i class="bi bi-geo-alt me-2"></i>' + (data.location || '');
            document.getElementById('cvSummary').textContent = data.summary || '';

            const skillsEl = document.getElementById('cvSkills'); skillsEl.innerHTML = '';
            (data.skills || []).forEach(s => { const sp = document.createElement('span'); sp.className = 'skill-pill'; sp.textContent = s; skillsEl.appendChild(sp); });

            const langsEl = document.getElementById('cvLangs'); langsEl.innerHTML = '';
            (data.languages || []).forEach(l => { const sp = document.createElement('span'); sp.className = 'skill-pill'; sp.textContent = l; langsEl.appendChild(sp); });

            const expEl = document.getElementById('cvExperience'); expEl.innerHTML = '';
            (data.experiences || []).forEach(e => {
                const div = document.createElement('div');
                div.style.marginBottom = '12px';
                div.innerHTML = `<strong>${e.title} — ${e.company}</strong><div class="job-meta">${e.period}</div><p style="margin:6px 0 0 0;color:var(--muted)">${e.desc}</p>`;
                expEl.appendChild(div);
            });

            const eduEl = document.getElementById('cvEducation'); eduEl.innerHTML = '';
            (data.education || []).forEach(ed => { const d = document.createElement('div'); d.className = 'edu-item'; d.innerHTML = `<strong>${ed.degree}</strong><div class="job-meta">${ed.school} — ${ed.period || ''}</div>`; eduEl.appendChild(d); });

        }

        document.getElementById('downloadPdf').addEventListener('click', () => {
        });


        renderFromJson(sampleCV);
    </script>
</body>

</html>