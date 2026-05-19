package com.example.hrsys_ssm_hx.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "role")
public class SysRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "code")
    private String code;

    @Column(name = "name")
    private String name;

    @ManyToMany
    @JoinTable(
            name = "m_role_permission",
            joinColumns = @JoinColumn(name = "r_id"),
            inverseJoinColumns = @JoinColumn(name = "p_id")
    )
    @OrderBy("id DESC")
    private List<SysPermission> permissions;

    @ManyToMany(mappedBy = "roles")
    private List<SysUser> users;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<SysPermission> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<SysPermission> permissions) {
        this.permissions = permissions;
    }

    public List<SysUser> getUsers() {
        return users;
    }

    public void setUsers(List<SysUser> users) {
        this.users = users;
    }
}
