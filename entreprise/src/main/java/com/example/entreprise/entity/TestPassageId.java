package com.example.entreprise.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class TestPassageId implements Serializable {
    private Long idCandidat;
    private Long idTest;

    // Getters & Setters
    public Long getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Long idCandidat) { this.idCandidat = idCandidat; }
    public Long getIdTest() { return idTest; }
    public void setIdTest(Long idTest) { this.idTest = idTest; }
}
