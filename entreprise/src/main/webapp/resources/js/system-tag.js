function setupTagSystem(selectId, containerId) {
    const select = document.getElementById(selectId);
    const container = document.getElementById(containerId);

    function addTag(value, text) {
        // éviter doublons
        if (container.querySelector(`[data-value="${value}"]`)) return;

        const badge = document.createElement("span");
        badge.className = "badge bg-primary me-2 mb-2";
        badge.setAttribute("data-value", value);
        badge.innerHTML = text +
            ' <i class="bi bi-x-circle ms-1" style="cursor:pointer"></i>';

        badge.querySelector("i").addEventListener("click", () => {
            badge.remove();
        });

        container.appendChild(badge);
    }

    select.addEventListener("change", () => {
        const selectedOption = select.options[select.selectedIndex];
        if (selectedOption && selectedOption.value !== "") {
            addTag(selectedOption.value, selectedOption.text);
        }
        // remettre le select à vide (option par défaut)
        select.selectedIndex = 0;
    });

    return container;
}

// Activer le système pour Ville, Compétences, Langues
const cityTags = setupTagSystem("cityFilter", "cityTags");
const skillsTags = setupTagSystem("skillsFilter", "skillsTags");
const langsTags = setupTagSystem("langsFilter", "langsTags");

// Capter le reset du formulaire
document.querySelector("form").addEventListener("reset", () => {
    cityTags.innerHTML = "";
    skillsTags.innerHTML = "";
    langsTags.innerHTML = "";
});
