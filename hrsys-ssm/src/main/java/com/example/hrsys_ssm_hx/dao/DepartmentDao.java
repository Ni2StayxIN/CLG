package com.example.hrsys_ssm_hx.dao;

import com.example.hrsys_ssm_hx.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DepartmentDao extends JpaRepository<Department, Integer> {
}
