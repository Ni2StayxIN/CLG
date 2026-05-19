package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.OrderDAO;
import com.fengwei.ticket.entity.Order;
import com.fengwei.ticket.service.TicketService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/create-order", "/orders"})
public class OrderServlet extends HttpServlet {
    private TicketService ticketService = new TicketService();
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("=== OrderServlet 开始加载用户订单数据 ===");

        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("用户未登录，重定向到登录页面");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 获取用户订单列表
            List<Order> orderList = orderDAO.findByUserId(userId);
            System.out.println("从数据库获取到 " + orderList.size() + " 个用户订单");

            // 将订单列表设置到request属性中
            request.setAttribute("orderList", orderList);
            // 转发到orders.jsp页面
            request.getRequestDispatcher("/orders.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("加载订单数据时发生错误");
            e.printStackTrace();
            // 添加友好的错误处理
            request.setAttribute("errorMessage", "加载订单数据时出现问题，请稍后再试");
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        }

        System.out.println("=== OrderServlet 处理结束 ===");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");

        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"请先登录\"}");
            return;
        }

        try {
            Long concertId = Long.parseLong(request.getParameter("concertId"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            String spectatorName = request.getParameter("spectatorName");
            String spectatorStudentId = request.getParameter("spectatorStudentId");
            String spectatorPhone = request.getParameter("spectatorPhone");
            String seatInfo = request.getParameter("seatInfo");

            // 验证必填字段
            if (spectatorName == null || spectatorName.trim().isEmpty() ||
                    spectatorStudentId == null || spectatorStudentId.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"请填写完整的观众信息\"}");
                return;
            }

            String result = ticketService.grabTicket(userId, concertId, quantity,
                    spectatorName, spectatorStudentId, spectatorPhone, seatInfo);

            if (result.contains("成功")) {
                response.getWriter().write("{\"success\": true, \"message\": \"" + result + "\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"" + result + "\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"success\": false, \"message\": \"参数错误\"}");
        }
    }
}