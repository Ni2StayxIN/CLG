package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.ConcertDAO;
import com.fengwei.ticket.entity.Concert;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/concerts")
public class ConcertServlet extends HttpServlet {
    private ConcertDAO concertDAO = new ConcertDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("=== ConcertServlet 开始加载演唱会数据 ===");

        try {
            List<Concert> concerts = concertDAO.getAllConcerts();
            System.out.println("从数据库获取到 " + concerts.size() + " 场演唱会");

            for (Concert concert : concerts) {
                System.out.println("演唱会: ID=" + concert.getId() + ", 标题=" + concert.getTitle());
            }

            request.setAttribute("concerts", concerts);
            request.getRequestDispatcher("/concerts.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("加载演唱会数据时发生错误");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }

        System.out.println("=== ConcertServlet 处理结束 ===");
    }
}