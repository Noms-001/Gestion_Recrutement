// Remplacer le tableau statique par une fonction qui fetch les postes vacants
function getJobTitles() {
    return fetch('/api/postes/vacants')
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur lors de la récupération des postes vacants');
            }
            return response.json();
        })
        .then(postesVacants => {
            console.log('Postes vacants récupérés:', postesVacants);
            return postesVacants;
        })
        .catch(error => {
            console.error('Erreur:', error);
            // Retourner un tableau vide ou des valeurs par défaut en cas d'erreur
            return null;
        });
}

const jobInput = document.getElementById("jobTitle");
const jobList = document.getElementById("jobTitleList");

// Fonction pour afficher les jobs filtrés
function showJobList(filter = "") {
    jobList.innerHTML = "";
    const value = filter.toLowerCase();

    getJobTitles().then(jobTitles => {
        const filtered = jobTitles.filter(title => 
            title.toLowerCase().includes(value)
        );
        
        filtered.forEach(title => {
            const item = document.createElement("div");
            item.classList.add("list-group-item", "list-group-item-action");
            item.textContent = title;
            item.addEventListener("click", () => {
                jobInput.value = title;
                jobList.style.display = "none";
            });
            jobList.appendChild(item);
        });
        jobList.style.display = filtered.length ? "block" : "none";
    });
}

// Afficher quand on tape
jobInput.addEventListener("input", function () {
    showJobList(this.value);
});

// ✅ Afficher toute la liste au clic (focus)
jobInput.addEventListener("focus", function () {
    showJobList(this.value);
});

// Fermer si clic en dehors
document.addEventListener("click", e => {
    if (!jobInput.contains(e.target) && !jobList.contains(e.target)) {
        jobList.style.display = "none";
    }
});


// Toggle switch info au survol
document.querySelectorAll('.toggle-required').forEach(el => {
    const infoText = document.createElement('small');
    infoText.className = 'form-text text-muted';
    infoText.style.display = 'none';
    infoText.style.marginTop = '2px';
    infoText.innerHTML = '<i class="bi bi-info-circle"></i> ' + el.dataset.info;
    el.appendChild(infoText);

    el.addEventListener('mouseenter', () => {
        infoText.style.display = 'inline';
    });
    el.addEventListener('mouseleave', () => {
        infoText.style.display = 'none';
    });
});

document.addEventListener('DOMContentLoaded', () => {
    // Tous les toggles
    document.querySelectorAll('.toggle-required input[type="checkbox"]').forEach(toggle => {
        toggle.addEventListener('change', (e) => {
            const parent = e.target.closest('.col-md-6');
            if (!parent) return;

            const input = parent.querySelector('input, select, textarea');
            if (!input) return;

            input.required = e.target.checked;
            console.log(e.target.checked);
        });
    });

    var toastElList = [].slice.call(document.querySelectorAll('.toast'));
    toastElList.forEach(function (toastEl) {
        var toast = new bootstrap.Toast(toastEl, { delay: 5000 });
        toast.show();
    });
});

document.getElementById('btnFilter').addEventListener('click', function() {
            const villeId = document.getElementById('filterVille').value;
            const departementId = document.getElementById('filterDepartement').value;
            const poste = document.getElementById('filterPoste').value;
            const status = document.getElementById('filterStatus').value;
            let url = "/api/annonces/filtre?villeId="+villeId+"&departementId="+departementId+"&poste="+poste;
            if(status) url += "&status="+status;
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    updateAnnonceTable(data);
                })
                .catch(error => console.error('Erreur fetch annonces:', error));
        });
        // Fonction pour fermer une annonce
function closeJobOffer(annonceId) {
    if (confirm('Êtes-vous sûr de vouloir fermer cette annonce ?')) {
        // Créer un formulaire pour envoyer la requête POST
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/annonces/close';
        
        // Ajouter le champ ID
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'id';
        input.value = annonceId;
        form.appendChild(input);
        
        // Ajouter le token CSRF (si vous en utilisez un)
        const csrfToken = document.querySelector('input[name="_csrf"]');
        if (csrfToken) {
            form.appendChild(csrfToken.cloneNode());
        }
        
        // Soumettre le formulaire
        document.body.appendChild(form);
        form.submit();
    }
}

