package com.fengwei.ticket.servlet;

import com.fengwei.ticket.service.TicketService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/grab-ticket")
public class TicketServlet extends HttpServlet {
    private TicketService ticketService = new TicketService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");

        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"请先登录\"}");
            return;
        }

        try {
            Long showId = Long.parseLong(request.getParameter("showId"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            String spectatorName = request.getParameter("spectatorName");
            String spectatorStudentId = request.getParameter("spectatorStudentId");
            String spectatorPhone = request.getParameter("spectatorPhone");
            String seatInfo = request.getParameter("seatInfo");

            if (spectatorName == null || spectatorName.trim().isEmpty() ||
                    spectatorStudentId == null || spectatorStudentId.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"请填写完整的观众信息\"}");
                return;
            }

            String result = ticketService.grabTicket(userId, showId, quantity,
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
