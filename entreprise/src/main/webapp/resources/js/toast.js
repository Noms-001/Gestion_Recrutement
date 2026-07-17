// toast.js

// sécuriser le message pour éviter l'injection HTML
function escapeHtml(text) {
    const div = document.createElement("div");
    div.textContent = text;
    return div.innerHTML;
}

function ensureToastContainer() {
    let container = document.getElementById("toastContainer");
    if (!container) {
        container = document.createElement("div");
        container.id = "toastContainer";
        container.className = "position-fixed end-0 p-3";
        container.style.top = "10%";
        container.style.zIndex = "1050";
        document.body.appendChild(container);
    }
    return container;
}

// show toast using Bootstrap Toast API (auto-hide 5s)
function showToast(type, message) {
    const iconMap = {
        success: "bi-check-circle-fill",
        danger: "bi-exclamation-circle-fill",
        info: "bi-info-circle-fill",
        warning: "bi-exclamation-triangle-fill"
    };
    const bgClass = type === "success" ? "text-bg-success"
                   : type === "danger" ? "text-bg-danger"
                   : type === "info" ? "text-bg-info"
                   : type === "warning" ? "text-bg-warning"
                   : "text-bg-primary"; 

    const container = ensureToastContainer();

    const toastEl = document.createElement("div");
    toastEl.className = `toast align-items-center ${bgClass} border-0`;
    toastEl.setAttribute("role", "alert");
    toastEl.setAttribute("aria-live", "assertive");
    toastEl.setAttribute("aria-atomic", "true");

    toastEl.innerHTML = `
        <div class="d-flex m-3">
            <div class="toast-body">
                <i class="bi ${iconMap[type]} me-2"></i>
                ${escapeHtml(message)}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;


    container.appendChild(toastEl);

    console.log(container);

    const bsToast = new bootstrap.Toast(toastEl, { delay: 5000 });
    toastEl.addEventListener("hidden.bs.toast", () => toastEl.remove());
    bsToast.show();
}
