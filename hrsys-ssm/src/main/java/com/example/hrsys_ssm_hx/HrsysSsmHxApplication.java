package com.example.hrsys_ssm_hx;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.example.hrsys_ssm_hx.dao")
public class HrsysSsmHxApplication {
    public static void main(String[] args) {
        SpringApplication.run(HrsysSsmHxApplication.class, args);
    }
}
