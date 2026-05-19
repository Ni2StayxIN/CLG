package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.UserDAO;
import com.fengwei.ticket.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 检查是否是退出操作
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            // 处理退出逻辑
            processLogout(request, response);
            return;
        }

        // 否则处理登录逻辑
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            User user = userDAO.findByUsernameAndPassword(username, password);

            if (user != null) {
                // 登录成功
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userType", user.getUserType());
                session.setAttribute("realName", user.getRealName());

                if ("admin".equals(user.getUserType())) {
                    response.sendRedirect("admin");
                } else {
                    response.sendRedirect("concerts");
                }
            } else {
                request.setAttribute("error", "用户名或密码错误");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "系统错误，请稍后重试");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 检查是否是退出操作
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            // 处理退出逻辑
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            // 退出后重定向到 concerts 页面
            response.sendRedirect("concerts");
            return;
        }

        // 否则显示登录页面
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // 处理退出的私有方法
    private void processLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // 获取当前会话
        HttpSession session = request.getSession(false);

        if (session != null) {
            // 清除所有会话属性
            session.removeAttribute("user");
            session.removeAttribute("userId");
            session.removeAttribute("username");
            session.removeAttribute("userType");
            session.removeAttribute("realName");

            // 销毁会话
            session.invalidate();
        }

        // 重定向到登录页面
        response.sendRedirect("login.jsp");
    }
}