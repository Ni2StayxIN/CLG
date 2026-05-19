package com.example.hrsys_ssm_hx.controller;

import com.example.hrsys_ssm_hx.entity.SysPermission;
import com.example.hrsys_ssm_hx.entity.SysRole;
import com.example.hrsys_ssm_hx.service.SysPermissionService;
import com.example.hrsys_ssm_hx.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/sysRole")
@PreAuthorize("hasRole('ADMIN')")
public class SysRoleController {

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysPermissionService sysPermissionService;

    @RequestMapping("/search")
    public String search(Model model) {
        List<SysRole> list = sysRoleService.findAll();
        model.addAttribute("list", list);
        return "sysRole/show";
    }

    @RequestMapping("/showAdd")
    public String showAdd(Model model) {
        List<SysPermission> permissionList = sysPermissionService.findAll();
        model.addAttribute("permissionList", permissionList);
        return "sysRole/add";
    }

    @RequestMapping("/add")
    public String add(SysRole role, @RequestParam(value = "permissions", required = false) Integer[] permissionIds) {
        if (permissionIds != null && permissionIds.length > 0) {
            List<SysPermission> permissions = new ArrayList<>();
            for (Integer permissionId : permissionIds) {
                SysPermission permission = sysPermissionService.findById(permissionId);
                if (permission != null) {
                    permissions.add(permission);
                }
            }
            role.setPermissions(permissions);
        }
        sysRoleService.add(role);
        return "redirect:/sysRole/search";
    }

    @RequestMapping("/showUpdate")
    public String showUpdate(Integer id, Model model) {
        SysRole sysRole = sysRoleService.findById(id);
        List<SysPermission> permissionList = sysPermissionService.findAll();
        model.addAttribute("sysRole", sysRole);
        model.addAttribute("permissionList", permissionList);
        return "sysRole/update";
    }

    @RequestMapping("/update")
    public String update(SysRole role, @RequestParam(value = "permissions", required = false) Integer[] permissionIds) {
        if (permissionIds != null && permissionIds.length > 0) {
            List<SysPermission> permissions = new ArrayList<>();
            for (Integer permissionId : permissionIds) {
                SysPermission permission = sysPermissionService.findById(permissionId);
                if (permission != null) {
                    permissions.add(permission);
                }
            }
            role.setPermissions(permissions);
        } else {
            role.setPermissions(new ArrayList<>());
        }
        sysRoleService.update(role);
        return "redirect:/sysRole/search";
    }

    @RequestMapping("/delete")
    public String delete(Integer id) {
        sysRoleService.delete(id);
        return "redirect:/sysRole/search";
    }
}