// Fonction pour mettre à jour le tableau avec l'action de fermeture
function updateAnnonceTable(annonces) {
    const tbody = document.getElementById('annonceTableBody');
    tbody.innerHTML = ''; // vider l'ancien contenu

    let rowIndex = 0;
    annonces.forEach(function(annonce) {
        let badgeColor = '';
        switch (rowIndex % 3) {
            case 0: badgeColor = 'bg-primary'; break;
            case 1: badgeColor = 'bg-info'; break;
            case 2: badgeColor = 'bg-secondary'; break;
        }
        rowIndex++;

        let statusBadge = '';
        if (annonce.ferme) {
            statusBadge = '<span class="badge bg-dark">Fermée</span>';
        } else if (annonce.dateLimite && new Date(annonce.dateLimite) < new Date()) {
            statusBadge = '<span class="badge bg-danger">Expirée</span>';
        } else {
            statusBadge = '<span class="badge bg-success">Active</span>';
        }

        const showCloseAction = !annonce.ferme && (!annonce.dateLimite || new Date(annonce.dateLimite) >= new Date());
        const urgentBadge = annonce.urgent && !annonce.ferme 
            ? '<i class="bi bi-exclamation-triangle me-1 text-danger"></i>' 
            : '';

        // Version avec Template Literals (plus lisible)
        const row = `
            <tr>
                <td>
                    <div class="fw-medium">
                        ${annonce.posteLibelle || ''}
                    </div>
                    <small class="text-muted">
                        ${urgentBadge}
                        ${annonce.anneeExperience ? annonce.anneeExperience + ' ans' : ''}
                        ${annonce.villeNom && annonce.anneeExperience ? ' • ' : ''}
                        ${annonce.villeNom || ''}
                    </small>
                </td>
                <td><span class="badge ${badgeColor}">${annonce.departementNom || ''}</span></td>
                <td>${statusBadge}</td>
                <td>
                    <div class="fw-bold">${annonce.candidaturesCount}</div>
                    <small class="text-muted">candidatures</small>
                </td>
                <td>${annonce.dateCreation || ''}</td>
                <td>${annonce.dateLimite || ''}</td>
                <td>
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            Actions
                        </button>
                        <ul class="dropdown-menu">
                            ${showCloseAction ? `<li><a class="dropdown-item" href="#" onclick="editJobOffer(${annonce.id})"><i class="bi bi-pencil me-2"></i>Modifier</a></li>` : ''}
                            <li><a class="dropdown-item" href="#"><i class="bi bi-eye me-2"></i>Voir les candidatures</a></li>
                            ${showCloseAction ? `
                                <hr class="dropdown-divider">
                                <li><a class="dropdown-item text-danger" href="#" onclick="closeJobOffer(${annonce.id})"><i class="bi bi-x-circle me-2"></i>Fermer l'annonce</a></li>
                            ` : ''}
                        </ul>
                    </div>
                </td>
            </tr>
        `;

        tbody.innerHTML += row;
    });
}
// Fonction pour éditer une annonce
function editJobOffer(annonceId) {
    console.log('Modification de l\'annonce ID:', annonceId);
    
    // Récupérer les données de l'annonce via API
    fetch('/api/annonces/' + annonceId)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur lors de la récupération des données');
            }
            return response.json();
        })
        .then(annonce => {
            console.log('Données de l\'annonce:', annonce);
            populateModalWithData(annonce);
        })
        .catch(error => {
            console.error('Erreur:', error);
            alert('Erreur lors du chargement des données de l\'annonce');
        });
}

// Fonction pour remplir le modal avec les données de l'annonce
function populateModalWithData(annonce) {
    // Changer le titre du modal
    document.getElementById('modalTitle').textContent = 'Modifier l\'annonce';
    
    // Mettre à jour l'action du formulaire
    const form = document.getElementById('annonceForm');
    form.action = '/annonces/update';
    
    // Remplir les champs avec les données
    document.getElementById('annonceId').value = annonce.id;
    document.getElementById('jobTitle').value = annonce.posteLibelle || '';
    document.getElementById('jobDepartment').value = annonce.departementId || '';
    document.getElementById('age').value = annonce.ageMinimun || '';
    document.getElementById('experience').value = annonce.anneeExperience || '';
    document.getElementById('location').value = annonce.villeId || '';
    document.getElementById('gender').value = annonce.genreId || '';
    document.getElementById('diplome').value = annonce.diplomeId || '';
    document.getElementById('filiere').value = annonce.filiereId || '';
    document.getElementById('jobDescription').value = annonce.description || '';
    document.getElementById('endDate').value = annonce.dateLimite || '';
    document.getElementById('tests').value = annonce.testId || '';
    document.getElementById('urgentJob').checked = annonce.urgent || false;
    
    // Gérer les toggles obligatoires
    document.getElementById('ageRequired').checked = annonce.ageObligatoire || false;
    document.getElementById('experienceRequired').checked = annonce.experienceObligatoire || false;
    document.getElementById('locationRequired').checked = annonce.villeObligatoire || false;
    document.getElementById('genderRequired').checked = annonce.genreObligatoire || false;
    document.getElementById('diplomeRequired').checked = annonce.diplomeObligatoire || false;
    
    // Mettre à jour les champs requis
    updateRequiredFields();
    
    // Charger les compétences et langues (si disponibles)
    loadCompetencesAndLangues(annonce.id);
    
    // Ouvrir le modal
    const modal = new bootstrap.Modal(document.getElementById('jobOfferModal'));
    modal.show();
}

