package com.fengwei.ticket.entity;

import java.time.LocalDateTime;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Order {
    private Long id;
    private Long userId;
    private Long concertId;
    private int quantity;
    private double totalAmount;
    private String status;
    private Date createTime;
    private String orderNumber;
    private String spectatorName;
    private String spectatorStudentId;
    private String spectatorPhone;
    private String seatInfo;
    // 新增属性，用于在订单页面显示演唱会信息
    private String concertName;
    private Date date;
    private String time;
    private String venue;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    // 为了匹配orders.jsp中的order.orderId
    public String getOrderId() { return orderNumber; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Long getConcertId() { return concertId; }
    public void setConcertId(Long concertId) { this.concertId = concertId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    
    // 为了匹配orders.jsp中的order.totalPrice
    public double getTotalPrice() { return totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public String getSpectatorName() { return spectatorName; }
    public void setSpectatorName(String spectatorName) { this.spectatorName = spectatorName; }

    public String getSpectatorStudentId() { return spectatorStudentId; }
    public void setSpectatorStudentId(String spectatorStudentId) { this.spectatorStudentId = spectatorStudentId; }

    public String getSpectatorPhone() { return spectatorPhone; }
    public void setSpectatorPhone(String spectatorPhone) { this.spectatorPhone = spectatorPhone; }

    public String getSeatInfo() { return seatInfo; }
    public void setSeatInfo(String seatInfo) { this.seatInfo = seatInfo; }
    
    // 新增属性的getter和setter方法
    public String getConcertName() { return concertName; }
    public void setConcertName(String concertName) { this.concertName = concertName; }
    
    public Date getDate() { return date; }
    public void setDate(Date date) {
        this.date = date;
        // 当设置date时，同时设置time
        if (date != null) {
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            this.time = timeFormat.format(date);
        }
    }
    
    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    
    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }
}