let isEditMode = false;
let annonceForm = null;
let annonceModal = null;
let dateChoiceModal = null;
let dateLimite = null;
let isCloseMode = false;

// Initialisation
document.addEventListener('DOMContentLoaded', function () {
    annonceForm = document.getElementById('annonceForm');
    annonceModal = new bootstrap.Modal(document.getElementById('jobOfferModal'));
    dateChoiceModal = new bootstrap.Modal(document.getElementById('dateChoiceModal'));

    document.querySelector('[data-bs-target="#jobOfferModal"]').addEventListener('click', function () {
        resetModal(); // Réinitialiser complètement le modal
        isEditMode = false; // S'assurer qu'on est en mode création
    });

    // Empêcher la soumission automatique
    annonceForm.addEventListener("submit", function (event) {
        event.preventDefault();
        event.stopPropagation();
        return false;
    });

    // Événement pour le bouton de publication
    document.getElementById('publishAnnonceBtn').addEventListener('click', handlePublishAnnonce);

    // Événements pour le modal de date
    if (!isCloseMode) {
        document.getElementById('useDefaultDate').addEventListener('click', submitAnnonceForm);
        document.getElementById('confirmCustomDate').addEventListener('click', handleConfirmCustomDate);
    }

    document.getElementById('chooseNewDate').addEventListener('click', handleChooseNewDate);

    // Réinitialiser le modal de date quand il est fermé
    document.getElementById('dateChoiceModal').addEventListener('hidden.bs.modal', resetDateModal);

    const mainScreen = document.getElementById("dateMainScreen");
    const customScreen = document.getElementById("customDateScreen");
    const chooseNewDateBtn = document.getElementById("chooseNewDate");
    const backToMainBtn = document.getElementById("backToMain");

    chooseNewDateBtn.addEventListener("click", () => {
        mainScreen.classList.add("slide-out-left");
        customScreen.classList.add("active");

        setTimeout(() => {
            mainScreen.classList.remove("active", "slide-out-left");
        }, 400);
    });

    backToMainBtn.addEventListener("click", () => {
        customScreen.classList.remove("active");
        mainScreen.classList.add("active");
    });
});

// Gérer la publication d'annonce
function handlePublishAnnonce() {

    // Valider le formulaire d'abord
    if (!validateAnnonceForm()) {
        return;
    }

    const dateLimiteField = document.getElementById('endDate');
    dateLimite = dateLimiteField ? dateLimiteField.value : null;

    // Déterminer si on est en mode édition
    isEditMode = document.getElementById('annonceId').value !== '';

    // Afficher le texte approprié pour le bouton de date par défaut
    const defaultDateText = document.getElementById('defaultDateText');
    defaultDateText.textContent = isEditMode ?
        'Utiliser la date prédéfinie' :
        'Utiliser la date par défaut';

    // Utiliser la méthode Bootstrap pour cacher le modal
    bootstrap.Modal.getInstance(document.getElementById('jobOfferModal')).hide();

    // Attendre que le modal soit complètement caché avant d'afficher le suivant
    document.getElementById('jobOfferModal').addEventListener('hidden.bs.modal', function onHidden() {
        dateChoiceModal.show();

        // Retirer l'écouteur pour éviter les duplications
        document.getElementById('jobOfferModal').removeEventListener('hidden.bs.modal', onHidden);
    });
}

