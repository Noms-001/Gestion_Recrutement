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
    button.className = 'btn btn-success btn-sm';
    button.disabled = true;
    
    // Add success class to row
    row.classList.add('table-success');
    
    // Show success message
    showToast('success', 'Candidat validé avec succès !');
}

function showCandidateDetails(candidateId) {
    // This would typically fetch candidate details from an API
    const modalElement = document.getElementById('candidateDetailsModal');
    const modal = new bootstrap.Modal(modalElement);
    modal.show();
}
