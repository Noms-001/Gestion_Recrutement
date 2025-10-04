package com.example.entreprise.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.entreprise.dto.*;
import com.example.entreprise.entity.*;
import com.example.entreprise.service.*;

@RestController
@RequestMapping("/tests")
public class CreateTestController {
    @Autowired
    private TestService testService;
    
    @Autowired
    private QuestionService questionService;

    @PostMapping
    public ResponseEntity<Test> createTest(@RequestBody TestDTO dto) {
        Test saved = testService.createTest(dto);
        return ResponseEntity.ok(saved);
    }

    @GetMapping
    public List<Test> findAll() {
        return testService.findAll();
    }

    @GetMapping("/questions")
    public List<QuestionDTO> findAllDTO() {
        return questionService.findAllDTO();
    }

}
