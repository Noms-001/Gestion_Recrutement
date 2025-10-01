package com.example.entreprise.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
    
    @GetMapping("/create-test")
    public String showCreateTestPage() {
        return "create-test";
    }
}
