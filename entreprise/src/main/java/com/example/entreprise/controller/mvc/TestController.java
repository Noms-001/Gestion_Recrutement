package com.example.entreprise.controller.mvc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.entreprise.entity.Question;
import com.example.entreprise.service.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class TestController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private TestService testService;

    @Autowired
    private TestPassageService testPassageService;
    
    @GetMapping("/create-test")
    public String showCreateTestPage(Model model) {
        List<Question> questions = questionService.findAll();
        model.addAttribute("questions", questions);
        return "create-test";
    }

    @PostMapping("/online-test") 
    public String showTest(@RequestParam(value = "annonceId", required = true) Long annonceId,
            @RequestParam(value = "testId", required = true) Long testId, 
            RedirectAttributes redirectAttributes, 
            HttpSession session) {
        Long utilisateurId = (Long) session.getAttribute("id_utilisateur"); 
        if (utilisateurId == null) {
            return "redirect:/login";
        }
        if (testPassageService.aDejaPasseTest(utilisateurId, annonceId)) {
            redirectAttributes.addFlashAttribute("error", "Vous avez déjà postulé à cette annonce");
            return "redirect:/job-listings";
        }
        return "online-test";
    }

}