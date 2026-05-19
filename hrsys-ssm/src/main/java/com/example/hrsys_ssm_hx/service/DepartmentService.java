package com.example.hrsys_ssm_hx.service;

import com.example.hrsys_ssm_hx.entity.Department;
import java.util.List;

public interface DepartmentService {
    List<Department> search();
    Department searchById(Integer id);
    boolean add(Department dep);
    boolean update(Department dep);
    boolean delete(Integer id);
}