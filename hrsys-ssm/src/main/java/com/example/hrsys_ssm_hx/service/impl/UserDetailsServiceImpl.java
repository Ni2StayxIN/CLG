package com.example.hrsys_ssm_hx.service.impl;

import com.example.hrsys_ssm_hx.entity.SysPermission;
import com.example.hrsys_ssm_hx.entity.SysRole;
import com.example.hrsys_ssm_hx.entity.SysUser;
import com.example.hrsys_ssm_hx.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Component
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private SysUserService sysUserService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 从数据库查询用户
        SysUser sysUser = sysUserService.searchByUsername(username);
        if (sysUser == null) {
            throw new UsernameNotFoundException("用户名不存在");
        }

        Collection<GrantedAuthority> authorities = new ArrayList<>();

        // 添加角色（Spring Security 要求角色以 ROLE_ 开头，数据库已存 ROLE_XXX 形式）
        List<SysRole> roles = sysUser.getRoles();
        for (SysRole role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getCode()));
            // 添加该角色拥有的权限
            for (SysPermission permission : role.getPermissions()) {
                authorities.add(new SimpleGrantedAuthority(permission.getCode()));
            }
        }

        // 返回 Spring Security 的 User 对象，密码使用数据库中的加密值
        return new User(sysUser.getUsername(), sysUser.getPassword(), authorities);
    }

    // 辅助方法：从 SecurityContext 获取当前登录的 SysUser 对象（供其他模块使用）
    public SysUser getCurrentSysUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return sysUserService.searchByUsername(user.getUsername());
    }
}
