package com.example.entreprise.dto;

import java.util.List;

public class VerificationResultDTO {
    private boolean eligible;
    private List<String> problemes;
    private Long candidatureId;

    // Getters & Setters
    public boolean isEligible() { return eligible; }
    public void setEligible(boolean eligible) { this.eligible = eligible; }
    
    public List<String> getProblemes() { return problemes; }
    public void setProblemes(List<String> problemes) { this.problemes = problemes; }
    
    public Long getCandidatureId() { return candidatureId; }
    public void setCandidatureId(Long candidatureId) { this.candidatureId = candidatureId; }
}