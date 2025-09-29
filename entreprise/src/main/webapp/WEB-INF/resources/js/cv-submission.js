document.addEventListener('DOMContentLoaded', function() {
    initializeFileUploads();
});

function initializeFileUploads() {
    const photoInput = document.getElementById('photoInput');
    const photoPreview = document.getElementById('photoPreview');
    
    // Photo upload
    photoInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                photoPreview.innerHTML = `<img src="${e.target.result}" alt="Photo" style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">`;
            };
            reader.readAsDataURL(file);
        }
    });
}


function addTag(selectId, containerId) {
    const select = document.getElementById(selectId);
    const container = document.getElementById(containerId);
    const value = select.value;

    if (!value) return;

    // Vérifier doublon
    if ([...container.children].some(tag => tag.dataset.value === value)) return;

    const tag = document.createElement('div');
    tag.className = 'tag';
    tag.dataset.value = value;
    tag.innerHTML = `${value} <span class="remove-tag">&times;</span>`;

    // Supprimer tag
    tag.querySelector('.remove-tag').addEventListener('click', () => tag.remove());

    container.appendChild(tag);
}

// Boutons ajouter
document.getElementById('addSkillBtn').addEventListener('click', () => addTag('skillSelect', 'skillsTags'));
document.getElementById('addLanguageBtn').addEventListener('click', () => addTag('languageSelect', 'languagesTags'));
