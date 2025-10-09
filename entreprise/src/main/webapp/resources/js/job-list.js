// job-list.js - VERSION FUSIONNÉE COMPLÈTE
document.addEventListener("DOMContentLoaded", function() {
    initializeFilters();
    initializeSearch();
    initializePagination();
    startTimestampUpdates();
});

// Variables globales
let currentFilters = {
    villes: [],
    diplome: '',
    experience: 0,
    competences: [],
    langues: []
};

// === VOS FONCTIONS EXISTANTES ===
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
                <p class="fw-bold">
                    <i class="bi bi-building"></i> ${job.departementNom} • ${job.villeNom} </br>
                    <small><i class="bi bi-mortarboard"></i> ${job.filiereLibelle}</small>
                </p>
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
                        <h6 class="fw-bold mt-3">Autres</h6>
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
                        <h6 class="fw-bold mt-3">Autres</h6>
                        <div class="d-flex flex-wrap gap-2">
                            ${languesOptionnelles.map(l => `<span class="badge bg-info">${l}</span>`).join('')}
                        </div>
                    `;
                }
            }

            document.getElementById("jobDetailsContent").innerHTML = detailsContent;

            // Animation
            const jobsContainer = document.getElementById("jobsContainer");
            const jobDetails = document.getElementById("jobDetailsPanel");

            jobsContainer.classList.add("shrink");
            jobDetails.classList.remove("d-none");

            setTimeout(() => {
                jobDetails.classList.add("open");
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

// === NOUVELLES FONCTIONS POUR FILTRES ET RECHERCHE ===

// Initialisation des filtres
function initializeFilters() {
    initializeCityFilter();
    initializeDiplomeFilter();
    initializeExperienceFilter();
    initializeSkillsFilter();
    initializeLangsFilter();
    initializeUrgentFilter();
    
    // Événement pour appliquer les filtres
    const form = document.getElementById('form');
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        applyFilters();
    });
    
    // Événement pour réinitialiser
    document.querySelector('button[type="reset"]').addEventListener('click', function() {
        resetFilters();
    });
}

// Filtre Ville
function initializeCityFilter() {
    const citySelect = document.getElementById('cityFilter');
    const cityTags = document.getElementById('cityTags');
    
    citySelect.addEventListener('change', function() {
        if (this.value && !currentFilters.villes.includes(this.value)) {
            addFilterTag('villes', this.value, this.options[this.selectedIndex].text, cityTags);
            this.value = '';
        }
    });
}

// Filtre Diplôme
function initializeDiplomeFilter() {
    const diplomeSelect = document.getElementById('diplomeFilter');
    
    diplomeSelect.addEventListener('change', function() {
        currentFilters.diplome = this.value;
    });
}

// Filtre Expérience
function initializeExperienceFilter() {
    const experienceRange = document.getElementById('experienceFilter');
    const experienceValue = document.getElementById('experienceValue');
    
    function updateExperienceLabel() {
        let val = parseInt(experienceRange.value);
        if (val === 0) {
            experienceValue.textContent = "0 an";
        } else if (val === 10) {
            experienceValue.textContent = "10+ ans";
        } else {
            experienceValue.textContent = val + " ans";
        }
        currentFilters.experience = val;
    }
    
    updateExperienceLabel();
    experienceRange.addEventListener("input", updateExperienceLabel);
}

// Filtre Compétences
function initializeSkillsFilter() {
    const skillsSelect = document.getElementById('skillsFilter');
    const skillsTags = document.getElementById('skillsTags');
    
    skillsSelect.addEventListener('change', function() {
        if (this.value && !currentFilters.competences.includes(this.value)) {
            addFilterTag('competences', this.value, this.options[this.selectedIndex].text, skillsTags);
            this.value = '';
        }
    });
}

function initializeUrgentFilter() {
    const urgentFilter = document.getElementById('urgentFilter');
    
    urgentFilter.addEventListener('change', function() {
        currentFilters.urgent = this.checked;
    });
}

// Filtre Langues
function initializeLangsFilter() {
    const langsSelect = document.getElementById('langsFilter');
    const langsTags = document.getElementById('langsTags');
    
    langsSelect.addEventListener('change', function() {
        if (this.value && !currentFilters.langues.includes(this.value)) {
            addFilterTag('langues', this.value, this.options[this.selectedIndex].text, langsTags);
            this.value = '';
        }
    });
}

// Ajouter un tag de filtre
function addFilterTag(type, value, text, container) {
    const tag = document.createElement('span');
    tag.className = 'badge bg-primary me-2 mb-2 d-inline-flex align-items-center';
    tag.innerHTML = `
        ${text}
        <button type="button" class="btn-close btn-close-white ms-2" style="font-size: 0.7rem;" 
                onclick="removeFilterTag('${type}', '${value}', this)"></button>
        <input type="hidden" name="${type}[]" value="${value}">
    `;
    container.appendChild(tag);
    
    currentFilters[type].push(value);
}

// Supprimer un tag de filtre
function removeFilterTag(type, value, button) {
    const tag = button.closest('.badge');
    tag.remove();
    
    currentFilters[type] = currentFilters[type].filter(item => item !== value);
}

// Réinitialiser tous les filtres
function resetFilters() {
    // Réinitialiser les données
    currentFilters = {
        villes: [],
        diplome: '',
        experience: 0,
        competences: [],
        langues: [],
        urgent: false
    };
    
    // Réinitialiser l'UI
    document.querySelectorAll('#cityTags, #skillsTags, #langsTags').forEach(container => {
        container.innerHTML = '';
    });
    
    document.getElementById('diplomeFilter').value = '';
    document.getElementById('experienceFilter').value = 2;
    document.getElementById('experienceValue').textContent = '2 ans';
    document.getElementById('urgentFilter').checked = false;
    
    // Réappliquer les filtres (pour tout réafficher)
    applyFilters();
    
    // Fermer l'offcanvas
    const offcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('filtersOffcanvas'));
    if (offcanvas) {
        offcanvas.hide();
    }
}

// Appliquer les filtres
function applyFilters() {
    const url = buildFilterUrl();
    
    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur lors du filtrage');
            }
            return response.json();
        })
        .then(annonces => {
            updateJobsList(annonces);
            showToast('success', 'Filtres appliqués avec succès');
            
            // Fermer l'offcanvas
            const offcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('filtersOffcanvas'));
            if (offcanvas) {
                offcanvas.hide();
            }
        })
        .catch(error => {
            console.error('Erreur:', error);
            showToast('danger', 'Erreur lors de l\'application des filtres');
        });
}

// Construire l'URL de filtrage
function buildFilterUrl() {
    let url = '/api/annonces/filter?';
    const params = [];
    
    // Ville
    if (currentFilters.villes.length > 0) {
        params.push(`villes=${currentFilters.villes.join(',')}`);
    }
    
    // Diplôme
    if (currentFilters.diplome) {
        params.push(`diplome=${currentFilters.diplome}`);
    }
    
    // Expérience
    if (currentFilters.experience > 0) {
        params.push(`experience=${currentFilters.experience}`);
    }
    
    // Compétences
    if (currentFilters.competences.length > 0) {
        params.push(`competences=${currentFilters.competences.join(',')}`);
    }
    
    // Langues
    if (currentFilters.langues.length > 0) {
        params.push(`langues=${currentFilters.langues.join(',')}`);
    }

    if (currentFilters.urgent) {
        params.push(`urgent=true`);
    }

    console.log(url + params.join('&'));
    
    return url + params.join('&');
}

// Initialisation de la recherche
function initializeSearch() {
    const searchInput = document.querySelector('input[type="text"]');
    const searchButton = document.querySelector('.btn-primary');
    
    // Recherche avec le bouton
    searchButton.addEventListener('click', function() {
        performSearch(searchInput.value);
    });
    
    // Recherche avec Enter
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch(this.value);
        }
    });
}

// Effectuer la recherche
function performSearch(query) {
    const url = `/api/annonces/search?q=${encodeURIComponent(query)}`;
    
    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur lors de la recherche');
            }
            return response.json();
        })
        .then(annonces => {
            updateJobsList(annonces);
            if (query) {
                showToast('success', `${annonces.length} annonce(s) trouvée(s)`);
            }
        })
        .catch(error => {
            console.error('Erreur:', error);
            showToast('danger', 'Erreur lors de la recherche');
        });
}

// Mettre à jour la liste des annonces
function updateJobsList(annonces) {
    const jobsList = document.getElementById('jobsList');
    
    if (annonces.length === 0) {
        jobsList.innerHTML = `
            <div class="alert alert-info">
                Aucune annonce ne correspond à vos critères.
            </div>
        `;
        return;
    }
    
    jobsList.innerHTML = annonces.map(annonce => `
        <div class="card mb-3 job-card" data-job-id="${annonce.id}">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <div class="d-flex align-items-start">
                            <div class="company-logo me-3">
                                <div class="bg-primary text-white rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                    <i class="bi bi-building"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="card-title mb-1">${annonce.posteLibelle || 'Poste non spécifié'}</h5>
                                <p class="text-muted mb-2">${annonce.urgent ? '<i class="bi bi-exclamation-triangle me-1 text-danger"></i>' : ''} ${annonce.departementNom || ''} • ${annonce.villeNom || 'Lieu non spécifié'}</p>
                                <p class="card-text mb-3">
                                    ${(annonce.description || '').substring(0, 150)}...
                                </p>
                                <div class="d-flex flex-wrap gap-2">
                                    ${annonce.competences ? annonce.competences.map(c => 
                                        `<span class="badge bg-primary">${c}</span>`
                                    ).join('') : ''}
                                    
                                    ${annonce.langues ? annonce.langues.map(l => 
                                        `<span class="badge bg-info">${l}</span>`
                                    ).join('') : ''}
                                    
                                    ${annonce.anneeExperience ? 
                                        `<span class="badge bg-warning">${annonce.anneeExperience} an(s) exp.</span>` : ''}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 text-end">
                        <small class="text-muted date-creation" 
                            data-date-creation="${annonce.dateCreation || ''}">
                            Chargement...
                        </small>
                        <div class="mt-3 d-flex justify-content-end">
                            <button class="btn btn-outline-primary btn-sm me-2 btn-detailler" 
                                    onclick="openJobDetails(${annonce.id})">
                                <i class="bi bi-eye me-1"></i>Voir détails
                            </button>
                            <form id="postuler" action="/candidature/postuler/${annonce.id}" method="post">
                                <button class="btn btn-primary btn-sm btn-postuler"></a>
                                    <i class="bi bi-send me-1"></i>Postuler
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `).join('');
    
    // Mettre à jour les timestamps
    updateAllTimestamps();
    
    // Réinitialiser la pagination
    initializePagination();
}

// Initialisation de la pagination
function initializePagination() {
    const jobsList = document.querySelectorAll(".job-card");
    const pagination = document.querySelector(".pagination");
    const itemsPerPage = 5;
    let currentPage = 1;
    const totalPages = Math.ceil(jobsList.length / itemsPerPage);

    function generatePagination() {
        pagination.innerHTML = '';

        // Précédent
        const prevLi = document.createElement('li');
        prevLi.className = 'page-item';
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
        
        updatePagination();
    }

    function showPage(page) {
        currentPage = page;
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        jobsList.forEach((job, index) => {
            job.style.display = (index >= start && index < end) ? "block" : "none";
        });

        updatePagination();
    }

    function updatePagination() {
        const pageItems = pagination.querySelectorAll('.page-item');
        const pageLinks = pagination.querySelectorAll('.page-link');
        
        pageItems.forEach((li, idx) => {
            if (idx === 0) {
                // Précédent
                li.classList.toggle('disabled', currentPage === 1);
            } else if (idx === pageItems.length - 1) {
                // Suivant
                li.classList.toggle('disabled', currentPage === totalPages);
            } else {
                // Numéros de page
                const pageNum = idx;
                li.classList.toggle('active', pageNum === currentPage);
            }
        });
    }

    if (jobsList.length > 0) {
        generatePagination();
        showPage(1);
    } else {
        pagination.innerHTML = '';
    }
}
