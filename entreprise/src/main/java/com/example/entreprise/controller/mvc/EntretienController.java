package com.example.entreprise.controller.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EntretienController {
    @GetMapping("/interview-planning")
    public String test () {
        return "interview-planning";
    }
}
