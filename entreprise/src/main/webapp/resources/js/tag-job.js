function addTag(type) {
    const select = document.getElementById(type);
    const container = document.getElementById(type + 'Container');
    const value = select.value;
    const text = select.options[select.selectedIndex]?.text;

    if (!value) return;

    // éviter doublons
    if (container.querySelector(`[data-value="${value}"]`)) return;

    // conteneur du tag
    const tag = document.createElement('div');
    tag.className = "border bg-light text-dark rounded p-2 mb-1";
    tag.dataset.value = value;

    // ligne principale
    const row = document.createElement('div');
    row.className = "d-flex align-items-center justify-content-between";

    // texte
    const spanText = document.createElement('span');
    spanText.textContent = text;

    // bloc actions
    const actions = document.createElement('div');
    actions.className = "d-flex align-items-center";

    // toggle switch avec tooltip
    const toggleWrapper = document.createElement('div');
    toggleWrapper.className = "form-check form-switch m-0 p-0";
    toggleWrapper.style.marginRight = "8px";

    const toggle = document.createElement('input');
    toggle.type = "checkbox";
    toggle.name = type === 'technicalSkills' ? 'competencesObligatoires[]' : 'languesObligatoires[]';
    toggle.className = "form-check-input";
    toggle.setAttribute("data-bs-html", "true");
    toggle.setAttribute("title", '<i class="bi bi-info-circle"></i> Spécifie si c\'est obligatoire');
    toggleWrapper.appendChild(toggle);

    // hidden input pour le formulaire
    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = type === 'technicalSkills' ? 'competences[]' : 'langues[]';
    hiddenInput.value = value;

    // bouton suppression
    const closeIcon = document.createElement('i');
    closeIcon.className = "bi bi-x";
    closeIcon.style.cursor = "pointer";
    closeIcon.addEventListener('click', () => {
        tag.remove();          // supprime le tag visuel
        hiddenInput.remove();  // supprime le hidden input
    });

    // actions = switch + croix
    actions.appendChild(toggleWrapper);
    actions.appendChild(closeIcon);

    // ligne principale
    row.appendChild(spanText);
    row.appendChild(actions);

    // assembler
    tag.appendChild(row);
    container.appendChild(tag);
    container.appendChild(hiddenInput); // ajoute hidden input dans le container

    // reset select
    select.value = '';

    // ⚡️ activer le tooltip pour ce switch
    new bootstrap.Tooltip(toggle);
}
