package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class AnnonceCompetenceId implements Serializable {

    private Long idAnnonce;
    private Long idCompetence;

    public AnnonceCompetenceId() {
    }

    public AnnonceCompetenceId(Long idAnnonce, Long idCompetence) {
        this.idAnnonce = idAnnonce;
        this.idCompetence = idCompetence;
    }

    // getters et setters
    public Long getIdAnnonce() {
        return idAnnonce;
    }

    public void setIdAnnonce(Long idAnnonce) {
        this.idAnnonce = idAnnonce;
    }

    public Long getIdCompetence() {
        return idCompetence;
    }

    public void setIdCompetence(Long idCompetence) {
        this.idCompetence = idCompetence;
    }

    // equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (!(o instanceof AnnonceCompetenceId))
            return false;
        AnnonceCompetenceId that = (AnnonceCompetenceId) o;
        return Objects.equals(idAnnonce, that.idAnnonce) &&
                Objects.equals(idCompetence, that.idCompetence);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idAnnonce, idCompetence);
    }
}
