const addBtn = document.getElementById('addEducation');
const previewContainer = document.getElementById('educationPreview');

addBtn.addEventListener('click', () => {
    const degree = document.getElementById('degree').value;
    const major = document.getElementById('major').value;
    const school = document.getElementById('school').value;

    if(!degree || !major || !school){
        alert('Veuillez remplir tous les champs');
        return;
    }

    const div = document.createElement('div');
    div.className = 'education-item border p-2 rounded mb-2 d-flex justify-content-between align-items-center';
    div.innerHTML = `
        <div>
            <strong>${degree}</strong> - ${major} <br>
            <small>${school}</small>
        </div>
        <div>
            <button class="btn btn-sm btn-outline-danger delete-btn"><i class="bi bi-trash"></i></button>
        </div>
    `;

    // Bouton supprimer
    div.querySelector('.delete-btn').addEventListener('click', () => {
        div.remove();
    });

    // Bouton modifier
    div.querySelector('.edit-btn').addEventListener('click', () => {
        document.getElementById('degree').value = degree;
        document.getElementById('major').value = major;
        document.getElementById('school').value = school;
        div.remove();
    });

    previewContainer.appendChild(div);

    // Reset formulaire
    document.getElementById('degree').value = '';
    document.getElementById('major').value = '';
    document.getElementById('school').value = '';
});