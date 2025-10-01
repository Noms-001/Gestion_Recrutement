fetch(`/api/candidat/${utilisateurId}`)
    .then(response => {
        if (!response.ok) {
            throw new Error('Erreur lors de la récupération du CV');
        }
        return response.json();
    })
    .then(data => {
        // Construire le sampleCV depuis le JSON reçu
        const sampleCV = {
            photo: data.photo || 'resources/img/photo.png',
            prenom: data.prenom || '',
            nom: data.nom || '',
            role: data.role || 'Candidat',
            email: data.email || '',
            phone: data.phone || '',
            location: data.location || '',
            summary: data.summary || '',
            skills: data.skills || [],
            languages: data.languages || [],
            experiences: (data.experiences || []).map(exp => ({
                company: exp.company || '',
                title: exp.title || '',
                period: exp.start && exp.end ? `${exp.start} - ${exp.end}` : '',
                desc: exp.desc || ''
            })),
            education: (data.education || []).map(edu => ({
                school: edu.school || '',
                degree: edu.degree || '',
                period: edu.start && edu.end ? `${edu.start} - ${edu.end}` : ''
            }))
        };

        console.log(sampleCV);

        renderFromJson(sampleCV);
    })
    .catch(error => {
        console.error('Erreur fetch CV:', error);
    });

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
    (data.languages || []).forEach(l => { const sp = document.createElement('span'); sp.className = 'skill-pill'; sp.textContent = l; langsEl.appendChild(sp); sp.style.marginRight = "2%"});

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

document.getElementById("downloadPdf").addEventListener("click", async () => {
    const { jsPDF } = window.jspdf;
    const cvFrame = document.getElementById("cvFrame");

    // 1. Transformer le div en image (canvas)
    const canvas = await html2canvas(cvFrame, { scale: 2 }); // meilleure qualité
    const imgData = canvas.toDataURL("image/png");

    // 2. Créer le PDF
    const pdf = new jsPDF("p", "mm", "a4");

    // Adapter l'image à la largeur de la page
    const pdfWidth = pdf.internal.pageSize.getWidth();
    const pdfHeight = (canvas.height * pdfWidth) / canvas.width;

    pdf.addImage(imgData, "PNG", 0, 0, pdfWidth, pdfHeight);

    // 3. Télécharger
    pdf.save("mon-cv.pdf");
});


