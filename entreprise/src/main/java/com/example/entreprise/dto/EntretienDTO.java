package com.example.entreprise.dto;

public class EntretienDTO {
    private String date;
    private String candidate;
    private String evaluator;
    private String annonce;
    private String time;
    private String photo;

    public EntretienDTO(String date, String candidate, String evaluator, String annonce, String time, String photo) {
        this.date = date;
        this.candidate = candidate;
        this.evaluator = evaluator;
        this.annonce = annonce;
        this.time = time;
        this.photo = photo;
    }

    // Getters & Setters
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCandidate() {
        return candidate;
    }

    public void setCandidate(String candidate) {
        this.candidate = candidate;
    }

    public String getEvaluator() {
        return evaluator;
    }

    public void setEvaluator(String evaluator) {
        this.evaluator = evaluator;
    }

    public String getAnnonce() {
        return annonce;
    }

    public void setAnnonce(String annonce) {
        this.annonce = annonce;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
