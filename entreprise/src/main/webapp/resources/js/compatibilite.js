function evaluateCompatibility(candidatureId) {
    const url = `/api/compatibilite/${candidatureId}`;

    fetch(url)
        .then(response => {
            if (!response.ok) throw new Error("Erreur API compatibilité");
            return response.json();
        })
        .then(data => {
            showCompatibilityModal(data);
        })
        .catch(err => {
            console.error(err);
            alert("Impossible de récupérer le score de compatibilité.");
        });
}

function getCriterionIcon(criterionName) {
    const iconMap = {
        "Âge": "bi-calendar-event",
        "Ville": "bi-geo-alt",
        "Genre": "bi-person",
        "Diplôme": "bi-mortarboard",
        "Expérience": "bi-briefcase",
        "Compétences": "bi-tools",
        "Langues": "bi-translate"
    };
    return iconMap[criterionName] || "bi-check-circle";
}

function getScoreClass(score) {
    if (score >= 75) return 'high';
    if (score >= 40) return 'medium';
    return 'low';
}

function showLoading() {
    const modalBody = document.getElementById('modalBodyContent');
    modalBody.innerHTML = `
        <div class="loading-container">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-3 text-muted">Loading compatibility results...</p>
        </div>
    `;
}

function renderResult(resultDto) {
    const modalBody = document.getElementById('modalBodyContent');

    if (!resultDto || !resultDto.id) {
        modalBody.innerHTML = `
            <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>
                <strong>Error:</strong> Invalid or missing compatibility data.
            </div>
        `;
        return;
    }

    const totalCriteria = Object.keys(resultDto.scores).length;
    let criteriaHTML = '';

    for (const [criterion, score] of Object.entries(resultDto.scores)) {
        const icon = getCriterionIcon(criterion);
        const scoreClass = getScoreClass(score);
        const hasMatches = resultDto.correspondances && resultDto.correspondances[criterion];
        const matches = hasMatches ? resultDto.correspondances[criterion] : [];
        const collapseId = `collapse-${criterion.replace(/\s+/g, '-')}`;

        criteriaHTML += `
            <div class="criteria-group">
                <div class="criteria-row align-items-center toggle-collapse" data-bs-toggle="collapse" data-bs-target="#${collapseId}">
                    <div class="criteria-icon"><i class="bi ${icon}"></i></div>
                    <div class="criteria-name flex-grow-1">
                        ${criterion}
                        ${hasMatches && matches.length > 0 ? `<i class="bi bi-eye ms-2 toggle-icon"></i>` : ''}
                    </div>
                    <div class="criteria-score ${scoreClass}">${score}<small>/100</small></div>
                </div>

                ${hasMatches && matches.length > 0 ? `
                    <div class="collapse mt-2" id="${collapseId}">
                        <div class="correspondences p-2">
                            ${matches.map(match => `<span class="badge-custom">${match}</span>`).join('')}
                        </div>
                    </div>
                ` : ''}
            </div>
        `;
    }

    modalBody.innerHTML = `
        <div class="text-center mb-3">
            <span class="badge bg-secondary fs-6">Candidature ID: ${resultDto.id}</span>
        </div>

        <div class="score-global mb-3">
            <p class="score-number">${resultDto.scoreGlobal.toFixed(2)}</p>
            <p class="score-label">Global Compatibility Score</p>
            <div class="progress">
                <div class="progress-bar" role="progressbar" style="width: ${resultDto.scoreGlobal}%"
                    aria-valuenow="${resultDto.scoreGlobal}" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
        </div>

        <div class="criteria-table">
            <h6 class="mb-3"><i class="bi bi-list-check me-2"></i>Detailed Criteria Evaluation</h6>
            ${criteriaHTML}
        </div>
    `;

    // Animation rotation de la flèche ↓
    const toggles = modalBody.querySelectorAll('.toggle-collapse');
    toggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const icon = this.querySelector('.toggle-icon');
            if (icon) {
                icon.classList.toggle('rotated');
            }
        });
    });
}

function showCompatibilityModal(resultDto) {
    currentResultDto = resultDto;

    // Get modal instance
    const modalElement = document.getElementById('compatibilityModal');
    const modal = new bootstrap.Modal(modalElement);

    // Show loading state
    showLoading();
    modal.show();

    // Simulate loading delay (400-800ms)
    const loadDelay = 400 + Math.random() * 400;
    setTimeout(() => {
        renderResult(resultDto);
    }, loadDelay);

    // Set focus management
    modalElement.addEventListener('shown.bs.modal', function () {
        this.querySelector('.btn-close').focus();
    });
}
