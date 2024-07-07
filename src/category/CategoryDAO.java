package category;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import comm.DBConnPool;

public class CategoryDAO extends DBConnPool{

	public List<CategoryDTO> selectCategories(){
		List<CategoryDTO> categories = new ArrayList<CategoryDTO>();
		
		String query = "SELECT CATEGORYNO, CATEGORYNAME FROM CATEGORY";
		
		
		try {
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
		
		if (rs.next()) {
			CategoryDTO dto = new CategoryDTO();
			dto.setCategoryNo(rs.getInt("categoryNo"));
			dto.setCategoryName(rs.getString("categoryName"));
			categories.add(dto); // DTO객체 List에 추가
		}
		
		} catch (Exception e) {
			
		}
		return categories;
	}
}
