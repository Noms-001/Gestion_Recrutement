package com.example.entreprise.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.entreprise.dto.QuestionDTO;
import com.example.entreprise.dto.TestDTO;
import com.example.entreprise.entity.Test;
import com.example.entreprise.service.TestService;

@RestController
@RequestMapping("/tests")
public class CreateTestController {
    private final TestService testService;

    public CreateTestController(TestService testService) {
        this.testService = testService;
    }

    @PostMapping
    public ResponseEntity<Test> createTest(@RequestBody TestDTO dto) {
        Test saved = testService.createTest(dto);
        return ResponseEntity.ok(saved);
    }

    @GetMapping
    public List<Test> getAllTests() {
        return testService.getAllTests();
    }

    @GetMapping("/questions")
    public List<QuestionDTO> getAllQuestions() {
        return testService.getAllQuestionsDTO();
    }

}
