package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.ShowDAO;
import com.fengwei.ticket.entity.Show;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/show-detail")
public class ShowDetailServlet extends HttpServlet {
    private ShowDAO showDAO = new ShowDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("=== ShowDetailServlet 开始处理 ===");

        String idParam = request.getParameter("id");
        System.out.println("接收到的id参数: '" + idParam + "'");

        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");

        System.out.println("用户ID: " + userId);

        if (userId == null) {
            System.out.println("用户未登录，重定向到登录页面");
            response.sendRedirect("login.jsp");
            return;
        }

        if (idParam == null || idParam.trim().isEmpty()) {
            System.out.println("id参数为空，重定向到演出列表");
            response.sendRedirect("shows");
            return;
        }

        try {
            Long showId = Long.parseLong(idParam.trim());
            System.out.println("解析后的演出ID: " + showId);

            Show show = showDAO.findById(showId);
            System.out.println("查询到的演出: " + show);

            if (show != null) {
                System.out.println("找到演出，跳转到订单页面: " + show.getTitle());
                request.setAttribute("show", show);
                request.getRequestDispatcher("/order.jsp").forward(request, response);
            } else {
                System.out.println("未找到演出，ID: " + showId);
                response.sendRedirect("shows");
            }
        } catch (NumberFormatException e) {
            System.out.println("ID参数格式错误: " + idParam);
            e.printStackTrace();
            response.sendRedirect("shows");
        } catch (Exception e) {
            System.out.println("处理过程中发生错误");
            e.printStackTrace();
            response.sendRedirect("shows");
        }

        System.out.println("=== ShowDetailServlet 处理结束 ===");
    }
}