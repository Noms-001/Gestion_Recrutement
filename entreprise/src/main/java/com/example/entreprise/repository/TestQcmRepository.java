package com.example.entreprise.repository;

import com.example.entreprise.entity.TestQcm;
import com.example.entreprise.entity.TestQcmId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestQcmRepository extends JpaRepository<TestQcm, TestQcmId> {
}
