package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.OrderDAO;
import com.fengwei.ticket.entity.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/order")
public class OrderDetailServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("=== OrderDetailServlet 开始处理 ===");

        // 获取订单ID参数
        String idParam = request.getParameter("id");
        System.out.println("接收到的订单ID参数: '" + idParam + "'");

        // 检查用户是否登录
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("用户未登录，重定向到登录页面");
            response.sendRedirect("login.jsp");
            return;
        }

        // 验证id参数
        if (idParam == null || idParam.trim().isEmpty()) {
            System.out.println("订单ID参数为空，重定向到订单列表");
            response.sendRedirect("orders");
            return;
        }

        try {
            Long orderId = Long.parseLong(idParam.trim());
            System.out.println("解析后的订单ID: " + orderId);

            // 查询订单详情
            Order order = orderDAO.findById(orderId);
            System.out.println("查询到的订单: " + order);

            // 验证订单是否属于当前用户
            if (order != null && order.getUserId().equals(userId)) {
                System.out.println("找到订单，跳转到订单详情页面");
                request.setAttribute("order", order);
                // 转发到order.jsp页面，这个页面可以复用
                request.getRequestDispatcher("/order.jsp").forward(request, response);
            } else {
                System.out.println("未找到订单或无权访问，ID: " + orderId);
                request.setAttribute("errorMessage", "未找到该订单或无权访问");
                request.getRequestDispatcher("/orders.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("订单ID参数格式错误: " + idParam);
            e.printStackTrace();
            response.sendRedirect("orders");
        } catch (Exception e) {
            System.out.println("处理过程中发生错误");
            e.printStackTrace();
            request.setAttribute("errorMessage", "加载订单详情时出现问题，请稍后再试");
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        }

        System.out.println("=== OrderDetailServlet 处理结束 ===");
    }
}