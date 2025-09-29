// TalentSphere Application JavaScript

// Global variables
let currentUser = {
    name: 'Marie Dubois',
    initials: 'MD',
    avatar: '#0d3b56',
    notifications: 5
};

// Load Navbar
function loadNavbar() {
    const navbarHtml = `
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container-fluid">
                <!-- Brand -->
                <div class="d-flex align-items-center">
                    <button class="btn btn-link p-0 me-3 d-md-none" id="sidebarToggleMobile">
                        <i class="bi bi-list fs-4"></i>
                    </button>
                    <div class="navbar-brand d-flex align-items-center logo">
                        <span class="text-primary" id="sidebarToggle"><img src="img/logo.png" alt="logo" style="width: 40px; height: 40px;">Talent<small>Sphere<small></span>
                    </div>
                </div>

                <!-- Right side items -->
                <div class="d-flex align-items-center gap-3">
                    <!-- Notifications -->
                    <div class="dropdown">
                        <button class="notification-btn" type="button" data-bs-toggle="dropdown">
                            <i class="bi bi-bell"></i>
                            <span class="notification-badge">${currentUser.notifications}</span>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" style="width: 320px;">
                            <div class="dropdown-header d-flex justify-content-between align-items-center">
                                <span>Notifications</span>
                                <button class="btn btn-link btn-sm text-primary p-0">Tout marquer comme lu</button>
                            </div>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item py-3" href="#">
                                <div class="d-flex">
                                    <div class="flex-shrink-0">
                                        <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;">
                                            <i class="bi bi-person-plus"></i>
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-1">Nouvelle candidature</h6>
                                        <p class="mb-0 small text-muted text-wrap">Paul Martin a postulé pour le poste de développeur</p>
                                        <small class="text-muted">Il y a 2 heures</small>
                                    </div>
                                </div>
                            </a>
                            <a class="dropdown-item py-3" href="#">
                                <div class="d-flex">
                                    <div class="flex-shrink-0">
                                        <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;">
                                            <i class="bi bi-calendar-check"></i>
                                        </div>
                                    </div>
                                    <div class="flex-grow-1 ms-3">
                                        <h6 class="mb-1">Entretien confirmé</h6>
                                        <p class="mb-0 small text-muted text-wrap">L'entretien avec Sophie est confirmé pour demain</p>
                                        <small class="text-muted">Il y a 4 heures</small>
                                    </div>
                                </div>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item text-center text-primary" href="#">Voir toutes les notifications</a>
                        </div>
                    </div>

                    <!-- User Dropdown -->
                    <div class="dropdown">
                        <div class="user-avatar text-white d-flex align-items-center" 
                             style="background-color: ${currentUser.avatar};" 
                             data-bs-toggle="dropdown" 
                             role="button">
                            ${currentUser.initials}
                        </div>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <div class="dropdown-item-text">
                                    <div class="d-flex align-items-center">
                                        <div class="user-avatar text-white me-3" style="background-color: ${currentUser.avatar};">
                                            ${currentUser.initials}
                                        </div>
                                        <div>
                                            <h6 class="mb-0">${currentUser.name}</h6>
                                            <small class="text-muted">Recruteur Senior</small>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Mon profil</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Paramètres</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-question-circle me-2"></i>Aide</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="index.html"><i class="bi bi-box-arrow-right me-2"></i>Se déconnecter</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    `;

    document.getElementById('navbar-placeholder').innerHTML = navbarHtml;
}

// Load Sidebar
function loadSidebar() {
    const currentPage = window.location.pathname.split('/').pop() || 'dashboard.html';

    const sidebarHtml = `
        <aside class="sidebar" id="sidebar">
            <nav class="sidebar-nav">
                <a href="dashboard.html" class="nav-link ${currentPage === 'dashboard.html' ? 'active' : ''}">
                    <i class="bi bi-speedometer2"></i>
                    <span>Tableau de bord</span>
                </a>
                
                <div class="nav-section mt-3">
                    <small class="text-muted px-3 text-uppercase fw-semibold title">Candidats</small>
                    <a href="cv-submission.html" class="nav-link ${currentPage === 'cv-submission.html' ? 'active' : ''}">
                        <i class="bi bi-file-person"></i>
                        <span>Déposer un CV</span>
                    </a>
                    <a href="job-listings.html" class="nav-link ${currentPage === 'job-listings.html' ? 'active' : ''}">
                        <i class="bi bi-search"></i>
                        <span>Offres d'emploi</span>
                    </a>
                    <a href="online-test.html" class="nav-link ${currentPage === 'online-test.html' ? 'active' : ''}">
                        <i class="bi bi-clipboard-check"></i>
                        <span>Passer un test</span>
                    </a>
                    <a href="candidates.html" class="nav-link ${currentPage === 'candidates.html' ? 'active' : ''}">
                        <i class="bi bi-people"></i>
                        <span>Annuaire candidats</span>
                    </a>
                </div>
                
                <div class="nav-section mt-3">
                    <small class="text-muted px-3 text-uppercase fw-semibold title">Recrutement</small>
                    <a href="manage-jobs.html" class="nav-link ${currentPage === 'manage-jobs.html' ? 'active' : ''}">
                        <i class="bi bi-briefcase"></i>
                        <span>Gérer les annonces</span>
                    </a>
                    <a href="create-test.html" class="nav-link ${currentPage === 'create-test.html' ? 'active' : ''}">
                        <i class="bi bi-file-earmark-plus"></i>
                        <span>Créer un test</span>
                    </a>
                    <a href="validation-list.html" class="nav-link ${currentPage === 'validation-list.html' ? 'active' : ''}">
                        <i class="bi bi-check-circle"></i>
                        <span>Valider candidats</span>
                    </a>
                </div>
                
                <div class="nav-section mt-3">
                    <small class="text-muted px-3 text-uppercase fw-semibold title">Entretiens</small>
                    <a href="interview-planning.html" class="nav-link ${currentPage === 'interview-planning.html' ? 'active' : ''}">
                        <i class="bi bi-calendar3"></i>
                        <span>Planning entretiens</span>
                    </a>
                    <a href="interview-evaluation.html" class="nav-link ${currentPage === 'interview-evaluation.html' ? 'active' : ''}">
                        <i class="bi bi-star"></i>
                        <span>Noter entretien</span>
                    </a>
                </div>
                
                <div class="nav-section mt-3">
                    <small class="text-muted px-3 text-uppercase fw-semibold title">Employés</small>
                    <a href="trial-employees.html" class="nav-link ${currentPage === 'trial-employees.html' ? 'active' : ''}">
                        <i class="bi bi-hourglass-split"></i>
                        <span>Période d'essai</span>
                    </a>
                    <a href="trial-contract.html" class="nav-link ${currentPage === 'trial-contract.html' ? 'active' : ''}">
                        <i class="bi bi-file-earmark-text"></i>
                        <span>Contrat d'essai</span>
                    </a>
                </div>
            </nav>
        </aside>
    `;

    document.getElementById('sidebar-placeholder').innerHTML = sidebarHtml;

    // Initialize sidebar functionality
    initializeSidebar();
}

