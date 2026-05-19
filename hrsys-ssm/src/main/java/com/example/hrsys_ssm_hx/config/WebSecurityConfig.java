package com.example.hrsys_ssm_hx.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)   // 开启方法级别的权限注解（@PreAuthorize 等）
public class WebSecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();  // 使用 BCrypt 加密
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // 登录配置
                .formLogin(form -> form
                        .loginPage("/login")                 // 自定义登录页面
                        .loginProcessingUrl("/doLogin")      // 处理登录请求的URL（与login.html表单action一致）
                        .defaultSuccessUrl("/index")         // 登录成功跳转
                        .failureUrl("/loginError")           // 登录失败跳转
                        .permitAll()                         // 登录相关路径全部放行
                )
                // 注销配置
                .logout(logout -> logout
                        .permitAll()                          // 允许所有用户访问注销
                )
                // 异常处理（权限不足时跳转）
                .exceptionHandling(exception -> exception
                        .accessDeniedPage("/roleError")
                )
                // 授权配置
                .authorizeRequests(auth -> auth
                        // 放行静态资源
                        .antMatchers("/bootstrap/**", "/js/**").permitAll()
                        // 所有请求都需要认证
                        .anyRequest().authenticated()
                )
                // 允许同源 iframe 访问（解决之前子页面不显示问题）
                .headers(headers -> headers
                        .frameOptions(frame -> frame.sameOrigin())
                )
                // 禁用 CSRF（开发阶段方便，生产环境请开启并做防护）
                .csrf(csrf -> csrf.disable());

        return http.build();
    }
}
