package com.example.hrsys_ssm_hx.service;

import com.example.hrsys_ssm_hx.entity.Employee;
import java.util.List;

public interface EmployeeService {
    List<Employee> search(Employee condition);
    Employee searchById(Integer id);
    boolean add(Employee emp);
    boolean update(Employee emp);
    boolean delete(Integer id);
}
