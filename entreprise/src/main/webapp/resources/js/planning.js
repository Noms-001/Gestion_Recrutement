let interviews = [];
let currentDate = new Date();

async function fetchInterviews() {
    try {
        const response = await fetch('/api/entretiens');
        if (!response.ok) throw new Error('Erreur serveur');
        interviews = await response.json();
        generateCalendar(currentDate);
    } catch (error) {
        console.error('Erreur lors du chargement des entretiens:', error);
        const eventsList = document.getElementById('events-list');
        if (eventsList) {
            eventsList.innerHTML = '<p style="color: red;">Impossible de charger les entretiens.</p>';
        }
    }
}

function generateCalendar(date) {
    const calendarDays = document.getElementById('calendarDays');
    const calendarWeekdays = document.getElementById('calendarWeekdays');
    calendarDays.innerHTML = '';
    calendarWeekdays.innerHTML = '';

    const monthYear = document.getElementById('monthYear');
    const monthNames = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
    const weekdayNames = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"];

    monthYear.textContent = `${monthNames[date.getMonth()]} ${date.getFullYear()}`;

    // 🗓️ Afficher les noms des jours de la semaine
    weekdayNames.forEach(day => {
        const wd = document.createElement('div');
        wd.textContent = day;
        wd.classList.add('weekday');
        calendarWeekdays.appendChild(wd);
    });

    // ⚙️ Calcul du premier jour et du nombre de jours
    let firstDay = new Date(date.getFullYear(), date.getMonth(), 1).getDay();
    if (firstDay === 0) firstDay = 7; // Ajuster dimanche -> 7 pour alignement avec Lundi

    const daysInMonth = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();

    // Espaces avant le 1er
    for (let i = 1; i < firstDay; i++) {
        const emptyDay = document.createElement('div');
        calendarDays.appendChild(emptyDay);
    }

    // Jours du mois
    for (let d = 1; d <= daysInMonth; d++) {
        const dayDiv = document.createElement('div');
        dayDiv.classList.add('day');
        const fullDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
        dayDiv.textContent = d;

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
                <span class="evaluator"><small><i class="bi bi-briefcase"></i> ${ev.annonce}</small></span>
                <span class="evaluator"><strong>Évaluateur:</strong> ${ev.evaluator}</span>
            </div>
            <div class="time-badge">${ev.time}</div>
        `;
        eventsList.appendChild(div);
    });
}

// Navigation mois
document.getElementById('prevMonth').addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() - 1);
    generateCalendar(currentDate);
});

document.getElementById('nextMonth').addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() + 1);
    generateCalendar(currentDate);
});

// Initialisation
fetchInterviews();
