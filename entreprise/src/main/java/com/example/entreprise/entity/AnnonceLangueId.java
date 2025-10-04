package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class AnnonceLangueId implements Serializable {

    private Long idAnnonce;
    private Integer idLangue;

    public AnnonceLangueId() {}

    public AnnonceLangueId(Long idAnnonce, Integer idLangue) {
        this.idAnnonce = idAnnonce;
        this.idLangue = idLangue;
    }

    // getters et setters
    public Long getIdAnnonce() { return idAnnonce; }
    public void setIdAnnonce(Long idAnnonce) { this.idAnnonce = idAnnonce; }
    public Integer getIdLangue() { return idLangue; }
    public void setIdLangue(Integer idLangue) { this.idLangue = idLangue; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AnnonceLangueId)) return false;
        AnnonceLangueId that = (AnnonceLangueId) o;
        return Objects.equals(idAnnonce, that.idAnnonce) && Objects.equals(idLangue, that.idLangue);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idAnnonce, idLangue);
    }
}
