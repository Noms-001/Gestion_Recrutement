// Affiche le toast automatiquement si présent
var toastEl = document.getElementById('errorToast');
if (toastEl) {
    var toast = new bootstrap.Toast(toastEl, { delay: 5000 });
    toast.show();
}