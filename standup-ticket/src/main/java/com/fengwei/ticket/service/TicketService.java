package com.fengwei.ticket.service;

import com.fengwei.ticket.dao.ShowDAO;
import com.fengwei.ticket.dao.OrderDAO;
import com.fengwei.ticket.dao.RefundDAO;
import com.fengwei.ticket.entity.Show;
import com.fengwei.ticket.entity.Order;
import com.fengwei.ticket.entity.Refund;
import java.util.List;
import java.math.BigDecimal;

public class TicketService {
    private ShowDAO showDAO = new ShowDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private RefundDAO refundDAO = new RefundDAO();

    public synchronized String grabTicket(Long userId, Long showId, Integer quantity,
                                          String spectatorName, String spectatorStudentId,
                                          String spectatorPhone, String seatInfo) {
        try {
            Show show = showDAO.findById(showId);
            if (show == null) {
                return "脱口秀演出不存在";
            }

            if (show.getAvailableTickets() < quantity) {
                return "票已售罄";
            }

            List<Order> userOrders = orderDAO.findByUserId(userId);
            for (Order order : userOrders) {
                if (order.getShowId().equals(showId) && !"cancelled".equals(order.getStatus())) {
                    return "您已经购买过该脱口秀演出的门票，每人限购一张";
                }
            }

            boolean stockUpdated = showDAO.updateAvailableTickets(showId, quantity);
            if (!stockUpdated) {
                return "抢票失败，请重试";
            }

            BigDecimal totalAmount = BigDecimal.valueOf(show.getPrice()).multiply(BigDecimal.valueOf(quantity));
            Order order = new Order();
            order.setUserId(userId);
            order.setShowId(showId);
            order.setQuantity(quantity);
            order.setTotalAmount(totalAmount.doubleValue());
            order.setStatus("paid");
            order.setCreateTime(new java.util.Date());
            order.setOrderNumber("T" + System.currentTimeMillis() + (int)(Math.random() * 1000));
            order.setSpectatorName(spectatorName);
            order.setSpectatorStudentId(spectatorStudentId);
            order.setSpectatorPhone(spectatorPhone);
            order.setSeatInfo(seatInfo);

            boolean orderCreated = orderDAO.createOrder(order);
            if (!orderCreated) {
                showDAO.restoreAvailableTickets(showId, quantity);
                return "订单创建失败";
            }

            return "购票成功！订单号：" + order.getOrderNumber() + "，请妥善保管";
        } catch (Exception e) {
            e.printStackTrace();
            return "系统错误：" + e.getMessage();
        }
    }

    public synchronized String applyRefund(Long orderId, Long userId, String reason) {
        try {
            Order order = orderDAO.findById(orderId);
            if (order == null) {
                return "订单不存在";
            }

            if (!order.getUserId().equals(userId)) {
                return "无权操作此订单";
            }

            if (!"paid".equals(order.getStatus())) {
                return "该订单状态不支持退票";
            }

            Refund existingRefund = refundDAO.findByOrderId(orderId);
            if (existingRefund != null) {
                return "该订单已申请退票，请等待处理";
            }

            Show show = showDAO.findById(order.getShowId());
            if (show == null) {
                return "演出信息不存在";
            }

            java.util.Date now = new java.util.Date();
            long diffInMillies = show.getShowTime().getTime() - now.getTime();
            long hours = diffInMillies / (1000 * 60 * 60);

            double refundRate = 1.0;
            if (hours < 24) {
                refundRate = 0.5;
            } else if (hours < 72) {
                refundRate = 0.8;
            }

            double refundAmount = order.getTotalAmount() * refundRate;

            Refund refund = new Refund();
            refund.setOrderId(orderId);
            refund.setUserId(userId);
            refund.setShowId(order.getShowId());
            refund.setRefundAmount(refundAmount);
            refund.setQuantity(order.getQuantity());
            refund.setReason(reason);
            refund.setStatus("pending");
            refund.setApplyTime(now);

            boolean refundCreated = refundDAO.createRefund(refund);
            if (!refundCreated) {
                return "退票申请失败，请重试";
            }

            orderDAO.updateOrderStatus(orderId, "refunding");

            String rateText = refundRate == 1.0 ? "全额" : (refundRate == 0.8 ? "80%" : "50%");
            return "退票申请已提交！预计退款金额：¥" + String.format("%.2f", refundAmount) + "（" + rateText + "退款），请等待管理员审核";
        } catch (Exception e) {
            e.printStackTrace();
            return "系统错误：" + e.getMessage();
        }
    }

    public synchronized String processRefund(Long refundId, boolean approved, String adminRemark) {
        try {
            Refund refund = refundDAO.findById(refundId);
            if (refund == null) {
                return "退票申请不存在";
            }

            if (!"pending".equals(refund.getStatus())) {
                return "该退票申请已处理";
            }

            String newStatus = approved ? "approved" : "rejected";
            boolean updated = refundDAO.updateRefundStatus(refundId, newStatus, adminRemark);
            if (!updated) {
                return "处理失败，请重试";
            }

            if (approved) {
                orderDAO.updateOrderStatus(refund.getOrderId(), "refunded");
                showDAO.restoreAvailableTickets(refund.getShowId(), refund.getQuantity());
            } else {
                orderDAO.updateOrderStatus(refund.getOrderId(), "paid");
            }

            return approved ? "退票申请已批准，退款金额：¥" + String.format("%.2f", refund.getRefundAmount()) : "退票申请已拒绝";
        } catch (Exception e) {
            e.printStackTrace();
            return "系统错误：" + e.getMessage();
        }
    }
}