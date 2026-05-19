package com.example.hrsys_ssm_hx.service.impl;

import com.example.hrsys_ssm_hx.dao.EmployeeDao;
import com.example.hrsys_ssm_hx.entity.Employee;
import com.example.hrsys_ssm_hx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeDao empDao;

    @Override
    public List<Employee> search(Employee condition) {
        Specification<Employee> specification = new Specification<Employee>() {
            @Override
            public Predicate toPredicate(Root<Employee> root,
                                         CriteriaQuery<?> query,
                                         CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (condition.getNumber() != null) {
                    predicates.add(
                            criteriaBuilder.equal(root.get("number"), condition.getNumber())
                    );
                }

                if (StringUtils.hasText(condition.getName())) {
                    predicates.add(
                            criteriaBuilder.like(root.get("name"), "%" + condition.getName() + "%")
                    );
                }

                if (StringUtils.hasText(condition.getGender())) {
                    predicates.add(
                            criteriaBuilder.equal(root.get("gender"), condition.getGender())
                    );
                }

                if (condition.getAge() != null) {
                    predicates.add(
                            criteriaBuilder.equal(root.get("age"), condition.getAge())
                    );
                }

                if (condition.getDep() != null && condition.getDep().getId() != null) {
                    predicates.add(
                            criteriaBuilder.equal(root.get("dep").get("id"),
                                    condition.getDep().getId())
                    );
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
            }
        };

        return empDao.findAll(specification);
    }

    @Override
    public Employee searchById(Integer id) {
        return empDao.findById(id).orElse(null);
    }

    @Override
    public boolean add(Employee emp) {
        return empDao.save(emp) != null;
    }

    @Override
    public boolean update(Employee emp) {
        return empDao.save(emp) != null;
    }

    @Override
    public boolean delete(Integer id) {
        try {
            empDao.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
