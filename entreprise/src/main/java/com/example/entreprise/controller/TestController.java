package com.example.entreprise.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.entreprise.entity.Question;
import com.example.entreprise.service.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class TestController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private TestService testService;
    
    @GetMapping("/create-test")
    public String showCreateTestPage(Model model) {
        List<Question> questions = questionService.findAll();
        model.addAttribute("questions", questions);
        return "create-test";
    }

    @PostMapping("/online-test") 
    public String showTest(@RequestParam(value = "annonceId", required = true) Long annonceId, @RequestParam(value = "testId", required = true) Long testId, HttpSession session) {
        Long utilisateurId = (Long) session.getAttribute("id_utilisateur"); 
        if (utilisateurId == null) {
            return "redirect:/login";
        }
        try {
            testService.demarrerTest(utilisateurId, annonceId);
        } catch(Exception e) {

        }
        return "online-test";
    }

}