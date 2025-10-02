package com.example.entreprise.dto;

import java.util.List;

public class QuestionDTO {
    private String enonce;
    private Integer point;
    private List<ReponseDTO> reponses;

    // getters & setters
    public String getEnonce() { return enonce; }
    public void setEnonce(String enonce) { this.enonce = enonce; }
    public Integer getPoint() { return point; }
    public void setPoint(Integer point) { this.point = point; }
    public List<ReponseDTO> getReponses() { return reponses; }
    public void setReponses(List<ReponseDTO> reponses) { this.reponses = reponses; }
}