// Fonction de validation du formulaire
function validateAnnonceForm() {
    const requiredFields = [
        'jobTitle', 'jobDepartment', 'filiere', 'jobDescription', 'endDate', 'tests'
    ];

    let isValid = true;

    requiredFields.forEach(fieldId => {
        const field = document.getElementById(fieldId);

        if (field && (!field.value || field.value === '' || field.value === '0')) {
            isValid = false;
            field.classList.add('is-invalid');
            field.classList.remove('is-valid');

            // Ajouter le message d'erreur si absent
            if (!field.nextElementSibling || !field.nextElementSibling.classList.contains('invalid-feedback')) {
                const errorDiv = document.createElement('div');
                errorDiv.className = 'invalid-feedback';
                errorDiv.textContent = 'Ce champ est obligatoire';
                field.parentNode.appendChild(errorDiv);
            }
        } else if (field) {
            field.classList.remove('is-invalid');
            field.classList.add('is-valid');

            // Supprimer le message d'erreur s'il existe
            const existingError = field.nextElementSibling;
            if (existingError && existingError.classList.contains('invalid-feedback')) {
                existingError.remove();
            }
        }
    });

    // Validation spécifique pour la date limite
    const dateLimiteField = document.getElementById('endDate');
    if (dateLimiteField && dateLimiteField.value) {
        const selectedDate = new Date(dateLimiteField.value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (selectedDate <= today) {
            isValid = false;
            dateLimiteField.classList.add('is-invalid');
            showToast("danger", 'La date limite doit être dans le futur');
        }
    }

    return isValid;
}

// Choisir une nouvelle date
function handleChooseNewDate() {
    document.getElementById('customDateContainer').classList.remove('d-none');
}

// Confirmer la date personnalisée
function handleConfirmCustomDate() {
    const customDate = document.getElementById('customDateInput').value;
    if (!customDate) {
        showToast("warning", 'Veuillez sélectionner une date et heure');
        return;
    }

    // Vérifier que la date est dans le futur
    const selectedDate = new Date(customDate);
    const now = new Date();
    if (selectedDate <= now) {
        showToast("danger", 'La date de début d\'entretien doit être dans le futur');
        return;
    }

    document.getElementById('debutEntretien').value = customDate;
    submitAnnonceForm();
}

function calculateDefaultDate(dateLimite) {
    const date = new Date(dateLimite);
    date.setDate(date.getDate() + 1); // +1 jour
    date.setHours(8, 0, 0, 0); // 8h00 locale

    // Formater manuellement en local (yyyy-MM-ddTHH:mm)
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const secondes = String(date.getSeconds()).padStart(2, '0');

    const localDate = `${year}-${month}-${day}T${hours}:${minutes}:${secondes}`;
    return localDate;
}


// Soumettre le formulaire d'annonce
function submitAnnonceForm() {
    try {

        // Fermer le modal de date
        dateChoiceModal.hide();

        document.getElementById('dateChoiceModal').addEventListener('hidden.bs.modal', function onDateModalHidden() {
            annonceForm.submit();

            document.getElementById('dateChoiceModal').removeEventListener('hidden.bs.modal', onDateModalHidden);
        });

    } catch (error) {
        console.error('Erreur lors de la soumission:', error);
        showToast("danger", 'Erreur lors de la publication');
        annonceModal.show();
    }
}

// Réinitialiser le modal de date
function resetDateModal() {
    document.getElementById('customDateContainer').classList.add('d-none');
    document.getElementById('customDateInput').value = '';
    document.getElementById('defaultDateText').textContent = 'Utiliser la date par défaut';
}

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
        });
    });

    var toastElList = [].slice.call(document.querySelectorAll('.toast'));
    toastElList.forEach(function (toastEl) {
        var toast = new bootstrap.Toast(toastEl, { delay: 5000 });
        toast.show();
    });
});

document.getElementById('btnFilter').addEventListener('click', function () {
    const villeId = document.getElementById('filterVille').value;
    const departementId = document.getElementById('filterDepartement').value;
    const poste = document.getElementById('filterPoste').value;
    const status = document.getElementById('filterStatus').value;
    let url = "/api/annonces/filtre?villeId=" + villeId + "&departementId=" + departementId + "&poste=" + poste;
    if (status) url += "&status=" + status;
    fetch(url)
        .then(response => response.json())
        .then(data => {
            updateAnnonceTable(data);
        })
        .catch(error => console.error('Erreur fetch annonces:', error));
});
// Fonction pour fermer une annonce
// Fonction pour fermer une annonce avec choix de date
function closeJobOffer(annonceId) {
    if (!confirm('Êtes-vous sûr de vouloir fermer cette annonce ?')) return;

    isCloseMode = true;
    window.pendingCloseAnnonceId = annonceId;

    // Supprimer les anciens écouteurs
    const useDefaultDateBtn = document.getElementById('useDefaultDate');
    const confirmCustomDateBtn = document.getElementById('confirmCustomDate');
    useDefaultDateBtn.replaceWith(useDefaultDateBtn.cloneNode(true));
    confirmCustomDateBtn.replaceWith(confirmCustomDateBtn.cloneNode(true));

    // Réaffecter les variables après clonage
    const newUseDefaultDateBtn = document.getElementById('useDefaultDate');
    const newConfirmCustomDateBtn = document.getElementById('confirmCustomDate');

    // Attacher les bons événements pour la fermeture
    newConfirmCustomDateBtn.addEventListener('click', handleConfirmCloseNewDate);
    newUseDefaultDateBtn.addEventListener('click', handleConfirmCloseDefaultDate);

    dateChoiceModal.show();
}

