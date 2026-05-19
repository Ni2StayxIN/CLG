package com.fengwei.ticket.service;

import com.fengwei.ticket.dao.ConcertDAO;
import com.fengwei.ticket.dao.OrderDAO;
import com.fengwei.ticket.entity.Concert;
import com.fengwei.ticket.entity.Order;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class TicketService {
    private ConcertDAO concertDAO = new ConcertDAO();
    private OrderDAO orderDAO = new OrderDAO();

    public synchronized String grabTicket(Long userId, Long concertId, Integer quantity,
                                          String spectatorName, String spectatorStudentId,
                                          String spectatorPhone, String seatInfo) {
        try {
            // 检查库存
            Concert concert = concertDAO.findById(concertId);
            if (concert == null) {
                return "演唱会不存在";
            }

            if (concert.getAvailableTickets() < quantity) {
                return "票已售罄";
            }

            // 检查用户是否已经购买过该演唱会
            List<Order> userOrders = orderDAO.findByUserId(userId);
            for (Order order : userOrders) {
                if (order.getConcertId().equals(concertId)) {
                    return "您已经购买过该演唱会的门票，每人限购一张";
                }
            }

            // 扣减库存
            boolean stockUpdated = concertDAO.updateAvailableTickets(concertId, quantity);
            if (!stockUpdated) {
                return "抢票失败，请重试";
            }

            // 创建订单
            BigDecimal totalAmount = BigDecimal.valueOf(concert.getPrice()).multiply(BigDecimal.valueOf(quantity));
            Order order = new Order();
            order.setUserId(userId);
            order.setConcertId(concertId);
            order.setQuantity(quantity);
            order.setTotalAmount(totalAmount.doubleValue());
            order.setStatus("SUCCESS");
            order.setCreateTime(new java.util.Date());
            order.setOrderNumber("T" + System.currentTimeMillis() + (int)(Math.random() * 1000));
            order.setSpectatorName(spectatorName);
            order.setSpectatorStudentId(spectatorStudentId);
            order.setSpectatorPhone(spectatorPhone);
            order.setSeatInfo(seatInfo);

            boolean orderCreated = orderDAO.createOrder(order);
            if (!orderCreated) {
                return "订单创建失败";
            }

            return "抢票成功！订单号：" + order.getOrderNumber() + "，请妥善保管";
        } catch (Exception e) {
            e.printStackTrace();
            return "系统错误：" + e.getMessage();
        }
    }
}