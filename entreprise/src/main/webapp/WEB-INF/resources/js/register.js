// toggle mot de passe
function togglePasswordVisibility(inputId, toggleId) {
    const input = document.getElementById(inputId);
    const toggle = document.getElementById(toggleId);
    toggle.addEventListener('click', function () {
        const type = input.type === 'password' ? 'text' : 'password';
        input.type = type;
        this.querySelector('i').classList.toggle('bi-eye');
        this.querySelector('i').classList.toggle('bi-eye-slash');
        if (type === 'text') {
            input.placeholder = "";
        } else {
            input.placeholder = "••••••••";
        }
    });
}

togglePasswordVisibility('password', 'togglePassword');
togglePasswordVisibility('confirmPassword', 'toggleConfirmPassword');

// afficher champ poste si recruteur
document.getElementById('profile').addEventListener('change', function () {
    const posteField = document.getElementById('posteField');
    if (this.value === 'recruteur') {
        posteField.classList.remove('d-none');
        document.getElementById('poste').required = true;
    } else {
        posteField.classList.add('d-none');
        document.getElementById('poste').required = false;
    }
});