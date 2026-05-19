package com.example.hrsys_ssm_hx.controller;

import com.example.hrsys_ssm_hx.entity.Department;
import com.example.hrsys_ssm_hx.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/dep")
@PreAuthorize("hasAnyRole('MANAGER','ADMIN')")  // 经理和管理员可访问
public class DepartmentController {

    @Autowired
    DepartmentService depService;

    @RequestMapping("/search")
    public String search(Model model) {
        List<Department> list = depService.search();
        model.addAttribute("list", list);
        return "dep/show";
    }

    @RequestMapping("/showAdd")
    public String showAdd() {
        return "dep/add";
    }

    @RequestMapping("/add")
    public String add(Department dep) {
        depService.add(dep);
        return "redirect:/dep/search";
    }

    @RequestMapping("/showUpdate")
    public String showUpdate(Integer id, Model model) {
        Department dep = depService.searchById(id);
        model.addAttribute("dep", dep);
        return "dep/update";
    }

    @RequestMapping("/update")
    public String update(Department dep) {
        depService.update(dep);
        return "redirect:/dep/search";
    }

    @RequestMapping("/delete")
    public String delete(Integer id) {
        depService.delete(id);
        return "redirect:/dep/search";
    }
}