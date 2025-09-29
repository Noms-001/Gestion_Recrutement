let experiences = [];
let editIndex = -1; // -1 signifie ajout, sinon modification d'une expérience existante

const startInput = document.getElementById('startMonth');
const endInput = document.getElementById('endMonth');
const companyInput = document.getElementById('company');
const fieldInput = document.getElementById('field');
const descInput = document.getElementById('description');
const preview = document.getElementById('previewContainer');

function formatMonthYear(value) {
    // value = "2025-01"
    const [year, month] = value.split('-'); // ["2025", "01"]

    const monthNames = [
        'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
        'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];

    const monthIndex = parseInt(month, 10) - 1; // JS index 0-11
    return `${monthNames[monthIndex]} ${year}`;
}

function renderExperiences() {
    preview.innerHTML = '';
    if (experiences.length === 0) {
        preview.innerHTML = '<p class="text-muted">Vos expériences ajoutées apparaîtront ici.</p>';
        return;
    }

    experiences.forEach((exp, index) => {
        const item = document.createElement('div');
        item.classList.add('border', 'p-3', 'rounded', 'mb-3', 'd-flex', 'justify-content-between', 'align-items-start');
        item.innerHTML = `
            <div>
                <strong>${exp.company}</strong> (${exp.field})<br>
                ${formatMonthYear(exp.start)} - ${formatMonthYear(exp.end)}<br>
                <small>${exp.description}</small>
            </div>
            <div>
                <button class="btn btn-sm btn-danger remove-exp"><i class="bi bi-trash"></i></button>
            </div>
        `;
        preview.appendChild(item);

        item.querySelector('.remove-exp').addEventListener('click', () => {
            experiences.splice(index, 1);
            renderExperiences();
        });

        item.querySelector('.edit-exp').addEventListener('click', () => {
            // Charger les données dans le formulaire
            startInput.value = exp.start;
            endInput.value = exp.end;
            companyInput.value = exp.company;
            fieldInput.value = exp.field;
            descInput.value = exp.description;
            editIndex = index;
        });
    });
}

document.getElementById('addExperience').addEventListener('click', function () {
    const start = startInput.value;
    const end = endInput.value;
    const company = companyInput.value.trim();
    const field = fieldInput.value;
    const description = descInput.value.trim();

    if (!start || !end || !company || !field) {
        alert("Veuillez remplir tous les champs obligatoires (dates, entreprise, filière).");
        return;
    }

    const expData = { start, end, company, field, description };

    if (editIndex === -1) {
        experiences.push(expData); // Ajouter
    } else {
        experiences[editIndex] = expData; // Modifier
        editIndex = -1;
    }

    renderExperiences();

    // Réinitialiser le formulaire
    startInput.value = '';
    endInput.value = '';
    companyInput.value = '';
    fieldInput.value = '';
    descInput.value = '';
});