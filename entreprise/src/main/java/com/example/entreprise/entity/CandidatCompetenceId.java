package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class CandidatCompetenceId implements Serializable {

    private Long idCandidat;
    private Long idCompetence;

    public CandidatCompetenceId() {
    }

    public CandidatCompetenceId(Long idCandidat, Long idCompetence) {
        this.idCandidat = idCandidat;
        this.idCompetence = idCompetence;
    }

    // getters et setters
    public Long getIdCandidat() {
        return idCandidat;
    }

    public void setIdCandidat(Long idCandidat) {
        this.idCandidat = idCandidat;
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
        if (!(o instanceof CandidatCompetenceId))
            return false;
        CandidatCompetenceId that = (CandidatCompetenceId) o;
        return Objects.equals(idCandidat, that.idCandidat) &&
                Objects.equals(idCompetence, that.idCompetence);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idCandidat, idCompetence);
    }
}
