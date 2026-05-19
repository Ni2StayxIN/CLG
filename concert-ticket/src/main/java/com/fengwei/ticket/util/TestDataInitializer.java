package com.fengwei.ticket.util;

import com.fengwei.ticket.dao.ConcertDAO;
import com.fengwei.ticket.entity.Concert;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

public class TestDataInitializer {
    
    public static void main(String[] args) {
        System.out.println("=== 手动初始化国外演唱会数据 ===");
        
        try {
            initForeignConcerts();
        } catch (Exception e) {
            System.out.println("初始化失败：");
            e.printStackTrace();
        }
    }
    
    public static void initForeignConcerts() throws SQLException {
        ConcertDAO concertDAO = new ConcertDAO();
        
        // 添加国外演唱会数据
        System.out.println("开始添加国外演唱会...");
        
        // 添加不同国家的演唱会
        addConcert(concertDAO, "Taylor Swift - The Eras Tour", "Los Angeles", "SoFi Stadium", 
                  createFutureDate(60), 50000, 15000, 299.99, 
                  "active", "https://picsum.photos/id/1/800/500", 
                  "Taylor Swift's massive stadium tour featuring all her iconic eras. Don't miss this spectacular show!");
        
        addConcert(concertDAO, "Coldplay - Music of the Spheres World Tour", "London", "Wembley Stadium", 
                  createFutureDate(90), 70000, 20000, 189.99, 
                  "active", "https://picsum.photos/id/2/800/500", 
                  "Coldplay brings their breathtaking production to London's Wembley Stadium. An unforgettable experience!");
        
        addConcert(concertDAO, "ARASHI LIVE TOUR 2024", "Tokyo", "Tokyo Dome", 
                  createFutureDate(45), 55000, 10000, 159.99, 
                  "active", "https://picsum.photos/id/3/800/500", 
                  "Japan's most popular boy band returns with their spectacular live show at Tokyo Dome.");
        
        addConcert(concertDAO, "Ed Sheeran - + - = ÷ x Tour", "Paris", "Stade de France", 
                  createFutureDate(120), 80000, 25000, 179.99, 
                  "active", "https://picsum.photos/id/4/800/500", 
                  "Ed Sheeran's global stadium tour makes a stop at Paris' iconic Stade de France.");
        
        addConcert(concertDAO, "Billie Eilish - Happier Than Ever World Tour", "Sydney", "Accor Stadium", 
                  createFutureDate(75), 45000, 12000, 219.99, 
                  "active", "https://picsum.photos/id/5/800/500", 
                  "Billie Eilish brings her critically acclaimed tour to Sydney with her unique style and sound.");
        
        addConcert(concertDAO, "BTS World Tour 2024", "Seoul", "Seoul Olympic Stadium", 
                  createFutureDate(30), 60000, 5000, 249.99, 
                  "active", "https://picsum.photos/id/6/800/500", 
                  "Global K-pop sensation BTS returns to their home country for an epic stadium show.");
        
        addConcert(concertDAO, "Metallica - M72 World Tour", "Berlin", "Olympiastadion Berlin", 
                  createFutureDate(100), 75000, 18000, 199.99, 
                  "active", "https://picsum.photos/id/7/800/500", 
                  "Metallica's massive M72 World Tour features two nights of unique setlists in each city.");
        
        addConcert(concertDAO, "Adele - Weekends with Adele", "Milan", "San Siro Stadium", 
                  createFutureDate(130), 85000, 15000, 269.99, 
                  "active", "https://picsum.photos/id/8/800/500", 
                  "Adele brings her record-breaking residency experience to Europe for limited stadium shows.");
        
        addConcert(concertDAO, "Drake - It's All a Blur Tour", "Toronto", "Scotiabank Arena", 
                  createFutureDate(50), 20000, 5000, 229.99, 
                  "active", "https://picsum.photos/id/9/800/500", 
                  "Drake returns to his hometown for multiple shows at Toronto's Scotiabank Arena.");
        
        addConcert(concertDAO, "Rosalía - Motomami World Tour", "Barcelona", "Palau Sant Jordi", 
                  createFutureDate(65), 18000, 6000, 149.99, 
                  "active", "https://picsum.photos/id/10/800/500", 
                  "Grammy-winning artist Rosalía presents her critically acclaimed Motomami show in Barcelona.");
        
        System.out.println("国外演唱会数据添加完成！");
    }
    
    private static void addConcert(ConcertDAO dao, String title, String city, String venue, Date time, 
                          int totalTickets, int availableTickets, double price, 
                          String status, String imageUrl, String description) throws SQLException {
        try {
            Concert concert = new Concert();
            concert.setTitle(title);
            concert.setCity(city);
            concert.setVenue(venue);
            concert.setConcertTime(time);
            concert.setTotalTickets(totalTickets);
            concert.setAvailableTickets(availableTickets);
            concert.setPrice(price);
            concert.setStatus(status);
            concert.setImageUrl(imageUrl);
            concert.setDescription(description);
            
            boolean created = dao.createConcert(concert);
            if (created) {
                System.out.println("✅ 成功添加演唱会：" + title + " - " + city);
            } else {
                System.out.println("❌ 添加演唱会失败：" + title);
            }
        } catch (SQLException e) {
            System.out.println("❌ 添加演唱会时出错：" + title);
            throw e;
        }
    }
    
    private static Date createFutureDate(int daysFromNow) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR, daysFromNow);
        calendar.set(Calendar.HOUR_OF_DAY, 19);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar.getTime();
    }
}