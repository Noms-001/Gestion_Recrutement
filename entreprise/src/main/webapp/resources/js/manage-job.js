const jobTitles = [
    "Développeur Java",
    "Développeur Python",
    "Designer UX/UI",
    "Responsable Marketing",
    "Chef de projet",
    "Data Analyst",
    "Commercial",
    "Ressources Humaines"
];

const jobInput = document.getElementById("jobTitle");
const jobList = document.getElementById("jobTitleList");

// Fonction pour afficher les jobs filtrés
function showJobList(filter = "") {
    jobList.innerHTML = "";
    const value = filter.toLowerCase();

    const filtered = jobTitles.filter(title => title.toLowerCase().includes(value));
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

    diplome.addEventListener('change', updateDiplomeFiliereRequired);
    filiere.addEventListener('change', updateDiplomeFiliereRequired);
    updateDiplomeFiliereRequired(); // Initial

    var toastElList = [].slice.call(document.querySelectorAll('.toast'));
    toastElList.forEach(function (toastEl) {
        var toast = new bootstrap.Toast(toastEl, { delay: 5000 });
        toast.show();
    });
});
