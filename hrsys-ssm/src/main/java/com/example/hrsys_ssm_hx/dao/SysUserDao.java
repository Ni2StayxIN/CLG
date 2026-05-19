package com.example.hrsys_ssm_hx.dao;

import com.example.hrsys_ssm_hx.entity.SysUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SysUserDao extends JpaRepository<SysUser, Integer> {
    // 根据用户名查询用户
    SysUser findByUsername(String username);
}
