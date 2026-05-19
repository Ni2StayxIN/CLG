package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.UserDAO;
import com.fengwei.ticket.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String realName = request.getParameter("realName");
        String studentId = request.getParameter("studentId");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        try {
            // 检查用户名是否已存在
            User existingUser = userDAO.findByUsername(username);
            if (existingUser != null) {
                request.setAttribute("error", "用户名已存在");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setRealName(realName);
            user.setStudentId(studentId);
            user.setPhone(phone);
            user.setEmail(email);
            user.setUserType("student");

            boolean success = userDAO.createUser(user);
            if (success) {
                request.setAttribute("success", "注册成功，请登录");
                response.sendRedirect("login");
            } else {
                request.setAttribute("error", "注册失败，请重试");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "系统错误，请稍后重试");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}