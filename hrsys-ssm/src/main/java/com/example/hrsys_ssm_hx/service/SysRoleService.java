package com.example.hrsys_ssm_hx.service;

import com.example.hrsys_ssm_hx.entity.SysRole;
import java.util.List;

public interface SysRoleService {

    List<SysRole> search(SysRole condition);

    List<SysRole> findAll();

    SysRole findById(Integer id);

    SysRole add(SysRole role);

    SysRole update(SysRole role);

    void delete(Integer id);
}
