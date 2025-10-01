const startInput = document.getElementById('startMonth');
const endInput = document.getElementById('endMonth');
const companyInput = document.getElementById('company');
const fieldInput = document.getElementById('field'); 
const descInput = document.getElementById('description');
const preview = document.getElementById('previewContainer');
let editIndex = -1;

function formatMonthYear(value) {
    const [year, month] = value.split('-');
    const monthNames = ['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre'];
    return `${monthNames[parseInt(month,10)-1]} ${year}`;
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
                <strong>${exp.company}</strong> (${exp.fieldLabel})<br>
                ${formatMonthYear(exp.start)} - ${formatMonthYear(exp.end)}<br>
                <small>${exp.description}</small>
            </div>
            <div>
                <button class="btn btn-sm btn-outline-danger remove-exp"><i class="bi bi-trash"></i></button>
                <button class="btn btn-sm btn-outline-primary edit-exp"><i class="bi bi-pencil"></i></button>
            </div>
        `;
        preview.appendChild(item);

        item.querySelector('.remove-exp').addEventListener('click', () => {
            experiences.splice(index, 1);
            renderExperiences();
        });

        item.querySelector('.edit-exp').addEventListener('click', () => {
            startInput.value = exp.start;
            endInput.value = exp.end;
            companyInput.value = exp.company;
            fieldInput.value = exp.field;
            descInput.value = exp.description;
            experiences.splice(index, 1);
            renderExperiences();
        });
    });
}

document.getElementById('addExperience').addEventListener('click', function () {
    const start = startInput.value;
    const end = endInput.value;
    const company = companyInput.value.trim();
    const field = fieldInput.value;
    const fieldLabel = fieldInput.options[fieldInput.selectedIndex].text;
    const description = descInput.value.trim();

    if (!start || !end || !company || !field) {
        alert("Veuillez remplir tous les champs obligatoires (dates, entreprise, filière).");
        return;
    }



    const expData = { start, end, company, field, fieldLabel, description };

    if (editIndex === -1) {
        experiences.push(expData);
    } else {
        experiences[editIndex] = expData;
        editIndex = -1;
    }

    renderExperiences();

    startInput.value = '';
    endInput.value = '';
    companyInput.value = '';
    fieldInput.value = '';
    descInput.value = '';
});
