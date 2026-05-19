package com.example.hrsys_ssm_hx.service;

import com.example.hrsys_ssm_hx.entity.SysUser;
import java.util.List;

public interface SysUserService {

    List<SysUser> search(SysUser condition);

    List<SysUser> findAll();

    SysUser findById(Integer id);

    SysUser add(SysUser user);

    SysUser update(SysUser user);

    void delete(Integer id);

    //根据用户名查询用户
    SysUser searchByUsername(String username);

}
