package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.ConcertDAO;
import com.fengwei.ticket.entity.Concert;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/concert-detail")
public class ConcertDetailServlet extends HttpServlet {
    private ConcertDAO concertDAO = new ConcertDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("=== ConcertDetailServlet 开始处理 ===");

        String idParam = request.getParameter("id");
        System.out.println("接收到的id参数: '" + idParam + "'");

        // 检查用户是否登录
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");

        System.out.println("用户ID: " + userId);
        System.out.println("用户类型: " + userType);

        if (userId == null || !"student".equals(userType)) {
            System.out.println("用户未登录或不是学生，重定向到登录页面");
            response.sendRedirect("login");
            return;
        }

        // 验证id参数
        if (idParam == null || idParam.trim().isEmpty()) {
            System.out.println("id参数为空，重定向到演唱会列表");
            response.sendRedirect("concerts");
            return;
        }

        try {
            Long concertId = Long.parseLong(idParam.trim());
            System.out.println("解析后的演唱会ID: " + concertId);

            Concert concert = concertDAO.findById(concertId);
            System.out.println("查询到的演唱会: " + concert);

            if (concert != null) {
                System.out.println("找到演唱会，跳转到订单页面: " + concert.getTitle());
                request.setAttribute("concert", concert);
                request.getRequestDispatcher("/order.jsp").forward(request, response);
            } else {
                System.out.println("未找到演唱会，ID: " + concertId);
                response.sendRedirect("concerts");
            }
        } catch (NumberFormatException e) {
            System.out.println("ID参数格式错误: " + idParam);
            e.printStackTrace();
            response.sendRedirect("concerts");
        } catch (Exception e) {
            System.out.println("处理过程中发生错误");
            e.printStackTrace();
            response.sendRedirect("concerts");
        }

        System.out.println("=== ConcertDetailServlet 处理结束 ===");
    }
}