function openJobDetails(jobId) {
    document.querySelectorAll('.job-card').forEach(card => {
        const btnDetail = card.querySelector('.btn-detailler');
        const btnPostuler = card.querySelector('.btn-postuler');

        // Sauvegarder le texte original si pas déjà fait
        if (btnDetail && !btnDetail.dataset.originalText) {
            btnDetail.dataset.originalText = btnDetail.innerHTML;
        }
        if (btnPostuler && !btnPostuler.dataset.originalText) {
            btnPostuler.dataset.originalText = btnPostuler.innerHTML;
        }

        // Effacer le texte, garder les icônes
        if (btnDetail) {
            btnDetail.innerHTML = '<i class="bi bi-eye"></i>';
        }
        if (btnPostuler) {
            btnPostuler.innerHTML = '<i class="bi bi-send"></i>';
        }

        // Ajouter une classe pour le style réduit
        if (btnDetail) btnDetail.classList.add('btn-compact');
        if (btnPostuler) btnPostuler.classList.add('btn-compact');
    });


    fetch('/api/annonces/' + jobId)
        .then(response => {
            if (!response.ok) {
                throw new Error('Annonce non trouvée');
            }
            return response.json();
        })
        .then(job => {
            document.getElementById("jobDetailsTitle").textContent = job.posteLibelle;

            let detailsContent = `
                <p class="fw-bold">${job.departementNom} • ${job.villeNom}</p>
                <p>${job.description}</p>
                
                <div class="row mt-4">
                    <div class="col-md-12">
                        <h6 class="fw-bold">Critères</h6>
                        <ul class="list-unstyled">
            `;

            // Diplôme
            if (job.diplomeLibelle) {
                const obligatoire = job.diplomeObligatoire ? ' <span class="text-danger">*</span>' : '';
                const niveau = job.diplomeNiveau ? ` (Niveau ${job.diplomeNiveau})` : '';
                detailsContent += `<li><i class="bi bi-award text-warning me-2"></i>${job.diplomeLibelle}${niveau}${obligatoire}</li>`;
            }

            // Expérience
            if (job.anneeExperience) {
                const obligatoire = job.experienceObligatoire ? ' <span class="text-danger">*</span>' : '';
                detailsContent += `<li><i class="bi bi-check-circle text-success me-2"></i>${job.anneeExperience} an(s) d'expérience${obligatoire}</li>`;
            }

            // Âge
            if (job.ageMinimum) {
                const obligatoire = job.ageObligatoire ? ' <span class="text-danger">*</span>' : '';
                detailsContent += `<li><i class="bi bi-person text-info me-2"></i>Âge minimum: ${job.ageMinimum} ans${obligatoire}</li>`;
            }

            // Genre
            if (job.genreLibelle && job.genreObligatoire) {
                detailsContent += `<li><i class="bi bi-gender-ambiguous text-secondary me-2"></i>Genre: ${job.genreLibelle} <span class="text-danger">*</span></li>`;
            }

            // Ville
            if (job.villeNom && job.villeObligatoire) {
                detailsContent += `<li><i class="bi bi-geo-alt text-danger me-2"></i>Localisation: ${job.villeNom} <span class="text-danger">*</span></li>`;
            }

            // Date limite
            if (job.dateLimite) {
                detailsContent += `<li><i class="bi bi-calendar-check text-primary me-2"></i>Date limite: ${new Date(job.dateLimite).toLocaleDateString()}</li>`;
            }

            detailsContent += `
                        </ul>
                        ${hasObligatoires(job) ? '<small class="text-muted"><span class="text-danger">*</span> Critère obligatoire</small>' : ''}
                    </div>
                </div>
            `;

            // Compétences obligatoires
            if (job.competencesObligatoires && job.competencesObligatoires.length > 0) {
                detailsContent += `
                    <h6 class="fw-bold mt-4">Compétences requises <span class="text-danger">*</span></h6>
                    <div class="d-flex flex-wrap gap-2 mb-3">
                        ${job.competencesObligatoires.map(c => `<span class="badge bg-danger">${c}</span>`).join('')}
                    </div>
                `;
            }

            // Compétences optionnelles
            if (job.competences && job.competences.length > 0) {
                const competencesOptionnelles = job.competencesObligatoires ?
                    job.competences.filter(c => !job.competencesObligatoires.includes(c)) :
                    job.competences;

                if (competencesOptionnelles.length > 0) {
                    detailsContent += `
                        <h6 class="fw-bold mt-3">Compétences appréciées</h6>
                        <div class="d-flex flex-wrap gap-2 mb-3">
                            ${competencesOptionnelles.map(c => `<span class="badge bg-primary">${c}</span>`).join('')}
                        </div>
                    `;
                }
            }

            // Langues obligatoires
            if (job.languesObligatoires && job.languesObligatoires.length > 0) {
                detailsContent += `
                    <h6 class="fw-bold mt-4">Langues requises <span class="text-danger">*</span></h6>
                    <div class="d-flex flex-wrap gap-2 mb-3">
                        ${job.languesObligatoires.map(l => `<span class="badge bg-danger">${l}</span>`).join('')}
                    </div>
                `;
            }

            // Langues optionnelles
            if (job.langues && job.langues.length > 0) {
                const languesOptionnelles = job.languesObligatoires ?
                    job.langues.filter(l => !job.languesObligatoires.includes(l)) :
                    job.langues;

                if (languesOptionnelles.length > 0) {
                    detailsContent += `
                        <h6 class="fw-bold mt-3">Langues appréciées</h6>
                        <div class="d-flex flex-wrap gap-2">
                            ${languesOptionnelles.map(l => `<span class="badge bg-info">${l}</span>`).join('')}
                        </div>
                    `;
                }
            }

            document.getElementById("jobDetailsContent").innerHTML = detailsContent;

            // Animation (garder votre code existant)
            const jobsContainer = document.getElementById("jobsContainer");
            const jobDetails = document.getElementById("jobDetailsPanel");

            jobsContainer.classList.add("shrink");
            jobDetails.classList.remove("d-none");

            setTimeout(() => {
                jobDetails.classList.add("open");

                // Effacer le texte mais garder les icônes
                btnDetail.innerHTML = '<i class="bi bi-eye"></i>';
                btnPostuler.innerHTML = '<i class="bi bi-send"></i>';
            }, 10);
        })
        .catch(error => {
            console.error('Erreur:', error);
            showToast("danger", "Erreur lors du chargement des détails de l'annonce");
        });
}

