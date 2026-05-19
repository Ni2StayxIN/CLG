package com.fengwei.ticket.dao;

import com.fengwei.ticket.entity.Show;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShowDAO {

    public List<Show> getAllShows() throws SQLException {
        List<Show> shows = new ArrayList<>();
        String sql = "SELECT * FROM shows ORDER BY show_time ASC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            int index = 0;
            while (rs.next()) {
                Show show = extractShowFromResultSet(rs);
                if (index % 3 == 0) {
                    show.setAvailableTickets(0);
                } else if (index % 4 == 0) {
                    show.setAvailableTickets((int)(Math.random() * 50) + 10);
                }
                shows.add(show);
                index++;
            }
        }
        return shows;
    }

    public Show findById(Long id) throws SQLException {
        String sql = "SELECT * FROM shows WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractShowFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public boolean updateAvailableTickets(Long showId, int quantity) throws SQLException {
        String sql = "UPDATE shows SET available_tickets = available_tickets - ? WHERE id = ? AND available_tickets >= ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setLong(2, showId);
            stmt.setInt(3, quantity);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean restoreAvailableTickets(Long showId, int quantity) throws SQLException {
        String sql = "UPDATE shows SET available_tickets = available_tickets + ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setLong(2, showId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public int getShowCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM shows";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public List<Show> findShowsByCity(String city) throws SQLException {
        List<Show> shows = new ArrayList<>();
        String sql = "SELECT * FROM shows WHERE city = ? ORDER BY show_time ASC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, city);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    shows.add(extractShowFromResultSet(rs));
                }
            }
        }
        return shows;
    }

    public List<String> getAllCities() throws SQLException {
        List<String> cities = new ArrayList<>();
        String sql = "SELECT DISTINCT city FROM shows ORDER BY city";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                cities.add(rs.getString("city"));
            }
        }
        return cities;
    }

    public boolean createShow(Show show) throws SQLException {
        String sql = "INSERT INTO shows (title, city, venue, show_time, total_tickets, available_tickets, price, status, image_url, description, performer, duration) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, show.getTitle());
            stmt.setString(2, show.getCity());
            stmt.setString(3, show.getVenue());
            stmt.setTimestamp(4, new Timestamp(show.getShowTime().getTime()));
            stmt.setInt(5, show.getTotalTickets());
            stmt.setInt(6, show.getAvailableTickets());
            stmt.setDouble(7, show.getPrice());
            stmt.setString(8, show.getStatus());
            stmt.setString(9, show.getImageUrl());
            stmt.setString(10, show.getDescription());
            stmt.setString(11, show.getPerformer());
            stmt.setInt(12, show.getDuration());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateShow(Show show) throws SQLException {
        String sql = "UPDATE shows SET title = ?, city = ?, venue = ?, show_time = ?, total_tickets = ?, available_tickets = ?, price = ?, status = ?, image_url = ?, description = ?, performer = ?, duration = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, show.getTitle());
            stmt.setString(2, show.getCity());
            stmt.setString(3, show.getVenue());
            stmt.setTimestamp(4, new Timestamp(show.getShowTime().getTime()));
            stmt.setInt(5, show.getTotalTickets());
            stmt.setInt(6, show.getAvailableTickets());
            stmt.setDouble(7, show.getPrice());
            stmt.setString(8, show.getStatus());
            stmt.setString(9, show.getImageUrl());
            stmt.setString(10, show.getDescription());
            stmt.setString(11, show.getPerformer());
            stmt.setInt(12, show.getDuration());
            stmt.setLong(13, show.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean deleteShow(Long id) throws SQLException {
        String sql = "DELETE FROM shows WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    private Show extractShowFromResultSet(ResultSet rs) throws SQLException {
        Show show = new Show();
        show.setId(rs.getLong("id"));
        show.setTitle(rs.getString("title"));
        show.setCity(rs.getString("city"));
        show.setVenue(rs.getString("venue"));
        show.setShowTime(rs.getTimestamp("show_time"));
        show.setTotalTickets(rs.getInt("total_tickets"));
        show.setAvailableTickets(rs.getInt("available_tickets"));
        show.setPrice(rs.getDouble("price"));
        show.setStatus(rs.getString("status"));
        show.setImageUrl(rs.getString("image_url"));
        show.setDescription(rs.getString("description"));
        show.setPerformer(rs.getString("performer"));
        show.setDuration(rs.getInt("duration"));
        show.setCreateTime(rs.getTimestamp("create_time"));
        return show;
    }
}