// Initialize Sidebar
function initializeSidebar() {
    const sidebar = document.getElementById('sidebar');
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebarToggleMobile = document.getElementById('sidebarToggleMobile');

    // Desktop toggle
    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');

            document.querySelectorAll('.title').forEach(item => {
                if (sidebar.classList.contains('collapsed')) {
                    item.style.display = 'none';
                } else {
                    item.style.display = ''; // revient au style CSS normal
                }
            });
        });
    }


    // Mobile toggle
    if (sidebarToggleMobile) {
        sidebarToggleMobile.addEventListener('click', () => {
            sidebar.classList.toggle('show');
        });
    }

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', (e) => {
        if (window.innerWidth <= 768) {
            const sidebar = document.getElementById('sidebar');
            const sidebarToggleMobile = document.getElementById('sidebarToggleMobile');

            if (sidebar && !sidebar.contains(e.target) && !sidebarToggleMobile?.contains(e.target)) {
                sidebar.classList.remove('show');
            }
        }
    });
}

// Utility Functions
function showToast(message, type = 'success') {
    const toastHtml = `
        <div class="toast align-items-center text-white bg-${type} border-0" role="alert">
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    `;

    let toastContainer = document.querySelector('.toast-container');
    if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
        document.body.appendChild(toastContainer);
    }

    toastContainer.innerHTML = toastHtml;
    const toast = new bootstrap.Toast(toastContainer.querySelector('.toast'));
    toast.show();
}

function showModal(title, content, actions = '') {
    const modalHtml = `
        <div class="modal fade" id="dynamicModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">${title}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        ${content}
                    </div>
                    <div class="modal-footer">
                        ${actions || '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>'}
                    </div>
                </div>
            </div>
        </div>
    `;

    // Remove existing modal
    const existingModal = document.getElementById('dynamicModal');
    if (existingModal) {
        existingModal.remove();
    }

    document.body.insertAdjacentHTML('beforeend', modalHtml);
    const modal = new bootstrap.Modal(document.getElementById('dynamicModal'));
    modal.show();
}

function formatDate(date) {
    return new Intl.DateTimeFormat('fr-FR').format(new Date(date));
}

function formatDateTime(date) {
    return new Intl.DateTimeFormat('fr-FR', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    }).format(new Date(date));
}

// Form validation
function validateForm(form) {
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.classList.add('is-invalid');
            isValid = false;
        } else {
            input.classList.remove('is-invalid');
            input.classList.add('is-valid');
        }
    });

    return isValid;
}

// Initialize tooltips and popovers
function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });
}

// Auto-resize textareas
function autoResizeTextarea(textarea) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight + 'px';
}

// Initialize auto-resize for all textareas
function initializeAutoResize() {
    const textareas = document.querySelectorAll('textarea[data-auto-resize]');
    textareas.forEach(textarea => {
        textarea.addEventListener('input', () => autoResizeTextarea(textarea));
        autoResizeTextarea(textarea); // Initial resize
    });
}

// Search functionality
function initializeSearch(searchInput, searchableItems, searchFields) {
    searchInput.addEventListener('input', (e) => {
        const query = e.target.value.toLowerCase();

        searchableItems.forEach(item => {
            const searchText = searchFields.map(field => {
                const element = item.querySelector(field);
                return element ? element.textContent.toLowerCase() : '';
            }).join(' ');

            if (searchText.includes(query)) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    });
}

// Loading state management
function setLoadingState(element, loading = true) {
    if (loading) {
        element.classList.add('loading');
        element.disabled = true;
    } else {
        element.classList.remove('loading');
        element.disabled = false;
    }
}

// Initialize app on DOM content loaded
document.addEventListener('DOMContentLoaded', function () {
    initializeTooltips();
    initializeAutoResize();

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});

