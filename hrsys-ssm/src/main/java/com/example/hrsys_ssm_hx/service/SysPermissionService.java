package com.example.hrsys_ssm_hx.service;

import com.example.hrsys_ssm_hx.entity.SysPermission;
import java.util.List;

public interface SysPermissionService {

    List<SysPermission> search(SysPermission condition);

    List<SysPermission> findAll();

    SysPermission findById(Integer id);

    SysPermission add(SysPermission permission);

    SysPermission update(SysPermission permission);

    void delete(Integer id);
}
