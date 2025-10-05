package com.example.entreprise.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CandidatureController {
    
    @GetMapping("/candidature-succes/{$id}")
    public String showPageCandidatureSucces() {
        return "candidature-succes";
    }
}