// Afficher/masquer mot de passe
function togglePasswordVisibility(inputId, toggleId) {
    const input = document.getElementById(inputId);
    const toggle = document.getElementById(toggleId);
    toggle.addEventListener('click', function () {
        const type = input.type === 'password' ? 'text' : 'password';
        input.type = type;
        this.querySelector('i').classList.toggle('bi-eye');
        this.querySelector('i').classList.toggle('bi-eye-slash');
        input.placeholder = type === 'password' ? "••••••••" : "";
    });
}

togglePasswordVisibility('password', 'togglePassword');

// Simulation de connexion
document.getElementById('loginForm').addEventListener('submit', function (e) {
    e.preventDefault();
    alert('Connexion réussie!');
    window.location.href = 'dashboard.html';
});