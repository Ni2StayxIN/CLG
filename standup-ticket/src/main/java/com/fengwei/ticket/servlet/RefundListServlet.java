package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.RefundDAO;
import com.fengwei.ticket.entity.Refund;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/refunds")
public class RefundListServlet extends HttpServlet {
    private RefundDAO refundDAO = new RefundDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Long userId = (Long) session.getAttribute("userId");

        try {
            List<Refund> refundList = refundDAO.findByUserId(userId);
            request.setAttribute("refundList", refundList);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("refundList", new ArrayList<Refund>());
            request.setAttribute("errorMessage", "加载退票记录失败，请稍后再试");
        }

        request.getRequestDispatcher("refunds.jsp").forward(request, response);
    }
}