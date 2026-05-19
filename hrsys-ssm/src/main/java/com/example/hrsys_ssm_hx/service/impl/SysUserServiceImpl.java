package com.example.hrsys_ssm_hx.service.impl;

import com.example.hrsys_ssm_hx.dao.SysUserDao;
import com.example.hrsys_ssm_hx.entity.SysUser;
import com.example.hrsys_ssm_hx.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserDao sysUserDao;

    @Override
    public List<SysUser> search(SysUser condition) {
        return sysUserDao.findAll();
    }

    @Override
    public List<SysUser> findAll() {
        return sysUserDao.findAll();
    }

    @Override
    public SysUser findById(Integer id) {
        Optional<SysUser> opt = sysUserDao.findById(id);
        return opt.orElse(null);
    }

    @Override
    public SysUser add(SysUser user) {
        // 新增时对密码进行 BCrypt 加密
        user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        return sysUserDao.save(user);
    }

    @Override
    public SysUser update(SysUser user) {
        // 修改时如果密码字段有值，也需要加密
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        }
        return sysUserDao.save(user);
    }

    @Override
    public void delete(Integer id) {
        sysUserDao.deleteById(id);
    }

    @Override
    public SysUser searchByUsername(String username) {
        return sysUserDao.findByUsername(username);
    }
}