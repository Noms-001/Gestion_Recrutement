// TalentSphere HR System JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Initialize current date
    updateCurrentDate();
    
    // Initialize tooltips
    initializeTooltips();
    
    // Initialize form validation
    initializeFormValidation();
});

function updateCurrentDate() {
    const currentDateElement = document.getElementById('currentDate');
    if (currentDateElement) {
        const now = new Date();
        const options = { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        };
        currentDateElement.textContent = now.toLocaleDateString('fr-FR', options);
    }
}

function initializeTooltips() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

function initializeFormValidation() {
    // Bootstrap form validation
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
}

// Interview Evaluation Functions
function updateTotalScore() {
    const scoreInputs = document.querySelectorAll('.score-input');
    let totalScore = 0;
    let maxScore = 0;
    
    scoreInputs.forEach(input => {
        const value = parseInt(input.value) || 0;
        const max = parseInt(input.max) || 0;
        totalScore += value;
        maxScore += max;
    });
    
    const totalScoreElement = document.getElementById('totalScore');
    const scorePercentage = Math.round((totalScore / maxScore) * 100);
    
    if (totalScoreElement) {
        totalScoreElement.textContent = `${totalScore}/${maxScore} (${scorePercentage}%)`;
        
        // Update score class based on percentage
        const scoreDisplay = totalScoreElement.closest('.score-display');
        if (scoreDisplay) {
            scoreDisplay.className = 'score-display ';
            if (scorePercentage >= 90) scoreDisplay.classList.add('score-excellent');
            else if (scorePercentage >= 75) scoreDisplay.classList.add('score-good');
            else if (scorePercentage >= 60) scoreDisplay.classList.add('score-average');
            else scoreDisplay.classList.add('score-poor');
        }
    }
}

// Email functions
function sendEmail(candidateId) {
    // Simulate email sending
    alert('Email envoyé au candidat avec succès !');
}

// Candidate validation functions
function validateCandidate(candidateId) {
    const button = event.target;
    const row = button.closest('tr');
    
    // Change button state
    button.innerHTML = '<i class="bi bi-check"></i> Validé';
    button.className = 'btn btn-success btn-sm';
    button.disabled = true;
    
    // Add success class to row
    row.classList.add('table-success');
    
    // Show success message
    showToast('Candidat validé avec succès !', 'success');
}

function showCandidateDetails(candidateId) {
    // This would typically fetch candidate details from an API
    const modalElement = document.getElementById('candidateDetailsModal');
    const modal = new bootstrap.Modal(modalElement);
    modal.show();
}

// Toast notification function
function showToast(message, type = 'info') {
    const toastContainer = document.getElementById('toastContainer');
    if (!toastContainer) {
        // Create toast container if it doesn't exist
        document.body.insertAdjacentHTML('beforeend', 
            '<div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3"></div>'
        );
    }
    
    const toastId = 'toast_' + Date.now();
    const toastHtml = `
        <div id="${toastId}" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="bi bi-info-circle text-${type} me-2"></i>
                <strong class="me-auto">TalentSphere</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        </div>
    `;
    
    document.getElementById('toastContainer').insertAdjacentHTML('beforeend', toastHtml);
    
    const toast = new bootstrap.Toast(document.getElementById(toastId));
    toast.show();
    
    // Remove toast element after it's hidden
    document.getElementById(toastId).addEventListener('hidden.bs.toast', function() {
        this.remove();
    });
}

// PDF generation function (placeholder)
function generatePDF() {
    showToast('Génération du PDF en cours...', 'info');
    
    // Simulate PDF generation
    setTimeout(() => {
        showToast('PDF généré avec succès !', 'success');
    }, 2000);
}