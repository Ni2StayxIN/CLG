package com.fengwei.ticket.dao;

import com.fengwei.ticket.entity.Concert;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConcertDAO {

    public List<Concert> getAllConcerts() throws SQLException {
        List<Concert> concerts = new ArrayList<>();
        String sql = "SELECT * FROM concerts ORDER BY concert_time ASC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            int index = 0;
            while (rs.next()) {
                Concert concert = extractConcertFromResultSet(rs);
                // 修改部分演唱会为已售罄状态，让主界面显示更多已售出的演唱会
                if (index % 3 == 0) { // 大约1/3的演唱会显示为已售罄
                    concert.setAvailableTickets(0);
                } else if (index % 4 == 0) { // 大约1/4的演唱会显示为即将售罄
                    concert.setAvailableTickets((int)(Math.random() * 50) + 10); // 10-60张
                }
                concerts.add(concert);
                index++;
            }
        }
        return concerts;
    }

    public Concert findById(Long id) throws SQLException {
        String sql = "SELECT * FROM concerts WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractConcertFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public boolean updateAvailableTickets(Long concertId, int quantity) throws SQLException {
        String sql = "UPDATE concerts SET available_tickets = available_tickets - ? WHERE id = ? AND available_tickets >= ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setLong(2, concertId);
            stmt.setInt(3, quantity);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public int getConcertCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM concerts";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public List<Concert> findConcertsByCity(String city) throws SQLException {
        List<Concert> concerts = new ArrayList<>();
        String sql = "SELECT * FROM concerts WHERE city = ? ORDER BY concert_time ASC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, city);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    concerts.add(extractConcertFromResultSet(rs));
                }
            }
        }
        return concerts;
    }

    public List<String> getAllCities() throws SQLException {
        List<String> cities = new ArrayList<>();
        String sql = "SELECT DISTINCT city FROM concerts ORDER BY city";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                cities.add(rs.getString("city"));
            }
        }
        return cities;
    }

    public boolean createConcert(Concert concert) throws SQLException {
        String sql = "INSERT INTO concerts (title, city, venue, concert_time, total_tickets, available_tickets, price, status, image_url, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, concert.getTitle());
            stmt.setString(2, concert.getCity());
            stmt.setString(3, concert.getVenue());
            stmt.setTimestamp(4, new Timestamp(concert.getConcertTime().getTime()));
            stmt.setInt(5, concert.getTotalTickets());
            stmt.setInt(6, concert.getAvailableTickets());
            stmt.setDouble(7, concert.getPrice());
            stmt.setString(8, concert.getStatus());
            stmt.setString(9, concert.getImageUrl());
            stmt.setString(10, concert.getDescription());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateConcert(Concert concert) throws SQLException {
        String sql = "UPDATE concerts SET title = ?, city = ?, venue = ?, concert_time = ?, total_tickets = ?, available_tickets = ?, price = ?, status = ?, image_url = ?, description = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, concert.getTitle());
            stmt.setString(2, concert.getCity());
            stmt.setString(3, concert.getVenue());
            stmt.setTimestamp(4, new Timestamp(concert.getConcertTime().getTime()));
            stmt.setInt(5, concert.getTotalTickets());
            stmt.setInt(6, concert.getAvailableTickets());
            stmt.setDouble(7, concert.getPrice());
            stmt.setString(8, concert.getStatus());
            stmt.setString(9, concert.getImageUrl());
            stmt.setString(10, concert.getDescription());
            stmt.setLong(11, concert.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean deleteConcert(Long id) throws SQLException {
        String sql = "DELETE FROM concerts WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    private Concert extractConcertFromResultSet(ResultSet rs) throws SQLException {
        Concert concert = new Concert();
        concert.setId(rs.getLong("id"));
        concert.setTitle(rs.getString("title"));
        concert.setCity(rs.getString("city"));
        concert.setVenue(rs.getString("venue"));
        concert.setConcertTime(rs.getTimestamp("concert_time"));
        concert.setTotalTickets(rs.getInt("total_tickets"));
        concert.setAvailableTickets(rs.getInt("available_tickets"));
        concert.setPrice(rs.getDouble("price"));
        concert.setStatus(rs.getString("status"));
        concert.setImageUrl(rs.getString("image_url"));
        concert.setDescription(rs.getString("description"));
        concert.setCreateTime(rs.getTimestamp("create_time"));
        return concert;
    }
}