package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import comm.DBConnPool;

public class OrderDAO extends DBConnPool {

    // 시퀀스에서 다음 값을 가져오는 메서드
    public long getNextOrderId() throws SQLException {
        long orderId = 0;
        String query = "SELECT orders_seq.NEXTVAL FROM DUAL";
        
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                orderId = rs.getLong(1);
            }
        }
        
        return orderId;
    }

    // 주문을 삽입하는 메서드
    public int insertOrder(OrderDTO order) {
        int result = 0;
        String query = "INSERT INTO orders (order_id, user_id, order_date, total_amount) VALUES (?, ?, ?, ?)";
        
        try {
            long orderId = getNextOrderId(); // 새로운 주문 ID 생성
            
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setLong(1, orderId);
                pstmt.setString(2, order.getUser_id());
                pstmt.setTimestamp(3, order.getOrder_date());
                pstmt.setDouble(4, order.getTotal_amount());
                
                result = pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return result;
    }
}
