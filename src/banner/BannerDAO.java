package banner;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import comm.DBConnPool;

public class BannerDAO extends DBConnPool {

    public List<BannerDTO> getBanners() {
        List<BannerDTO> banners = new ArrayList<>();
        String sql = "SELECT * FROM BANNER";
        try {
            con = getConnection();  // Connection 객체 생성
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                BannerDTO banner = new BannerDTO();
                banner.setId(rs.getInt("ID"));
                banner.setImagePath(rs.getString("IMAGEPATH"));
                banner.setTitle(rs.getString("TITLE"));
                banner.setDescription(rs.getString("DESCRIPTION"));
                banners.add(banner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();  // Connection 객체 닫기
        }
        return banners;
    }
}
