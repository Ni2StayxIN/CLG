package com.example.hrsys_ssm_hx.dao;

import com.example.hrsys_ssm_hx.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface EmployeeDao
        extends JpaRepository<Employee, Integer>,
        JpaSpecificationExecutor<Employee> {

    @Modifying
    @Transactional
    @Query("UPDATE Employee e SET e.dep = null WHERE e.dep.id = ?1")
    void updateDepIdToNull(Integer depId);
}
