package com.fengwei.ticket.dao;

import com.fengwei.ticket.entity.Refund;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RefundDAO {

    public boolean createRefund(Refund refund) throws SQLException {
        String sql = "INSERT INTO refunds (order_id, user_id, show_id, refund_amount, quantity, reason, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, refund.getOrderId());
            stmt.setLong(2, refund.getUserId());
            stmt.setLong(3, refund.getShowId());
            stmt.setDouble(4, refund.getRefundAmount());
            stmt.setInt(5, refund.getQuantity());
            stmt.setString(6, refund.getReason());
            stmt.setString(7, "pending");

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public List<Refund> findByUserId(Long userId) throws SQLException {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT r.*, o.order_number, s.title AS show_name, u.real_name AS user_name " +
                     "FROM refunds r " +
                     "LEFT JOIN orders o ON r.order_id = o.id " +
                     "LEFT JOIN shows s ON r.show_id = s.id " +
                     "LEFT JOIN users u ON r.user_id = u.id " +
                     "WHERE r.user_id = ? " +
                     "ORDER BY r.apply_time DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    refunds.add(extractRefundFromResultSet(rs));
                }
            }
        }
        return refunds;
    }

    public List<Refund> getAllRefunds() throws SQLException {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT r.*, o.order_number, s.title AS show_name, u.real_name AS user_name " +
                     "FROM refunds r " +
                     "LEFT JOIN orders o ON r.order_id = o.id " +
                     "LEFT JOIN shows s ON r.show_id = s.id " +
                     "LEFT JOIN users u ON r.user_id = u.id " +
                     "ORDER BY r.apply_time DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                refunds.add(extractRefundFromResultSet(rs));
            }
        }
        return refunds;
    }

    public Refund findById(Long id) throws SQLException {
        String sql = "SELECT r.*, o.order_number, s.title AS show_name, u.real_name AS user_name " +
                     "FROM refunds r " +
                     "LEFT JOIN orders o ON r.order_id = o.id " +
                     "LEFT JOIN shows s ON r.show_id = s.id " +
                     "LEFT JOIN users u ON r.user_id = u.id " +
                     "WHERE r.id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractRefundFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public Refund findByOrderId(Long orderId) throws SQLException {
        String sql = "SELECT * FROM refunds WHERE order_id = ? AND status = 'pending'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Refund refund = new Refund();
                    refund.setId(rs.getLong("id"));
                    refund.setOrderId(rs.getLong("order_id"));
                    refund.setUserId(rs.getLong("user_id"));
                    refund.setShowId(rs.getLong("show_id"));
                    refund.setRefundAmount(rs.getDouble("refund_amount"));
                    refund.setQuantity(rs.getInt("quantity"));
                    refund.setReason(rs.getString("reason"));
                    refund.setStatus(rs.getString("status"));
                    refund.setApplyTime(rs.getTimestamp("apply_time"));
                    return refund;
                }
            }
        }
        return null;
    }

    public boolean updateRefundStatus(Long refundId, String status, String adminRemark) throws SQLException {
        String sql = "UPDATE refunds SET status = ?, admin_remark = ?, process_time = NOW() WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setString(2, adminRemark);
            stmt.setLong(3, refundId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public int getPendingRefundCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM refunds WHERE status = 'pending'";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private Refund extractRefundFromResultSet(ResultSet rs) throws SQLException {
        Refund refund = new Refund();
        refund.setId(rs.getLong("id"));
        refund.setOrderId(rs.getLong("order_id"));
        refund.setUserId(rs.getLong("user_id"));
        refund.setShowId(rs.getLong("show_id"));
        refund.setRefundAmount(rs.getDouble("refund_amount"));
        refund.setQuantity(rs.getInt("quantity"));
        refund.setReason(rs.getString("reason"));
        refund.setStatus(rs.getString("status"));
        refund.setApplyTime(rs.getTimestamp("apply_time"));
        refund.setProcessTime(rs.getTimestamp("process_time"));
        refund.setAdminRemark(rs.getString("admin_remark"));
        refund.setCreateTime(rs.getTimestamp("create_time"));
        
        try {
            refund.setOrderNumber(rs.getString("order_number"));
            refund.setShowName(rs.getString("show_name"));
            refund.setUserName(rs.getString("user_name"));
        } catch (SQLException e) {
        }
        
        return refund;
    }
}
