// ================================
// Toggle mot de passe
// ================================
function togglePasswordVisibility(inputId, toggleId) {
    const input = document.getElementById(inputId);
    const toggle = document.getElementById(toggleId);

    toggle.addEventListener('click', function () {
        const type = input.type === 'password' ? 'text' : 'password';
        input.type = type;
        this.querySelector('i').classList.toggle('bi-eye');
        this.querySelector('i').classList.toggle('bi-eye-slash');
        input.placeholder = type === 'password' ? '••••••••' : '';
    });
}

togglePasswordVisibility('password', 'togglePassword');
togglePasswordVisibility('confirmPassword', 'toggleConfirmPassword');

// ================================
// Afficher champ poste si recruteur
// ================================
document.getElementById('profile').addEventListener('change', function () {
    const posteField = document.getElementById('posteField');
    const posteSelect = document.getElementById('poste');

    if (this.value === 'recruteur') {
        posteField.classList.remove('d-none');
        posteSelect.required = true;
    } else {
        posteField.classList.add('d-none');
        posteSelect.required = false;
        posteSelect.value = '';
    }
});


// ================================
// Validation confirmation mot de passe
// ================================
document.getElementById('registrationForm').addEventListener('submit', function (e) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
        e.preventDefault(); // bloque l'envoi
        showToast('danger', 'Les mots de passe ne correspondent pas.');
        return false;
    }
});
