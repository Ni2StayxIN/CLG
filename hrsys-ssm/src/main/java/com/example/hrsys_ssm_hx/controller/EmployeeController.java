package com.example.hrsys_ssm_hx.controller;

import com.example.hrsys_ssm_hx.entity.Department;
import com.example.hrsys_ssm_hx.entity.Employee;
import com.example.hrsys_ssm_hx.service.DepartmentService;
import com.example.hrsys_ssm_hx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/emp")
@PreAuthorize("hasAnyRole('EMPLOYEE','MANAGER','ADMIN')")  // 员工、经理、管理员可访问
public class EmployeeController {

    @Autowired
    EmployeeService empService;

    @Autowired
    DepartmentService depService;

    @RequestMapping("/search")
    public ModelAndView search(Employee condition) {
        ModelAndView mv = new ModelAndView("emp/show");
        List<Employee> list = empService.search(condition);
        List<Department> depList = depService.search();
        mv.addObject("list", list);
        mv.addObject("depList", depList);
        mv.addObject("c", condition);
        return mv;
    }

    @RequestMapping("/showAdd")
    public ModelAndView showAdd() {
        ModelAndView mv = new ModelAndView("emp/add");
        List<Department> depList = depService.search();
        mv.addObject("depList", depList);
        return mv;
    }

    @RequestMapping("/add")
    public String add(Employee emp) {
        empService.add(emp);
        return "redirect:search";
    }

    @RequestMapping("/showUpdate")
    public ModelAndView showUpdate(Integer id) {
        Employee emp = empService.searchById(id);
        List<Department> depList = depService.search();
        ModelAndView mv = new ModelAndView("emp/update");
        mv.addObject("emp", emp);
        mv.addObject("depList", depList);
        return mv;
    }

    @RequestMapping("/update")
    public String update(Employee emp) {
        empService.update(emp);
        return "redirect:search";
    }

    @RequestMapping("/delete")
    public String delete(Integer id) {
        empService.delete(id);
        return "redirect:search";
    }
}
