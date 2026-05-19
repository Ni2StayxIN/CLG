package com.example.hrsys_ssm_hx.service.impl;

import com.example.hrsys_ssm_hx.dao.SysRoleDao;
import com.example.hrsys_ssm_hx.entity.SysRole;
import com.example.hrsys_ssm_hx.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SysRoleServiceImpl implements SysRoleService {

    @Autowired
    private SysRoleDao sysRoleDao;

    @Override
    public List<SysRole> search(SysRole condition) {
        return sysRoleDao.findAll();
    }

    @Override
    public List<SysRole> findAll() {
        return sysRoleDao.findAll();
    }

    @Override
    public SysRole findById(Integer id) {
        Optional<SysRole> opt = sysRoleDao.findById(id);
        return opt.orElse(null);
    }

    @Override
    public SysRole add(SysRole role) {
        return sysRoleDao.save(role);
    }

    @Override
    public SysRole update(SysRole role) {
        return sysRoleDao.save(role);
    }

    @Override
    public void delete(Integer id) {
        sysRoleDao.deleteById(id);
    }
}