// Fonction pour gérer la confirmation de la date pour la fermeture
function handleConfirmCloseNewDate() {
    const customDate = document.getElementById('customDateInput').value;
    if (!customDate) {
        showToast("warning", 'Veuillez sélectionner une date et heure');
        return;
    }

    const selectedDate = new Date(customDate);
    const now = new Date();
    if (selectedDate <= now) {
        showToast("danger", 'La date de début d\'entretien doit être dans le futur');
        return;
    }

    // Cacher le modal et envoyer la requête de fermeture
    dateChoiceModal.hide();

    document.getElementById('dateChoiceModal').addEventListener('hidden.bs.modal', function onHidden() {
        // Créer le formulaire pour fermer l'annonce
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/annonces/close';

        // Ajouter l'ID de l'annonce
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'id';
        input.value = window.pendingCloseAnnonceId;
        form.appendChild(input);

        // Ajouter la date d'entretien choisie
        const dateInput = document.createElement('input');
        dateInput.type = 'hidden';
        dateInput.name = 'debutEntretien';
        dateInput.value = customDate;
        form.appendChild(dateInput);

        // Ajouter le token CSRF si nécessaire
        const csrfToken = document.querySelector('input[name="_csrf"]');
        if (csrfToken) {
            form.appendChild(csrfToken.cloneNode());
        }

        document.body.appendChild(form);
        form.submit();

        // Nettoyer l'écouteur et variable temporaire
        dateChoiceModal.removeEventListener('hidden.bs.modal', onHidden);
        window.pendingCloseAnnonceId = null;
        isCloseMode = false;
    });
}

function handleConfirmCloseDefaultDate() {
    dateChoiceModal.hide();

    document.getElementById('dateChoiceModal').addEventListener('hidden.bs.modal', function onHidden() {
        // Créer le formulaire pour fermer l'annonce
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/annonces/close';

        // Ajouter l'ID de l'annonce
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'id';
        input.value = window.pendingCloseAnnonceId;
        form.appendChild(input);

        // Ajouter le token CSRF si nécessaire
        const csrfToken = document.querySelector('input[name="_csrf"]');
        if (csrfToken) {
            form.appendChild(csrfToken.cloneNode());
        }

        document.body.appendChild(form);
        form.submit();

        // Nettoyer l'écouteur et variable temporaire
        dateChoiceModal.removeEventListener('hidden.bs.modal', onHidden);
        window.pendingCloseAnnonceId = null;
        isCloseMode = false;
    });
}

// Fonction pour mettre à jour le tableau avec l'action de fermeture
function updateAnnonceTable(annonces) {
    const tbody = document.getElementById('annonceTableBody');
    tbody.innerHTML = ''; // vider l'ancien contenu

    let rowIndex = 0;
    annonces.forEach(function (annonce) {
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
            ? '<i class="fs-6 bi bi-exclamation-triangle-fill me-1 text-danger"></i>'
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
    isEditMode = true;
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
    document.getElementById('debutEntretien').value = annonce.debutEntretien || '';
    document.getElementById('jobTitle').value = annonce.posteLibelle || '';
    document.getElementById('jobDepartment').value = annonce.departementId || '';
    document.getElementById('age').value = annonce.ageMinimum || '';
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
    isEditMode = false;
    document.getElementById('modalTitle').textContent = 'Nouvelle annonce d\'emploi';
    document.getElementById('annonceForm').action = '/annonces/create';
    document.getElementById('annonceForm').reset();
    document.getElementById('annonceId').value = '';

    // Réinitialiser aussi la date d'entretien
    document.getElementById('debutEntretien').value = '';

    // Vider les tags
    document.getElementById('technicalSkillsContainer').innerHTML = '';
    document.getElementById('languagesContainer').innerHTML = '';

    // Réinitialiser les toggles
    document.querySelectorAll('.toggle-required input[type="checkbox"]').forEach(toggle => {
        toggle.checked = false;
    });
    updateRequiredFields();
}

