const languagesContainer = document.getElementById('languagesTags');

function renderTagsLang(items, container) {
    container.innerHTML = '';
    items.forEach((item, index) => {
        const tag = document.createElement('div');
        tag.className = 'tag';
        tag.dataset.id = item.id;
        tag.innerHTML = `${item.label} <span class="remove-tag">&times;</span>`;

        tag.querySelector('.remove-tag').addEventListener('click', () => {
            items.splice(index, 1);
            renderTagsLang(items, container);
        });

        container.appendChild(tag);
    });
}

document.getElementById('addLanguageBtn').addEventListener('click', () => {
    const select = document.getElementById('languageSelect');
    const value = select.value;
    const label = select.options[select.selectedIndex].text;

    if (!value || languages.some(l => l.id === value)) return;

    languages.push({ id: value, label });
    renderTagsLang(languages, languagesContainer);
});
