package com.fengwei.ticket.listener;

import com.fengwei.ticket.dao.OrderDAO;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * 应用启动监听器
 * 用于在应用每次启动时清除所有订单记录
 */
@WebListener
public class StartupListener implements ServletContextListener {
    private static final Logger logger = Logger.getLogger(StartupListener.class.getName());
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("=== 应用启动，开始清除历史订单记录 ===");
        
        OrderDAO orderDAO = new OrderDAO();
        try {
            int deletedCount = orderDAO.deleteAllOrders();
            logger.info("成功清除 " + deletedCount + " 条订单记录");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "清除订单记录失败", e);
        }
        
        logger.info("=== 订单记录清除完成 ===");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 应用关闭时的清理工作（如果需要）
        logger.info("=== 应用关闭 ===");
    }
}