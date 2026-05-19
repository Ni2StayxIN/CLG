package com.example.hrsys_ssm_hx.controller;

import com.example.hrsys_ssm_hx.entity.SysUser;
import com.example.hrsys_ssm_hx.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {

    @Autowired
    private SysUserService sysUserService;  // 记得注入

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/loginError")
    public String showLoginError() {
        return "loginError";
    }

    @RequestMapping("/roleError")
    public String showRoleError() {
        return "roleError";
    }

    @RequestMapping("/index")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView("index");

        // 获取当前登录用户
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            SysUser user = sysUserService.searchByUsername(username);
            if (user == null) {
                // 数据库中找不到用户时，创建一个临时用户对象避免页面报错
                user = new SysUser();
                user.setUsername(username);
            }
            mv.addObject("user", user);
        }
        return mv;
    }
}