package companymember;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import book.BookDTO;
import comm.JDBConnect;
import notice.NoticeDTO;

public class MemberDAO extends JDBConnect {

	/*
	 * public MemberDAO(String driver, String url,String id,String pwd){
	 * super(driver, url, id, pwd); }
	 * 
	 * // 아이디와 패스워드의 일치 유무를 확인하고 정보를 반환 public MemberDTO getMemberDTO(String uid,
	 * String upass) {
	 * 
	 * MemberDTO dto = new MemberDTO();
	 * 
	 * String query = "select * from member where id =? and pass=?";
	 * 
	 * try { pstmt = con.prepareStatement(query); pstmt.setString(1, uid);
	 * pstmt.setString(2, upass); rs = pstmt.executeQuery();
	 * 
	 * if(rs.next()) { dto.setId(rs.getString("id"));
	 * dto.setPwd(rs.getString("pass")); dto.setName(rs.getString(3));
	 * dto.setRegidate(rs.getString(4)); }
	 * 
	 * }catch(Exception e){ e.printStackTrace(); }
	 * 
	 * return dto; }
	 */
	
	// 회원 데이터를 받아 DB에 추가합니다.
		public int insertMember(MemberDTO dto) {
			   
		       int result = 0;
		       String query = "INSERT INTO companyMember "
		       		+ "(id, password, name, nameno, phone, address, email, bank, accname, bankno, regidate ) "
		       		+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
	
		       try {
		           // DB 연결 확인
		           if (con == null) {
		               System.out.println("DB 연결이 없습니다.");
		               return 0;
		           }
		           
	
		           PreparedStatement pstmt = con.prepareStatement(query);
		           pstmt.setString(1, dto.getId());
		           pstmt.setString(2, dto.getPassword());
		           pstmt.setString(3, dto.getName());
		           pstmt.setString(4, dto.getNameno());
		           pstmt.setString(5, dto.getPhone());
		           pstmt.setString(6, dto.getAddress());
		           pstmt.setString(7, dto.getEmail());
		           pstmt.setString(8, dto.getBank());
		           pstmt.setString(9, dto.getAccname());
		           pstmt.setString(10, dto.getBankno());
		           
		           // 디버깅 정보 출력
		           result = pstmt.executeUpdate();
		       } catch (SQLException e) { 
		           e.printStackTrace();
		       }
		       return result;
		   }
	
	
		public MemberDTO selectView(String id, String password) {
			MemberDTO dto = new MemberDTO();

		    String query = "SELECT id, name, nameno, phone, address, email, bank, accname, bankno, regidate "
		                 + "FROM companyMember "
		                 + "WHERE id = ? "
		                 + "AND password = ? ";
		    
		    try {
		        pstmt = con.prepareStatement(query);
		        pstmt.setString(1, id);
		        pstmt.setString(2, password);

		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            dto.setId(rs.getString(1));
		            dto.setName(rs.getString(2));
		            dto.setNameno(rs.getString(3));
		            dto.setPhone(rs.getString(4));
		            dto.setAddress(rs.getString(5));
		            dto.setEmail(rs.getString(6));
		            dto.setBank(rs.getString(7));
		            dto.setAccname(rs.getString(8));
		            dto.setBankno(rs.getString(9));
		            dto.setRegidate(rs.getDate(10));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return dto;
		}
		
		// 회원정보를 찾아 내용을 반환합니다.
			public MemberDTO selectView(String id) {
			    MemberDTO dto = new MemberDTO();
	
			    String query = "SELECT id, password, name, nameno, phone, address, email, bank, accname, bankno, regidate "
			                 + "FROM companyMember "
			                 + "WHERE id = ?";
			    System.out.println("query : " + query);
			    System.out.println("id : " + id);
			    try {
			        pstmt = con.prepareStatement(query);
			        pstmt.setString(1, id);
	
			        rs = pstmt.executeQuery();
	
			        if (rs.next()) {
			            dto.setId(rs.getString(1));
			            dto.setPassword(rs.getString(2));
			            dto.setName(rs.getString(3));
			            dto.setNameno(rs.getString(4));
			            dto.setPhone(rs.getString(5));
			            dto.setAddress(rs.getString(6));
			            dto.setEmail(rs.getString(7));
			            dto.setBank(rs.getString(8));
			            dto.setAccname(rs.getString(9));
			            dto.setBankno(rs.getString(10));
			            dto.setRegidate(rs.getDate(11));
			        }
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
	
			    return dto;
			}
			
			// 지정한 게시물을 수정합니다.
			public int updateEdit(MemberDTO dto) {
				
				int result = 0;
				
				String query = "update companyMember set "
						+ "password = ?, "
						+ "name= ?, "
						+ "nameno= ?, "
						+ "phone = ?, "
						+ "address = ?, "
						+ "email =?, "
						+ "bank = ?, "
						+ "accname = ?, "
						+ "bankno = ? "
						+ "WHERE id = ?";
				
				try {
					// DB 연결 확인
					if (con == null) {
						System.out.println("DB 연결이 없습니다.");
						return 0;
					}
										
					PreparedStatement pstmt = con.prepareStatement(query);
					pstmt.setString(1, dto.getPassword());
					pstmt.setString(2, dto.getName());
					pstmt.setString(3, dto.getNameno());
					pstmt.setString(4, dto.getPhone());
					pstmt.setString(5, dto.getAddress());
					pstmt.setString(6, dto.getEmail());
					pstmt.setString(7, dto.getBank());
					pstmt.setString(8, dto.getAccname());
					pstmt.setString(9, dto.getBankno());
					pstmt.setString(10, dto.getId());
		            
		            result = pstmt.executeUpdate();
				} catch(Exception e) {
					e.printStackTrace();
				}
				
				return result;
			}
			
			// 회원 탈퇴 처리.
			public int deletePost(String id) {
				int result = 0 ;
				
				try {
					String query = "DELETE FROM companyMember WHERE id = ?";
					
					// DB 연결 확인
					if (con == null) {
						System.out.println("DB 연결이 없습니다.");
						return 0;
					}

					PreparedStatement pstmt = con.prepareStatement(query);
					pstmt.setString(1, id); 

					result = pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}

				return result;
			}
			
	}