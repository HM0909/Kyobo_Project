package book;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import comm.JDBConnect;

public class BookDAO extends JDBConnect {
	public BookDAO(ServletContext application) {
		super(application);
	}
	// 검색 조건에 맞는 게시물의 개수를 반환합니다.

	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;

		String query = "select count(*) from Productditail";

//      if(map.get("searchWord") != null) {
//         query += " where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";   
//         // where title like '%봄%';   
//      }

		try {
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return totalCount;
	}

	// 게시글 데이터를 받아 DB에 추가합니다.(파일 업로드 지원).

	public int insertBook(BookDTO dto) {
		int result = 0;
		
		String query = "INSERT INTO Productditail "
				+ "(isbn, catagorym, booktitle, author, publish, age, pubdate, price, coninfo, contable, bookimg, bookcover, bookfile, id, catagoryno, regidate ) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , sysdate)";

		try {
			// DB 연결 확인
			if (con == null) {
				System.out.println("DB 연결이 없습니다.");
				return 0;
			}
			

			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, dto.getIsbn());
			pstmt.setString(2, dto.getCategorym());
			pstmt.setString(3, dto.getBooktitle());
			pstmt.setString(4, dto.getAuthor());
			pstmt.setString(5, dto.getPublish());
			pstmt.setString(6, dto.getAge());
			pstmt.setString(7, dto.getPubdate());
			pstmt.setInt(8, dto.getPrice());
			pstmt.setString(9, dto.getConinfo());
			pstmt.setString(10, dto.getContable());
			pstmt.setString(11, dto.getBookimg());
			pstmt.setString(12, dto.getBookcover());
			pstmt.setString(13, dto.getBookfile());
			pstmt.setString(14, dto.getId());
			pstmt.setInt(15, dto.getCatagoryno());

			// 디버깅 정보 출력
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}


	// 지정한 게시물을 수정합니다.
		public int updateEdit(BookDTO dto) {
			
			int result = 0;
			
			String query = "update Productditail set "
					+ "booktitle = ?, "
					+ "author= ?, "
					+ "publish= ?, "
					+ "age = ?, "
					+ "pubdate = ?, "
					+ "price =?, "
					+ "coninfo = ?, "
					+ "contable = ?, "
					+ "bookimg = ?, "
					+ "bookcover = ?, "
					+ "bookfile = ?, "
					+ "catagoryno = ? " 
							
					+ "WHERE isbn = ?";
			
			try {
				// DB 연결 확인
				if (con == null) {
					System.out.println("DB 연결이 없습니다.");
					return 0;
				}
				
				PreparedStatement pstmt = con.prepareStatement(query);				
				pstmt.setString(1, dto.getBooktitle());
				pstmt.setString(2, dto.getAuthor());
				pstmt.setString(3, dto.getPublish());
				pstmt.setString(4, dto.getAge());
				pstmt.setString(5, dto.getPubdate());
				pstmt.setInt(6, dto.getPrice());
				pstmt.setString(7, dto.getConinfo());
				pstmt.setString(8, dto.getContable());
				pstmt.setString(9, dto.getBookimg());
				pstmt.setString(10, dto.getBookcover());
				pstmt.setString(11, dto.getBookfile());
				pstmt.setInt(12, dto.getCatagoryno());
				pstmt.setInt(13, dto.getIsbn());
	            
	            result = pstmt.executeUpdate();
	        	
	        	
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return result;
		}
	
		
	// 게시글 데이터를 불러와 목록에 보여줍니다.

	public List<BookDTO> selectListPage(Map<String, Object> map) {
		List<BookDTO> bbs = new ArrayList<BookDTO>();

		String query = " select isbn,c.catagoryname,booktitle,author,publish, price,sales "
				+ " from productditail p inner join category c" 
				+ " on p.catagoryno = c.catagoryno "
				+ " order by regidate desc";

//      if(map.get("searchWord") != null) {
//         query += " where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%' ";   
//         // where title like '%봄%';   
//      }
//      
//      query += " order by regidate desc) tb "
//            + " )"
//            + " where rNum BETWEEN ? and ? "; 

		try {

			pstmt = con.prepareStatement(query);
//         pstmt.setString(1, map.get("start").toString());   // start
//         pstmt.setString(2, map.get("end").toString());     // end
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BookDTO dto = new BookDTO();

				dto.setIsbn(rs.getInt(1));
				dto.setCatagoryname(rs.getString(2));
				dto.setBooktitle(rs.getString(3));
				dto.setAuthor(rs.getString(4));
				dto.setPublish(rs.getString(5));
				dto.setPrice(rs.getInt(6));
				dto.setSales(rs.getString(7));

				bbs.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bbs;

	}

	// 지정한 게시물을 찾아 내용을 반환합니다.(상세보기)
	public BookDTO selectView(String isbn) {
		BookDTO dto = new BookDTO();

		String query = "SELECT isbn, booktitle, author, publish, age, pubdate, price, coninfo, contable, bookimg, bookcover, bookfile, catagoryno, catagorym "
				+ " FROM Productditail " 
				+ " WHERE isbn = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, isbn);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setIsbn(rs.getInt(1));
				dto.setBooktitle(rs.getString(2));
				dto.setAuthor(rs.getString(3));
				dto.setPublish(rs.getString(4));
				dto.setAge(rs.getString(5));
				dto.setPubdate(rs.getString(6));
				dto.setPrice(rs.getInt(7));
				dto.setConinfo(rs.getString(8));
				dto.setContable(rs.getString(9));
				dto.setBookimg(rs.getString(10));
				dto.setBookcover(rs.getString(11));
				dto.setBookfile(rs.getString(12));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}
	
	// 게시글 데이터를 삭제 처리.
	public int deletePost(String isbn) {
		int result = 0 ;
		
		try {
			String query = "DELETE FROM Productditail WHERE isbn = ?";
			
			// DB 연결 확인
			if (con == null) {
				System.out.println("DB 연결이 없습니다.");
				return 0;
			}

			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, isbn); 

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	

}
