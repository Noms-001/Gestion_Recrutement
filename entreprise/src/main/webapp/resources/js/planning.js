
// Exemple de données d'entretiens
const interviews = [
    { date: '2025-09-27', candidate: 'Alice Dupont', evaluator: 'Jean Martin', time: '10:00', photo: 'https://i.pravatar.cc/50?img=1' },
    { date: '2025-09-27', candidate: 'Bob Leroy', evaluator: 'Marie Claire', time: '14:00', photo: 'https://i.pravatar.cc/50?img=2' },
    { date: '2025-09-28', candidate: 'Charlie Dubois', evaluator: 'Paul Henry', time: '09:00', photo: 'https://i.pravatar.cc/50?img=3' }
];

let currentDate = new Date();

function generateCalendar(date) {
    const calendarDays = document.getElementById('calendarDays');
    calendarDays.innerHTML = '';

    const monthYear = document.getElementById('monthYear');
    const monthNames = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
    monthYear.textContent = `${monthNames[date.getMonth()]} ${date.getFullYear()}`;

    const firstDay = new Date(date.getFullYear(), date.getMonth(), 1).getDay();
    const daysInMonth = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();

    // Ajouter jours vides avant le 1er
    for (let i = 0; i < firstDay; i++) {
        const emptyDay = document.createElement('div');
        calendarDays.appendChild(emptyDay);
    }

    // Ajouter les jours du mois
    for (let d = 1; d <= daysInMonth; d++) {
        const dayDiv = document.createElement('div');
        dayDiv.classList.add('day');
        const fullDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
        dayDiv.textContent = d;

        // Vérifier s'il y a un entretien ce jour
        if (interviews.some(e => e.date === fullDate)) {
            dayDiv.classList.add('has-event');
        }

        dayDiv.addEventListener('click', () => {
            document.querySelectorAll('.day').forEach(el => el.classList.remove('active'));
            dayDiv.classList.add('active');
            showEvents(fullDate);
        });

        calendarDays.appendChild(dayDiv);
    }
}

function showEvents(date) {
    const eventsList = document.getElementById('events-list');
    const selectedDate = document.getElementById('date');

    // Afficher la date sélectionnée
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    selectedDate.textContent = new Date(date).toLocaleDateString('fr-FR', options);

    const events = interviews.filter(e => e.date === date);
    if (events.length === 0) {
        eventsList.innerHTML = '<p style="color: rgb(119, 160, 206);">Aucun entretien prévu.</p>';
        return;
    }

    eventsList.innerHTML = '';
    events.forEach(ev => {
        const div = document.createElement('div');
        div.classList.add('event');
        div.innerHTML = `
            <img src="${ev.photo}" alt="${ev.candidate}">
            <div class="event-info">
                <span class="candidate">${ev.candidate}</span>
                <span class="evaluator"><strong>Evaluateur:</strong> ${ev.evaluator}</span>
            </div>
            <div class="time-badge">${ev.time}</div>
        `;
        eventsList.appendChild(div);
    });
}


document.getElementById('prevMonth').addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() - 1);
    generateCalendar(currentDate);
});

document.getElementById('nextMonth').addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() + 1);
    generateCalendar(currentDate);
});

// Initialisation
generateCalendar(currentDate);