// Fonction utilitaire pour vérifier s'il y a des critères obligatoires
function hasObligatoires(job) {
    return (job.diplomeObligatoire && job.diplomeLibelle) ||
        (job.ageObligatoire && job.ageMinimum) ||
        (job.experienceObligatoire && job.anneeExperience) ||
        (job.genreObligatoire && job.genreLibelle) ||
        (job.villeObligatoire && job.villeNom) ||
        (job.competencesObligatoires && job.competencesObligatoires.length > 0) ||
        (job.languesObligatoires && job.languesObligatoires.length > 0);
}

// Fonction pour fermer les détails
function closeJobDetails() {
    const jobsContainer = document.getElementById("jobsContainer");
    const jobDetails = document.getElementById("jobDetailsPanel");

    jobDetails.classList.remove("open");
    jobsContainer.classList.remove("shrink");

    document.querySelectorAll('.btn-detailler').forEach(btn => {
        if (btn.dataset.originalText) {
            btn.innerHTML = btn.dataset.originalText;
            btn.classList.remove('btn-compact');
        }
    });

    document.querySelectorAll('.btn-postuler').forEach(btn => {
        if (btn.dataset.originalText) {
            btn.innerHTML = btn.dataset.originalText;
            btn.classList.remove('btn-compact');
        }
    });
    setTimeout(() => {
        jobDetails.classList.add("d-none");

    }, 400);
}

