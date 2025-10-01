// ======= Load Navbar =======
function loadNavbar(notificationInfo = {}) {
    let notifCount = notificationInfo.notificationCount;
    let notifications = notificationInfo.notifications;
    const navbarHtml = `
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
            <div class="d-flex align-items-center">
                <button class="btn btn-link p-0 me-3 d-md-none" id="sidebarToggleMobile">
                    <i class="bi bi-list fs-4"></i>
                </button>
                <div class="navbar-brand d-flex align-items-center logo">
                    <span class="text-primary" id="sidebarToggle">
                        <img src="/resources/img/logo.png" alt="logo" style="width: 40px; height: 40px;">
                        Talent<small>Sphere</small>
                    </span>
                </div>
            </div>

            <div class="d-flex align-items-center gap-3">
                <!-- Notifications -->
                <div class="dropdown">
                    <button class="notification-btn" type="button" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                        ${notifCount != 0 ? `<span class="notification-badge">${notifCount}</span>` : ""}
                    </button>
                    <div class="dropdown-menu dropdown-menu-end" style="width: 320px;">
                        <div class="dropdown-header d-flex justify-content-between align-items-center">
                            <span>Notifications</span>
                            <button class="btn btn-link btn-sm text-primary p-0" onclick="markAllRead()">Tout marquer comme lu</button>
                        </div>
                        <div class="dropdown-divider"></div>
                        ${notifications.map(n => `
                        <a class="dropdown-item py-3" href="#">
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;">
                                        <i class="bi bi-info-circle"></i>
                                    </div>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <p class="mb-0 small text-muted text-wrap">${n.message}</p>
                                    <small class="text-muted">${timeAgo(new Date(n.createdAt))}</small>
                                </div>
                            </div>
                        </a>
                        `).join('')}
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item text-center text-primary" href="#">Voir toutes les notifications</a>
                    </div>
                </div>

                <!-- User Dropdown -->
                <div class="dropdown">
                    <div class="user-avatar text-white d-flex align-items-center" 
                         style="background-color: ${currentUser.avatar}; width: 40px; height: 40px; justify-content:center; align-items:center; border-radius:50%; cursor:pointer;" 
                         data-bs-toggle="dropdown">
                        ${currentUser.initials}
                    </div>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <div class="dropdown-item-text">
                                <div class="d-flex align-items-center">
                                    <div class="user-avatar text-white me-3" style="background-color: ${currentUser.avatar}; width: 40px; height: 40px; border-radius:50%; display:flex; align-items:center; justify-content:center;">
                                        ${currentUser.initials}
                                    </div>
                                    <div>
                                        <h6 class="mb-0">${currentUser.name}</h6>
                                        <small class="text-muted">${currentUser.poste || 'Candidat'}</small>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Mon profil</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Paramètres</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-question-circle me-2"></i>Aide</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="/logout"><i class="bi bi-box-arrow-right me-2"></i>Se déconnecter</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    `;

    document.getElementById('navbar-placeholder').innerHTML = navbarHtml;
}

// ======= Load Sidebar =======
function loadSidebar() {
    const currentPage = window.location.pathname.split('/').pop() || 'dashboard.html';
    let sidebarHtml = `
        <aside class="sidebar" id="sidebar">
            <nav class="sidebar-nav">`;
    if (currentUser.poste != 'null') {
        sidebarHtml = `
                <a href="dashboard.html" class="nav-link ${currentPage === 'dashboard.html' ? 'active' : ''}">
                    <i class="bi bi-speedometer2"></i><span>Tableau de bord</span>
                </a>
    `;
    }
    if (currentUser.poste == 'null') {
        sidebarHtml += `
        <div class="nav-section mt-3">
            <small class="text-muted px-3 text-uppercase fw-semibold title">Espace candidat</small>
            <a href="cv-submission.html" class="nav-link ${currentPage === 'cv-submission.html' ? 'active' : ''}">
                <i class="bi bi-file-person"></i><span>Déposer un CV</span>
            </a>
            <a href="job-listings.html" class="nav-link ${currentPage === 'job-listings.html' ? 'active' : ''}">
                <i class="bi bi-search"></i><span>Offres d'emploi</span>
            </a>
            <a href="online-test.html" class="nav-link ${currentPage === 'online-test.html' ? 'active' : ''}">
                <i class="bi bi-clipboard-check"></i><span>Passer un test</span>
            </a>
            <a href="candidates.html" class="nav-link ${currentPage === 'candidates.html' ? 'active' : ''}">
                <i class="bi bi-people"></i><span>Annuaire candidats</span>
            </a>
        </div>
    `;

        // Section recruteur / employé
    } else {
        sidebarHtml += `
        <div class="nav-section mt-3">
            <small class="text-muted px-3 text-uppercase fw-semibold title">Espace recruteur</small>
            <a href="manage-jobs.html" class="nav-link ${currentPage === 'manage-jobs.html' ? 'active' : ''}"><i class="bi bi-briefcase"></i><span>Gérer les annonces</span></a>
            <a href="create-test.html" class="nav-link ${currentPage === 'create-test.html' ? 'active' : ''}"><i class="bi bi-file-earmark-plus"></i><span>Créer un test</span></a>
            <a href="validation-list.html" class="nav-link ${currentPage === 'validation-list.html' ? 'active' : ''}"><i class="bi bi-check-circle"></i><span>Valider candidats</span></a>
        </div>
        <div class="nav-section mt-3">
            <small class="text-muted px-3 text-uppercase fw-semibold title">Entretiens</small>
            <a href="interview-planning.html" class="nav-link ${currentPage === 'interview-planning.html' ? 'active' : ''}"><i class="bi bi-calendar3"></i><span>Planning entretiens</span></a>
            <a href="interview-evaluation.html" class="nav-link ${currentPage === 'interview-evaluation.html' ? 'active' : ''}"><i class="bi bi-star"></i><span>Noter entretien</span></a>
        </div>
        <div class="nav-section mt-3">
            <small class="text-muted px-3 text-uppercase fw-semibold title">Employés</small>
            <a href="trial-employees.html" class="nav-link ${currentPage === 'trial-employees.html' ? 'active' : ''}"><i class="bi bi-hourglass-split"></i><span>Période d'essai</span></a>
            <a href="trial-contract.html" class="nav-link ${currentPage === 'trial-contract.html' ? 'active' : ''}"><i class="bi bi-file-earmark-text"></i><span>Contrat d'essai</span></a>
        </div>
        `;
    }

    sidebarHtml += `</nav></aside>`;
    document.getElementById('sidebar-placeholder').innerHTML = sidebarHtml;
}

// ======= Utility =======

// Convert date to "x minutes/heure/jours ago"
function timeAgo(date) {
    const now = new Date();
    const diff = Math.floor((now - date) / 1000); // seconds
    if (diff < 60) return `${diff} sec`;
    if (diff < 3600) return `${Math.floor(diff / 60)} min`;
    if (diff < 86400) return `${Math.floor(diff / 3600)} h`;
    return `${Math.floor(diff / 86400)} j`;
}

// Mark all notifications as read (example placeholder)
function markAllRead() {
    document.querySelectorAll('.notification-badge').forEach(b => b.textContent = '0');
}

// ======= Initialize =======
fetch(`/api/notifications?id_utilisateur=${currentUser.id}`)
    .then(res => res.json())
    .then(data => {
        loadNavbar(data);
        loadSidebar();
    })
    .catch(() => {
        loadNavbar([]);
        loadSidebar();
    });


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

