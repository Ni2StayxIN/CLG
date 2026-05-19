package com.example.hrsys_ssm_hx.service.impl;

import com.example.hrsys_ssm_hx.dao.SysPermissionDao;
import com.example.hrsys_ssm_hx.entity.SysPermission;
import com.example.hrsys_ssm_hx.service.SysPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SysPermissionServiceImpl implements SysPermissionService {

    @Autowired
    private SysPermissionDao sysPermissionDao;

    @Override
    public List<SysPermission> search(SysPermission condition) {
        return sysPermissionDao.findAll();
    }

    @Override
    public List<SysPermission> findAll() {
        return sysPermissionDao.findAll();
    }

    @Override
    public SysPermission findById(Integer id) {
        Optional<SysPermission> opt = sysPermissionDao.findById(id);
        return opt.orElse(null);
    }

    @Override
    public SysPermission add(SysPermission permission) {
        return sysPermissionDao.save(permission);
    }

    @Override
    public SysPermission update(SysPermission permission) {
        return sysPermissionDao.save(permission);
    }

    @Override
    public void delete(Integer id) {
        sysPermissionDao.deleteById(id);
    }
}
