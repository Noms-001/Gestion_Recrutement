package com.example.entreprise.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.entreprise.entity.Question;
import com.example.entreprise.service.QuestionService;

@Controller
public class TestController {

    @Autowired
    private QuestionService questionService;
    
    @GetMapping("/create-test")
    public String showCreateTestPage(Model model) {
        List<Question> questions = questionService.findAll();
        model.addAttribute("questions", questions);
        return "create-test";
    }

}