package com.fengwei.ticket.servlet;

import com.fengwei.ticket.dao.ShowDAO;
import com.fengwei.ticket.dao.OrderDAO;
import com.fengwei.ticket.dao.UserDAO;
import com.fengwei.ticket.dao.RefundDAO;
import com.fengwei.ticket.entity.Show;
import com.fengwei.ticket.entity.Order;
import com.fengwei.ticket.entity.User;
import com.fengwei.ticket.entity.Refund;
import com.fengwei.ticket.service.TicketService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private ShowDAO showDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;
    private RefundDAO refundDAO;
    private TicketService ticketService;

    @Override
    public void init() throws ServletException {
        showDAO = new ShowDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
        refundDAO = new RefundDAO();
        ticketService = new TicketService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        User adminUser = (User) request.getSession().getAttribute("user");
        if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            showDashboard(request, response);
        } else {
            switch (action) {
                case "shows":
                    showShows(request, response);
                    break;
                case "orders":
                    showOrders(request, response);
                    break;
                case "users":
                    showUsers(request, response);
                    break;
                case "refunds":
                    showRefunds(request, response);
                    break;
                default:
                    showDashboard(request, response);
            }
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int totalUsers = userDAO.getUserCount();
            int totalShows = showDAO.getShowCount();
            int totalOrders = orderDAO.getOrderCount();
            double totalRevenue = orderDAO.getTotalRevenue();
            int pendingRefunds = refundDAO.getPendingRefundCount();

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalShows", totalShows);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingRefunds", pendingRefunds);

            List<Order> recentOrders = orderDAO.getRecentOrders(5);
            request.setAttribute("recentOrders", recentOrders);

            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("管理员仪表盘数据库查询失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("dbError", true);
            request.setAttribute("errorMessage", "数据库连接失败: " + e.getMessage());
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("管理员仪表盘加载失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("dbError", true);
            request.setAttribute("errorMessage", "系统加载出错: " + e.getMessage());
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        }
    }

    private void shows(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Show> shows = showDAO.getAllShows();
            request.setAttribute("shows", shows);
            request.getRequestDispatcher("/admin-shows.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("演出列表加载失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("shows", new ArrayList<Show>());
            request.setAttribute("dbError", "演出数据加载失败");
            request.getRequestDispatcher("/admin-shows.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("演出列表加载异常: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("shows", new ArrayList<Show>());
            request.setAttribute("errorMessage", "加载演出数据时出错");
            request.getRequestDispatcher("/admin-shows.jsp").forward(request, response);
        }
    }

    private void showShows(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Show> shows = showDAO.getAllShows();
            request.setAttribute("shows", shows);
            request.getRequestDispatcher("/admin-shows.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("演出管理页面加载失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("shows", new ArrayList<Show>());
            request.setAttribute("dbError", "演出数据加载失败");
            request.getRequestDispatcher("/admin-shows.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("演出管理页面加载异常: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("shows", new ArrayList<Show>());
            request.setAttribute("errorMessage", "加载演出数据时出错");
            request.getRequestDispatcher("/admin-shows.jsp").forward(request, response);
        }
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("订单列表加载失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("orders", new ArrayList<Order>());
            request.setAttribute("dbError", "订单数据加载失败");
            request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("订单列表加载异常: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("orders", new ArrayList<Order>());
            request.setAttribute("errorMessage", "加载订单数据时出错");
            request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
        }
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("用户列表加载失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("users", new ArrayList<User>());
            request.setAttribute("dbError", "用户数据加载失败");
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("用户列表加载异常: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("users", new ArrayList<User>());
            request.setAttribute("errorMessage", "加载用户数据时出错");
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        }
    }

    private void showRefunds(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Refund> refunds = refundDAO.getAllRefunds();
            request.setAttribute("refunds", refunds);
            request.getRequestDispatcher("/admin-refunds.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("退票列表加载失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("refunds", new ArrayList<Refund>());
            request.setAttribute("dbError", "退票数据加载失败");
            request.getRequestDispatcher("/admin-refunds.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("退票列表加载异常: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("refunds", new ArrayList<Refund>());
            request.setAttribute("errorMessage", "加载退票数据时出错");
            request.getRequestDispatcher("/admin-refunds.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User adminUser = (User) request.getSession().getAttribute("user");
        if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "deleteShow":
                    deleteShow(request, response);
                    break;
                case "addShow":
                    addShow(request, response);
                    break;
                case "processRefund":
                    processRefund(request, response);
                    break;
                default:
                    response.sendRedirect("admin?action=shows");
            }
        } else {
            response.sendRedirect("admin?action=shows");
        }
    }

    private void deleteShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("admin?action=shows");
            return;
        }

        try {
            Long showId = Long.parseLong(idStr);
            boolean success = showDAO.deleteShow(showId);

            response.sendRedirect("admin?action=shows");
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=shows&error=delete_failed");
        }
    }

    private void addShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String city = request.getParameter("city");
            String venue = request.getParameter("venue");
            String showTimeStr = request.getParameter("showTime");
            double price = Double.parseDouble(request.getParameter("price"));
            int totalTickets = Integer.parseInt(request.getParameter("totalTickets"));
            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");
            String description = request.getParameter("description");
            String performer = request.getParameter("performer");
            int duration = request.getParameter("duration") != null ? Integer.parseInt(request.getParameter("duration")) : 90;

            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date showTime = sdf.parse(showTimeStr);

            Show show = new Show();
            show.setTitle(title);
            show.setCity(city);
            show.setVenue(venue);
            show.setShowTime(showTime);
            show.setPrice(price);
            show.setTotalTickets(totalTickets);
            show.setAvailableTickets(totalTickets);
            show.setStatus(status);
            show.setImageUrl(imageUrl);
            show.setDescription(description);
            show.setPerformer(performer);
            show.setDuration(duration);

            boolean success = showDAO.createShow(show);

            response.sendRedirect("admin?action=shows");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=shows&error=add_failed");
        }
    }

    private void processRefund(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long refundId = Long.parseLong(request.getParameter("refundId"));
            boolean approved = "approve".equals(request.getParameter("decision"));
            String adminRemark = request.getParameter("adminRemark");

            String result = ticketService.processRefund(refundId, approved, adminRemark);
            System.out.println("退票处理结果: " + result);

            response.sendRedirect("admin?action=refunds");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin?action=refunds&error=process_failed");
        }
    }
}