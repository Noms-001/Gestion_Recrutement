package com.example.entreprise.repository;

import com.example.entreprise.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {
    Optional<Question> findFirstByEnonce(String enonce);
}
