package com.example.hrsys_ssm_hx.controller;

import com.example.hrsys_ssm_hx.entity.SysUser;
import com.example.hrsys_ssm_hx.entity.SysRole;
import com.example.hrsys_ssm_hx.service.SysUserService;
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
@RequestMapping("/sysUser")
@PreAuthorize("hasRole('ADMIN')")  // 只有管理员可访问
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SysRoleService sysRoleService;

    @RequestMapping("/search")
    public String search(Model model) {
        List<SysUser> list = sysUserService.findAll();
        model.addAttribute("list", list);
        return "sysUser/show";
    }

    @RequestMapping("/showAdd")
    public String showAdd(Model model) {
        List<SysRole> roleList = sysRoleService.findAll();
        model.addAttribute("roleList", roleList);
        return "sysUser/add";
    }

    @RequestMapping("/add")
    public String add(SysUser user, @RequestParam(value = "roles", required = false) Integer[] roleIds) {
        if (roleIds != null && roleIds.length > 0) {
            List<SysRole> roles = new ArrayList<>();
            for (Integer roleId : roleIds) {
                SysRole role = sysRoleService.findById(roleId);
                if (role != null) {
                    roles.add(role);
                }
            }
            user.setRoles(roles);
        }
        sysUserService.add(user);
        return "redirect:/sysUser/search";
    }

    @RequestMapping("/showUpdate")
    public String showUpdate(Integer id, Model model) {
        SysUser sysUser = sysUserService.findById(id);
        List<SysRole> roleList = sysRoleService.findAll();
        model.addAttribute("sysUser", sysUser);
        model.addAttribute("roleList", roleList);
        return "sysUser/update";
    }

    @RequestMapping("/update")
    public String update(SysUser user, @RequestParam(value = "roles", required = false) Integer[] roleIds) {
        if (roleIds != null && roleIds.length > 0) {
            List<SysRole> roles = new ArrayList<>();
            for (Integer roleId : roleIds) {
                SysRole role = sysRoleService.findById(roleId);
                if (role != null) {
                    roles.add(role);
                }
            }
            user.setRoles(roles);
        } else {
            user.setRoles(new ArrayList<>());
        }
        sysUserService.update(user);
        return "redirect:/sysUser/search";
    }

    @RequestMapping("/delete")
    public String delete(Integer id) {
        sysUserService.delete(id);
        return "redirect:/sysUser/search";
    }
}
