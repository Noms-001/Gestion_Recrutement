const skillsContainer = document.getElementById('skillsTags');

function renderTags(items, container) {
    container.innerHTML = '';
    items.forEach((item, index) => {
        const tag = document.createElement('div');
        tag.className = 'tag';
        tag.dataset.id = item.id;
        tag.innerHTML = `${item.label} <span class="remove-tag">&times;</span>`;

        tag.querySelector('.remove-tag').addEventListener('click', () => {
            items.splice(index, 1);
            renderTags(items, container);
        });

        container.appendChild(tag);
    });
}

document.getElementById('addSkillBtn').addEventListener('click', () => {
    const select = document.getElementById('skillSelect');
    const value = select.value;
    const label = select.options[select.selectedIndex].text;

    if (!value || skills.some(s => s.id === value)) return;

    skills.push({ id: value, label });
    renderTags(skills, skillsContainer);
});
