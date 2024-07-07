package comm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBConnect {
	public Connection con;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	public JDBConnect() {
		try{
			
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			
			Class.forName(driver);  // ClassNotFoundException
			con = DriverManager.getConnection(url,"kyobo","1234"); //  SQLException
			
			System.out.println("DB연결 성공(기본생성자)");
		}catch(Exception e){
			
			e.printStackTrace();
			
		}
	}
	
	public JDBConnect(String driver,String url,String id,String pwd) {
		try{
				
			
			Class.forName(driver);  // ClassNotFoundException
			con = DriverManager.getConnection(url,id,pwd); //  SQLException
			
			System.out.println("DB연결 성공(인수생성자)");
		}catch(Exception e){
			
			e.printStackTrace();
			
		}
	}
	
	public JDBConnect(ServletContext application) {
		try{
				
			String driver = application.getInitParameter("OrcleDriver");
			Class.forName(driver);
			
			
			String url = application.getInitParameter("OrcleURL");
			String id = application.getInitParameter("OrcleId");
			String pwd = application.getInitParameter("OrclePwd");
			
			con = DriverManager.getConnection(url,id,pwd); //  SQLException

			
			System.out.println("DB연결 성공(인수생성자2)");
		}catch(Exception e){
			
			e.printStackTrace();
			
		}
	}
	
	public void close() {
		
		try {
			if(rs != null) {
				rs.close();
			}
			if(pstmt != null) {
				pstmt.close();
			}
			if(stmt != null) {
				stmt.close();
			}
			if(con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}










