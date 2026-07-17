document.addEventListener("DOMContentLoaded", () => {
    const photoInput = document.getElementById("photoInput");
    const photoPreview = document.getElementById("photoPreview");

    // upload URL: utilise window.appContext si fourni par ton JSP
    const uploadUrl = (window.appContext ? window.appContext : "") + "/api/candidat/upload-photo";

    // upload handler
    photoInput.addEventListener("change", async () => {
        if (!photoInput.files || !photoInput.files[0]) return;
        const file = photoInput.files[0];

        // preview immédiate
        const reader = new FileReader();
        reader.onload = e => {
            photoPreview.innerHTML = `<img src="${e.target.result}" 
                                           style="width:100%; height:100%; object-fit:cover; border-radius:50%;">`;
        };
        reader.readAsDataURL(file);

        // préparation et envoi
        const formData = new FormData();
        formData.append("photo", file);

        try {
            const resp = await fetch(uploadUrl, {
                method: "POST",
                body: formData,
                credentials: "same-origin" // envoie cookies de session si besoin
            });

            if (!resp.ok) {
                // essaie de récupérer message JSON si dispo
                let msg = "Erreur réseau lors de l'upload";
                try {
                    const j = await resp.json();
                    if (j && j.message) msg = j.message;
                } catch (err) { /* ignore */ }
                showToast("danger", msg);
                return;
            }

            // succès
            let json = {};
            try {
                json = await resp.json();
            } catch (err) { /* ignore parse error */ }

            const successMessage = (json && json.message) ? json.message : "Photo mise à jour !";
            showToast("success", successMessage);

            // si backend renvoie photoUrl, on peut mettre à jour src (optionnel)
            if (json && json.photoUrl) {
                // chemin relatif utilisable par le navigateur
                photoPreview.innerHTML = `<img src="${escapeHtml(json.photoUrl)}" 
                    style="width:100%; height:100%; object-fit:cover; border-radius:50%;">`;
            }
        } catch (err) {
            showToast("danger", "Erreur lors de l'upload (réseau).");
        }
    });
});
