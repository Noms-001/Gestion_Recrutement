function toggleJobDetails(jobId) {
    const details = document.getElementById(`details-${jobId}`);
    details.classList.toggle('d-none');
}


document.addEventListener("DOMContentLoaded", () => {
    const jobsList = document.querySelectorAll(".job-card");
    const pagination = document.querySelector(".pagination");
    const itemsPerPage = 5; // jobs par page
    let currentPage = 1;
    const totalPages = Math.ceil(jobsList.length / itemsPerPage);

    // Générer dynamiquement les numéros de page
    function generatePagination() {
        pagination.innerHTML = '';

        // Précédent
        const prevLi = document.createElement('li');
        prevLi.className = 'page-item disabled';
        prevLi.innerHTML = `<a class="page-link" href="#" tabindex="-1">Précédent</a>`;
        pagination.appendChild(prevLi);

        // Numéros de pages
        for (let i = 1; i <= totalPages; i++) {
            const li = document.createElement('li');
            li.className = 'page-item';
            li.innerHTML = `<a class="page-link" href="#">${i}</a>`;
            li.querySelector('a').addEventListener('click', (e) => {
                e.preventDefault();
                showPage(i);
            });
            pagination.appendChild(li);
        }

        // Suivant
        const nextLi = document.createElement('li');
        nextLi.className = 'page-item';
        nextLi.innerHTML = `<a class="page-link" href="#">Suivant</a>`;
        pagination.appendChild(nextLi);

        // Clic Précédent
        prevLi.querySelector('a').addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage > 1) showPage(currentPage - 1);
        });

        // Clic Suivant
        nextLi.querySelector('a').addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage < totalPages) showPage(currentPage + 1);
        });
    }

    // Afficher les jobs d'une page
    function showPage(page) {
        currentPage = page;
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        jobsList.forEach((job, index) => {
            job.style.display = (index >= start && index < end) ? "block" : "none";
        });

        // Mettre à jour les classes actives et boutons
        updatePagination();
    }

    function updatePagination() {
        const pageItems = pagination.querySelectorAll('.page-item');
        pageItems.forEach((li, idx) => {
            if (idx === 0) li.classList.toggle('disabled', currentPage === 1); // Précédent
            else if (idx === pageItems.length - 1) li.classList.toggle('disabled', currentPage === totalPages); // Suivant
            else li.classList.toggle('active', idx === currentPage); // numéros
        });
    }

    generatePagination();
    showPage(1);
});