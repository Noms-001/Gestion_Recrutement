package com.example.entreprise.repository;

import com.example.entreprise.entity.TestPassage;
import com.example.entreprise.entity.TestPassageId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestPassageRepository extends JpaRepository<TestPassage, TestPassageId> {
}
