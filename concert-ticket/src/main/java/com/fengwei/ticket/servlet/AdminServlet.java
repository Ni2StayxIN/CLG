package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.ConcertDAO;
import com.fengwei.ticket.dao.OrderDAO;
import com.fengwei.ticket.dao.UserDAO;
import com.fengwei.ticket.entity.Concert;
import com.fengwei.ticket.entity.Order;
import com.fengwei.ticket.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private ConcertDAO concertDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        concertDAO = new ConcertDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User adminUser = (User) request.getSession().getAttribute("user");
        if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            // 显示管理员仪表板
            showDashboard(request, response);
        } else {
            switch (action) {
                case "concerts":
                    showConcerts(request, response);
                    break;
                case "orders":
                    showOrders(request, response);
                    break;
                case "users":
                    showUsers(request, response);
                    break;
                default:
                    showDashboard(request, response);
            }
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int totalUsers = userDAO.getUserCount();
            int totalConcerts = concertDAO.getConcertCount();
            int totalOrders = orderDAO.getOrderCount();
            double totalRevenue = orderDAO.getTotalRevenue();

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalConcerts", totalConcerts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);

            List<Order> recentOrders = orderDAO.getRecentOrders(5);
            request.setAttribute("recentOrders", recentOrders);

            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void showConcerts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Concert> concerts = concertDAO.getAllConcerts();
            request.setAttribute("concerts", concerts);
            request.getRequestDispatcher("/admin-concerts.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User adminUser = (User) request.getSession().getAttribute("user");
        if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "deleteConcert":
                    deleteConcert(request, response);
                    break;
                case "addConcert":
                    addConcert(request, response);
                    break;
                default:
                    response.sendRedirect("admin?action=concerts");
            }
        } else {
            response.sendRedirect("admin?action=concerts");
        }
    }
    
    private void deleteConcert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("admin?action=concerts");
            return;
        }
        
        try {
            Long concertId = Long.parseLong(idStr);
            boolean success = concertDAO.deleteConcert(concertId);
            
            response.sendRedirect("admin?action=concerts");
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    private void addConcert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String city = request.getParameter("city");
            String venue = request.getParameter("venue");
            String concertTimeStr = request.getParameter("concertTime");
            double price = Double.parseDouble(request.getParameter("price"));
            int totalTickets = Integer.parseInt(request.getParameter("totalTickets"));
            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");
            String description = request.getParameter("description");
            
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date concertTime = sdf.parse(concertTimeStr);
            
            Concert concert = new Concert();
            concert.setTitle(title);
            concert.setCity(city);
            concert.setVenue(venue);
            concert.setConcertTime(concertTime);
            concert.setPrice(price);
            concert.setTotalTickets(totalTickets);
            concert.setAvailableTickets(totalTickets);
            concert.setStatus(status);
            concert.setImageUrl(imageUrl);
            concert.setDescription(description);
            
            boolean success = concertDAO.createConcert(concert);
            
            response.sendRedirect("admin?action=concerts");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}