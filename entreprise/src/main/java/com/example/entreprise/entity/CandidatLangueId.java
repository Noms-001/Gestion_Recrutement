package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class CandidatLangueId implements Serializable {

    private Long idCandidat;
    private Long idLangue;

    public CandidatLangueId() {
    }

    public CandidatLangueId(Long idCandidat, Long idLangue) {
        this.idCandidat = idCandidat;
        this.idLangue = idLangue;
    }

    // getters et setters
    public Long getIdCandidat() {
        return idCandidat;
    }

    public void setIdCandidat(Long idCandidat) {
        this.idCandidat = idCandidat;
    }

    public Long getIdLangue() {
        return idLangue;
    }

    public void setIdLangue(Long idLangue) {
        this.idLangue = idLangue;
    }

    // equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (!(o instanceof CandidatLangueId))
            return false;
        CandidatLangueId that = (CandidatLangueId) o;
        return Objects.equals(idCandidat, that.idCandidat) &&
                Objects.equals(idLangue, that.idLangue);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idCandidat, idLangue);
    }
}
