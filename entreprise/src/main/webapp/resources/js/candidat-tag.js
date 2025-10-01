function addTag(type) {
    const select = document.getElementById(type + 'Filter');
    const container = document.getElementById(type + 'Container');
    const value = select.value;
    const text = select.options[select.selectedIndex].text;

    if (!value) return;

    // éviter doublons
    if (container.querySelector(`[data-value="${value}"]`)) return;

    const tag = document.createElement('span');
    tag.className = "badge bg-light text-dark border d-flex align-items-center";
    tag.dataset.value = value;
    tag.innerHTML = text + ` <i class="bi bi-x ms-2" style="cursor:pointer;" onclick="this.parentElement.remove()"></i>`;
    container.appendChild(tag);
}

function resetFilters() {
    document.querySelectorAll("#skillsContainer, #languagesContainer").forEach(c => c.innerHTML = "");
}

const candidatesPerPage = 6; // nombre de candidats par page
let currentPage = 1;

function showPage(page) {
    const candidates = document.querySelectorAll('.row.g-4 > .col-lg-4');
    const totalPages = Math.ceil(candidates.length / candidatesPerPage);
    currentPage = page;

    candidates.forEach((c, i) => {
        c.style.display = (i >= (page - 1) * candidatesPerPage && i < page * candidatesPerPage) ? 'block' : 'none';
    });

    // Mettre à jour pagination
    const pagination = document.querySelector('.pagination');
    pagination.querySelectorAll('.page-item').forEach(li => li.remove());

    // Précédent
    const prev = document.createElement('li');
    prev.className = `page-item ${page === 1 ? 'disabled' : ''}`;
    prev.innerHTML = `<a class="page-link" href="#">Précédent</a>`;
    prev.onclick = (e) => { e.preventDefault(); if (page > 1) showPage(page - 1); };
    pagination.appendChild(prev);

    // Pages
    for (let i = 1; i <= totalPages; i++) {
        const li = document.createElement('li');
        li.className = `page-item ${i === page ? 'active' : ''}`;
        li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
        li.onclick = (e) => { e.preventDefault(); showPage(i); };
        pagination.appendChild(li);
    }

    // Suivant
    const next = document.createElement('li');
    next.className = `page-item ${page === totalPages ? 'disabled' : ''}`;
    next.innerHTML = `<a class="page-link" href="#">Suivant</a>`;
    next.onclick = (e) => { e.preventDefault(); if (page < totalPages) showPage(page + 1); };
    pagination.appendChild(next);
}

// Alignement et hauteur uniforme
function equalCardHeights() {
    const cards = document.querySelectorAll('.row.g-4 .card');
    let maxHeight = 0;
    cards.forEach(c => c.style.height = 'auto'); // reset
    cards.forEach(c => { if (c.offsetHeight > maxHeight) maxHeight = c.offsetHeight; });
    cards.forEach(c => c.style.height = maxHeight + 'px');
}

// Initialisation
document.addEventListener('DOMContentLoaded', () => {
    showPage(1);
    equalCardHeights();
    window.addEventListener('resize', equalCardHeights);
});
