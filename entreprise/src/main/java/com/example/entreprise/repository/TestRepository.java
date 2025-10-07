package com.example.entreprise.repository;

import com.example.entreprise.entity.Test;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface TestRepository extends JpaRepository<Test, Long> {
    
    @Query("SELECT t FROM Test t JOIN FETCH t.questions q JOIN FETCH q.questionReponses qr JOIN FETCH qr.reponse WHERE t.id = :testId")
    Optional<Test> findByIdWithQuestionsAndReponses(@Param("testId") Long testId);
}