function formatTimeSinceSimple(dateString) {
    if (!dateString) return "Date non disponible";

    const dateCreation = new Date(dateString);
    const now = new Date();
    const diffTime = Math.abs(now - dateCreation);
    const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays === 0) {
        return "Publié aujourd'hui";
    } else if (diffDays === 1) {
        return "Publié il y a 1 jour";
    } else {
        return `Publié il y a ${diffDays} jours`;
    }
}

function updateAllTimestamps() {
    document.querySelectorAll('.date-creation').forEach(element => {
        const dateString = element.getAttribute('data-date-creation');
        if (dateString) {
            element.textContent = formatTimeSinceSimple(dateString);
        }
    });
}

// Mettre à jour périodiquement (toutes les minutes)
function startTimestampUpdates() {
    // Mise à jour initiale
    updateAllTimestamps();

    // Mise à jour toutes les minutes
    setInterval(updateAllTimestamps, 60000);
}

document.addEventListener("DOMContentLoaded", () => {
    const jobsList = document.querySelectorAll(".job-card");
    const pagination = document.querySelector(".pagination");
    const itemsPerPage = 5; // jobs par page
    let currentPage = 1;
    const totalPages = Math.ceil(jobsList.length / itemsPerPage);

    // Générer dynamiquement les numéros de page
    function generatePagination() {
        pagination.innerHTML = '';

        // Précédent
        const prevLi = document.createElement('li');
        prevLi.className = 'page-item disabled';
        prevLi.innerHTML = `<a class="page-link" href="#" tabindex="-1">Précédent</a>`;
        pagination.appendChild(prevLi);

        // Numéros de pages
        for (let i = 1; i <= totalPages; i++) {
            const li = document.createElement('li');
            li.className = 'page-item';
            li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
            li.querySelector('a').addEventListener('click', (e) => {
                e.preventDefault();
                showPage(i);
            });
            pagination.appendChild(li);
        }

        // Suivant
        const nextLi = document.createElement('li');
        nextLi.className = 'page-item';
        nextLi.innerHTML = `<a class="page-link" href="#">Suivant</a>`;
        pagination.appendChild(nextLi);

        // Clic Précédent
        prevLi.querySelector('a').addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage > 1) showPage(currentPage - 1);
        });

        // Clic Suivant
        nextLi.querySelector('a').addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage < totalPages) showPage(currentPage + 1);
        });
    }

    // Afficher les jobs d'une page
    function showPage(page) {
        currentPage = page;
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        jobsList.forEach((job, index) => {
            job.style.display = (index >= start && index < end) ? "block" : "none";
        });

        // Mettre à jour les classes actives et boutons
        updatePagination();
    }

    function updatePagination() {
        const pageItems = pagination.querySelectorAll('.page-item');
        pageItems.forEach((li, idx) => {
            if (idx === 0) li.classList.toggle('disabled', currentPage === 1); // Précédent
            else if (idx === pageItems.length - 1) li.classList.toggle('disabled', currentPage === totalPages); // Suivant
            else li.classList.toggle('active', idx === currentPage); // numéros
        });
    }

    generatePagination();
    showPage(1);

    startTimestampUpdates();
});

const experienceRange = document.getElementById("experienceFilter");
const experienceValue = document.getElementById("experienceValue");

function updateExperienceLabel() {
    let val = parseInt(experienceRange.value);
    if (val === 0) {
        experienceValue.textContent = "0 an";
    } else if (val === 10) {
        experienceValue.textContent = "10+ ans";
    } else {
        experienceValue.textContent = val + " ans";
    }
}

// Initialiser + écouter changements
updateExperienceLabel();
experienceRange.addEventListener("input", updateExperienceLabel);