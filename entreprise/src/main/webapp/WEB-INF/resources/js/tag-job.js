function addTag(type) {
    const select = document.getElementById(type);
    const container = document.getElementById(type + 'Container');
    const value = select.value;
    const text = select.options[select.selectedIndex]?.text;

    if (!value) return;

    // éviter doublons
    if (container.querySelector(`[data-value="${value}"]`)) return;

    const tag = document.createElement('span');
    tag.className = "badge bg-light text-dark border d-flex align-items-center";
    tag.dataset.value = value;
    tag.innerHTML = text + ` <i class="bi bi-x ms-2" style="cursor:pointer;" onclick="this.parentElement.remove()"></i>`;

    container.appendChild(tag);

    // réinitialiser le select
    select.value = '';
}