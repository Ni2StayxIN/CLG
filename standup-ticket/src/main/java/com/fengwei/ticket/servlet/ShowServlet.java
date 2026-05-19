package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.ShowDAO;
import com.fengwei.ticket.entity.Show;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/shows")
public class ShowServlet extends HttpServlet {
    private ShowDAO showDAO = new ShowDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("=== ShowServlet 开始加载脱口秀演出数据 ===");

        try {
            List<Show> shows = showDAO.getAllShows();
            System.out.println("从数据库获取到 " + shows.size() + " 场脱口秀演出");

            for (Show show : shows) {
                System.out.println("脱口秀演出: ID=" + show.getId() + ", 标题=" + show.getTitle());
            }

            request.setAttribute("shows", shows);
            request.getRequestDispatcher("/shows.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("数据库连接失败，使用空列表");
            e.printStackTrace();
            request.setAttribute("shows", new ArrayList<Show>());
            request.setAttribute("dbError", "数据库连接失败，请检查MySQL服务是否启动");
            request.getRequestDispatcher("/shows.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("加载脱口秀演出数据时发生错误");
            e.printStackTrace();
            request.setAttribute("shows", new ArrayList<Show>());
            request.setAttribute("errorMessage", "加载演出数据时出现问题");
            request.getRequestDispatcher("/shows.jsp").forward(request, response);
        }

        System.out.println("=== ShowServlet 处理结束 ===");
    }
}