// Fonction pour mettre à jour les champs requis basés sur les toggles
function updateRequiredFields() {
    document.querySelectorAll('.toggle-required input[type="checkbox"]').forEach(toggle => {
        const parent = toggle.closest('.col-md-6');
        if (!parent) return;

        const input = parent.querySelector('input, select, textarea');
        if (!input) return;

        input.required = toggle.checked;
    });
}

// Fonction pour charger les compétences et langues de l'annonce
// Fonction pour charger les compétences et langues de l'annonce
function loadCompetencesAndLangues(annonceId) {
    // Vider les conteneurs actuels
    document.getElementById('technicalSkillsContainer').innerHTML = '';
    document.getElementById('languagesContainer').innerHTML = '';
    
    // Charger les compétences
    fetch('/api/annonces/' + annonceId + '/competences')
        .then(response => response.json())
        .then(competences => {
            competences.forEach(comp => {
                addExistingTag('technicalSkills', comp.id, comp.libelle, comp.estObligatoire);
            });
        })
        .catch(error => console.error('Erreur chargement compétences:', error));
    
    // Charger les langues
    fetch('/api/annonces/' + annonceId + '/langues')
        .then(response => response.json())
        .then(langues => {
            langues.forEach(langue => {
                addExistingTag('languages', langue.id, langue.libelle, langue.estObligatoire);
            });
        })
        .catch(error => console.error('Erreur chargement langues:', error));
}

// Fonction pour ajouter des tags existants (sans les sélecteurs)
// Fonction pour ajouter des tags existants AVEC les toggles
function addExistingTag(containerType, id, libelle, estObligatoire = false) {
    const container = document.getElementById(containerType + 'Container');
    
    // Vérifier si le tag existe déjà
    if (container.querySelector(`[data-value="${id}"]`)) return;

    // Conteneur du tag
    const tag = document.createElement('div');
    tag.className = "border bg-light text-dark rounded p-2 mb-1";
    tag.dataset.value = id;

    // Ligne principale
    const row = document.createElement('div');
    row.className = "d-flex align-items-center justify-content-between";

    // Texte
    const spanText = document.createElement('span');
    spanText.textContent = libelle;

    // Bloc actions
    const actions = document.createElement('div');
    actions.className = "d-flex align-items-center";

    // Toggle switch avec tooltip
    const toggleWrapper = document.createElement('div');
    toggleWrapper.className = "form-check form-switch m-0 p-0";
    toggleWrapper.style.marginRight = "8px";

    const toggle = document.createElement('input');
    toggle.type = "checkbox";
    toggle.name = containerType === 'technicalSkills' ? 'competencesObligatoires[]' : 'languesObligatoires[]';
    toggle.className = "form-check-input";
    toggle.checked = estObligatoire; // SET LA VALEUR EXISTANTE
    toggle.setAttribute("data-bs-html", "true");
    toggle.setAttribute("title", '<i class="bi bi-info-circle"></i> Spécifie si c\'est obligatoire');
    toggleWrapper.appendChild(toggle);

    // Hidden input pour l'ID
    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = containerType === 'technicalSkills' ? 'competences[]' : 'langues[]';
    hiddenInput.value = id;

    // Bouton suppression
    const closeIcon = document.createElement('i');
    closeIcon.className = "bi bi-x";
    closeIcon.style.cursor = "pointer";
    closeIcon.addEventListener('click', () => {
        tag.remove();          // supprime le tag visuel
        hiddenInput.remove();  // supprime le hidden input
    });

    // Actions = switch + croix
    actions.appendChild(toggleWrapper);
    actions.appendChild(closeIcon);

    // Ligne principale
    row.appendChild(spanText);
    row.appendChild(actions);

    // Assembler
    tag.appendChild(row);
    container.appendChild(tag);
    container.appendChild(hiddenInput);

    // Activer le tooltip pour ce switch
    new bootstrap.Tooltip(toggle);
}
// Fonction pour réinitialiser le modal (pour nouvelle annonce)
function resetModal() {
    document.getElementById('modalTitle').textContent = 'Nouvelle annonce d\'emploi';
    document.getElementById('annonceForm').action = '/annonces/create';
    document.getElementById('annonceForm').reset();
    document.getElementById('annonceId').value = '';
    
    // Vider les tags
    document.getElementById('technicalSkillsContainer').innerHTML = '';
    document.getElementById('languagesContainer').innerHTML = '';
    
    // Réinitialiser les toggles
    document.querySelectorAll('.toggle-required input[type="checkbox"]').forEach(toggle => {
        toggle.checked = false;
    });
    updateRequiredFields();
}

// Ajouter un écouteur d'événement pour réinitialiser le modal quand il est fermé
document.getElementById('jobOfferModal').addEventListener('hidden.bs.modal', function () {
    resetModal();
});