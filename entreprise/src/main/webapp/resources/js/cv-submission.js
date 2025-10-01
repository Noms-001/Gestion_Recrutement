let experiences = [];
let educations = [];
let skills = [];
let languages = [];

const candidatId = document.getElementById('candidatId').value; // hidden input ou data-attr


// ------------------ Fonction pour nettoyer les chaînes ------------------
function cleanString(str) {
    if (!str) return "";
    return str.toString().replace(/\\/g, "\\\\").replace(/"/g, '\\"');
}

// ------------------ Chargement du CV ------------------
async function loadCv() {
    try {
        const res = await fetch(`/api/candidat/${candidatId}/cv`);
        if (!res.ok) throw new Error("Impossible de charger le CV");

        const data = await res.json();
    
        experiences = data.experiences || [];
        educations = data.educations || [];
        skills = data.skills || [];
        languages = data.languages || [];

        renderExperiences();
        renderEducations();
        renderTags(skills, document.getElementById('skillsTags'));
        renderTagsLang(languages, document.getElementById('languagesTags'));
    } catch (e) {
        console.error(e);
    }
}

// ------------------ Envoi du CV ------------------
async function saveCv() {
    try {

        // ---- Infos personnelles ----
        const personalData = {
            nom: document.getElementById("nom").value,
            prenom: document.getElementById("prenom").value,
            email: document.getElementById("email").value,
            telephone: document.getElementById("telephone").value,
            dateNaissance: document.getElementById("dateNaissance").value, // yyyy-MM-dd
            villeId: document.getElementById("ville").value,
            adresse: document.getElementById("adresse").value
        };


        // Nettoyage des chaînes
        const safeExperiences = experiences.map(exp => ({
            start: exp.start || "",
            end: exp.end || "",
            company: cleanString(exp.company),
            field: cleanString(exp.field),
            description: cleanString(exp.description)
        }));

        const safeEducations = educations.map(ed => ({
            startYear: ed.startYear,
            endYear: ed.endYear,
            degree: cleanString(ed.degree),
            major: cleanString(ed.major),
            school: cleanString(ed.school)
        }));

        const safeSkills = skills.map(s => ({ id: s.id, label: cleanString(s.label) }));
        const safeLanguages = languages.map(l => ({ id: l.id, label: cleanString(l.label) }));

        // Données à envoyer
        const payload = {
            personalData: personalData,
            experiences: safeExperiences,
            educations: safeEducations,
            skills: safeSkills,
            languages: safeLanguages
        };

        const res = await fetch(`/api/candidat/${candidatId}/cv`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });

        if (!res.ok) {
            const err = await res.json();
            alert(err.message || "Echec lors de l'enregistrement du CV");
            return;
        }

        showToast('success', 'CV sauvegardé avec succès !');
    } catch (e) {
        showToast('danger', e.message);
    }
}

// ------------------ Bouton Soumettre ------------------
const submitBtn = document.getElementById('submitCv');
if (submitBtn) {
    submitBtn.addEventListener('click', (e) => {
        e.preventDefault();
        saveCv();
    });
}

// ------------------ Initialisation ------------------
document.addEventListener('DOMContentLoaded', loadCv);
