const addEducationBtn = document.getElementById('addEducation');
const educationPreview = document.getElementById('educationPreview');

function renderEducations() {
    educationPreview.innerHTML = '';
    if (educations.length === 0) {
        educationPreview.innerHTML = '<p class="text-muted">Vos formations ajoutées apparaîtront ici.</p>';
        return;
    }

    educations.forEach((edu, index) => {
        const div = document.createElement('div');
        div.className = 'education-item border p-2 rounded mb-2 d-flex justify-content-between align-items-center';
        div.innerHTML = `
            <div>
                <strong>${edu.degreeLabel}</strong> en ${edu.majorLabel} <br>
                ${edu.startYear} - ${edu.endYear}<br>
                <small>${edu.school}</small>
            </div>
            <div>
                <button class="btn btn-sm btn-outline-danger delete-btn"><i class="bi bi-trash"></i></button>
                <button class="btn btn-sm btn-outline-primary edit-btn"><i class="bi bi-pencil"></i></button>
            </div>
        `;

        div.querySelector('.delete-btn').addEventListener('click', () => {
            educations.splice(index, 1);
            renderEducations();
        });

        div.querySelector('.edit-btn').addEventListener('click', () => {
            document.getElementById('startYear').value = edu.startYear;
            document.getElementById('endYear').value = edu.endYear;
            document.getElementById('degree').value = edu.degree;
            document.getElementById('major').value = edu.major;
            document.getElementById('school').value = edu.school;
            educations.splice(index, 1);
            renderEducations();
        });

        educationPreview.appendChild(div);
    });
}

addEducationBtn.addEventListener('click', () => {
    const startYear = document.getElementById('startYear').value;
    const endYear = document.getElementById('endYear').value;
    const degreeInput = document.getElementById('degree');
    const degree = degreeInput.value;
    const degreeLabel = degreeInput.options[degreeInput.selectedIndex].text;
    const majorInput = document.getElementById('major');
    const major = majorInput.value;
    const majorLabel = majorInput.options[majorInput.selectedIndex].text;
    const school = document.getElementById('school').value;

    if (!startYear || ! endYear || !degree || !major || !school) {
        showToast('warning', 'Veuillez remplir tous les champs');
        return;
    }

    if (startYear > endYear) {
        showToast('danger', 'L’année de début ne peut pas être supérieure à l’année de fin.');
        return;
    }


    educations.push({ startYear, endYear, degree, degreeLabel, major, majorLabel, school });
    renderEducations();

    document.getElementById('startYear').value = '1901';
    document.getElementById('endYear').value = '1901';
    document.getElementById('degree').value = '';
    document.getElementById('major').value = '';
    document.getElementById('school').value = '';
});
