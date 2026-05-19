package com.fengwei.ticket.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class StartupListener implements ServletContextListener {
    private static final Logger logger = Logger.getLogger(StartupListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("=== 脱口秀门票预订系统启动成功 ===");
        logger.info("数据库: standup_comedy");
        logger.info("系统已就绪，等待用户访问...");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("===");
    }
}