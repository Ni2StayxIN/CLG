package com.example.hrsys_ssm_hx.controller;

import com.example.hrsys_ssm_hx.entity.SysPermission;
import com.example.hrsys_ssm_hx.service.SysPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/sysPermission")
@PreAuthorize("hasRole('ADMIN')")
public class SysPermissionController {

    @Autowired
    private SysPermissionService sysPermissionService;

    @RequestMapping("/search")
    public String search(Model model) {
        List<SysPermission> list = sysPermissionService.findAll();
        model.addAttribute("list", list);
        return "sysPermission/show";
    }

    @RequestMapping("/showAdd")
    public String showAdd() {
        return "sysPermission/add";
    }

    @RequestMapping("/add")
    public String add(SysPermission permission) {
        sysPermissionService.add(permission);
        return "redirect:/sysPermission/search";
    }

    @RequestMapping("/showUpdate")
    public String showUpdate(Integer id, Model model) {
        SysPermission sysPermission = sysPermissionService.findById(id);
        model.addAttribute("sysPermission", sysPermission);
        return "sysPermission/update";
    }

    @RequestMapping("/update")
    public String update(SysPermission permission) {
        sysPermissionService.update(permission);
        return "redirect:/sysPermission/search";
    }

    @RequestMapping("/delete")
    public String delete(Integer id) {
        sysPermissionService.delete(id);
        return "redirect:/sysPermission/search";
    }
}
