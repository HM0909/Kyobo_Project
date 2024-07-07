package cart;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import comm.DBConnPool;

public class CartDAO extends DBConnPool {
    
    public int insertCartItem(CartDTO cart) {
        int result = 0;
        String query = "INSERT INTO cart (cart_id, user_id, isbn, quantity, added_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        
        try {
            // 시퀀스를 사용하여 새로운 CART_ID를 생성
            long cartId = getNextCartId();
            
            pstmt = con.prepareStatement(query);
            pstmt.setLong(1, cartId); // 새로운 CART_ID를 설정
            pstmt.setString(2, cart.getUser_id());
            pstmt.setString(3, cart.getIsbn());
            pstmt.setInt(4, cart.getQuantity());

            System.out.println("Executing query: " + pstmt.toString());
            result = pstmt.executeUpdate();
            System.out.println("Insert result: " + result);
        } catch (SQLException e) {
            System.out.println("SQL exception: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Unexpected exception: " + e.getMessage());
            e.printStackTrace();
        } 
        
        return result;
    }

    // 새로운 CART_ID를 생성하는 메서드
    private long getNextCartId() {
        String query = "SELECT cart_id_seq.NEXTVAL FROM DUAL";
        long cartId = 0;
        
        
        try {
        	pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
               cartId = rs.getLong(1);
            }
        } catch (Exception e) {
            System.out.println("Unexpected exception: " + e.getMessage());
            e.printStackTrace();
        } 
        
        return cartId;
    }

    public List<CartDTO>getCartItems(String userId) {
    	
    	System.out.println("getCartItems");
    	
        List<CartDTO> cartItems = new ArrayList<>();
        String query = "SELECT ISBN, SUM(QUANTITY) AS TOTAL_QUANTITY, USER_ID, MIN(ADDED_AT) AS FIRST_ADDED_AT " +
		                "FROM cart " +
		                "WHERE USER_ID = ? " +
		                "GROUP BY ISBN, USER_ID";

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CartDTO cart = new CartDTO();
                cart.setIsbn(rs.getString("ISBN"));
                cart.setQuantity(rs.getInt("TOTAL_QUANTITY"));
                cart.setUser_id(rs.getString("USER_ID"));
                cart.setAdded_at(rs.getTimestamp("FIRST_ADDED_AT"));
                cartItems.add(cart);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cartItems;
    }

    public int deleteCartItem(long cartId) {
        int result = 0;
        String query = "DELETE FROM cart WHERE cart_id = ?";
        
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setLong(1, cartId);
            
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQLException: " + e.getMessage());
            System.err.println("SQLState: " + e.getSQLState());
            System.err.println("VendorError: " + e.getErrorCode());
        }
        
        return result;
    }

    public int updateCartItem(CartDTO cart) {
        int result = 0;
        String query = "UPDATE cart SET quantity = ? WHERE cart_id = ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, cart.getQuantity());
            pstmt.setLong(2, cart.getCart_id());
            
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    public void clearCart(String userId) {
        String query = "DELETE FROM cart WHERE user_id = ?";
        
        try {
             pstmt = con.prepareStatement(query);
             
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
