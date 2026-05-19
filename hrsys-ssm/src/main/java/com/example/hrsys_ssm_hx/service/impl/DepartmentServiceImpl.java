package com.example.hrsys_ssm_hx.service.impl;

import com.example.hrsys_ssm_hx.dao.DepartmentDao;
import com.example.hrsys_ssm_hx.dao.EmployeeDao;
import com.example.hrsys_ssm_hx.entity.Department;
import com.example.hrsys_ssm_hx.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    DepartmentDao depDao;

    @Autowired
    EmployeeDao empDao;

    @Override
    public List<Department> search() {
        return depDao.findAll();
    }

    @Override
    public Department searchById(Integer id) {
        return depDao.findById(id).orElse(null);
    }

    @Override
    public boolean add(Department dep) {
        return depDao.save(dep) != null;
    }

    @Override
    public boolean update(Department dep) {
        return depDao.save(dep) != null;
    }

    @Override
    public boolean delete(Integer id) {
        try {
            empDao.updateDepIdToNull(id);
            depDao.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
