const sampleCV = {
    photo: 'img/logo.png',
    prenom: 'Alice',
    nom: 'Dupont',
    role: 'Développeuse Frontend',
    email: 'alice.dupont@example.com',
    phone: '+33 6 12 34 56 78',
    location: 'Paris, France',
    summary: 'Développeuse passionnée avec 4 ans d\'expérience en front-end, spécialisée React et UX.',
    skills: ['JavaScript', 'React', 'TypeScript', 'CSS', 'HTML'],
    languages: ['Français', 'Anglais'],
    experiences: [
        { company: 'Startup X', title: 'Frontend Developer', period: '2021 - Présent', desc: 'Conception et développement d\'applications React.' },
        { company: 'Agence Y', title: 'Développeuse Web', period: '2019 - 2021', desc: 'Intégration front-end et optimisation performances.' }
    ],
    education: [
        { school: 'Université Z', degree: 'Master Informatique', period: '2016 - 2019' }
    ]
};

function renderFromJson(data) {
    document.getElementById('cvPhoto').src = data.photo || '';
    document.getElementById('cvName').textContent = (data.prenom ? data.prenom + ' ' : '') + (data.nom || '');
    document.getElementById('cvRole').textContent = data.role || '';
    document.getElementById('cvEmail').innerHTML = '<i class="bi bi-envelope me-2"></i>' + (data.email || '');
    document.getElementById('cvPhone').innerHTML = '<i class="bi bi-telephone me-2"></i>' + (data.phone || '');
    document.getElementById('cvLocation').innerHTML = '<i class="bi bi-geo-alt me-2"></i>' + (data.location || '');
    document.getElementById('cvSummary').textContent = data.summary || '';

    const skillsEl = document.getElementById('cvSkills'); skillsEl.innerHTML = '';
    (data.skills || []).forEach(s => { const sp = document.createElement('span'); sp.className = 'skill-pill'; sp.textContent = s; skillsEl.appendChild(sp); });

    const langsEl = document.getElementById('cvLangs'); langsEl.innerHTML = '';
    (data.languages || []).forEach(l => { const sp = document.createElement('span'); sp.className = 'skill-pill'; sp.textContent = l; langsEl.appendChild(sp); });

    const expEl = document.getElementById('cvExperience'); expEl.innerHTML = '';
    (data.experiences || []).forEach(e => {
        const div = document.createElement('div');
        div.style.marginBottom = '12px';
        div.innerHTML = `<strong>${e.title} — ${e.company}</strong><div class="job-meta">${e.period}</div><p style="margin:6px 0 0 0;color:var(--muted)">${e.desc}</p>`;
        expEl.appendChild(div);
    });

    const eduEl = document.getElementById('cvEducation'); eduEl.innerHTML = '';
    (data.education || []).forEach(ed => { const d = document.createElement('div'); d.className = 'edu-item'; d.innerHTML = `<strong>${ed.degree}</strong><div class="job-meta">${ed.school} — ${ed.period || ''}</div>`; eduEl.appendChild(d); });

}


renderFromJson(sampleCV);
