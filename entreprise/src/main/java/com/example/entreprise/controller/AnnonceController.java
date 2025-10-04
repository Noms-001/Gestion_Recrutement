package com.example.entreprise.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.entreprise.entity.Annonce;
import com.example.entreprise.service.AnnonceService;

import org.springframework.ui.Model;

@Controller
public class AnnonceController {

    @Autowired
    private AnnonceService annonceService;

    @GetMapping("/job-listings")
    public String showListJobs(Model model) {
        List<Annonce> annonces = annonceService.findAll();
        model.addAttribute("annonces", annonces);
        return "job-listings";
    }
}