package notice;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import comm.JDBConnect;

public class NoticeDAO extends JDBConnect {

    public int insertNotice(NoticeDTO dto) {
        int result = 0;
        String query = "INSERT INTO Notice (num, title, content, regidate) VALUES (seq_board_num.nextval, ?, ?, sysdate)";

        try {
            if (con == null) {
                System.out.println("DB 연결이 없습니다.");
                return 0;
            }
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<NoticeDTO> selectListPage(Map<String, Object> map) {
        List<NoticeDTO> bbs = new ArrayList<>();
        String query = "SELECT num, title, regidate FROM Notice ORDER BY regidate DESC";

        try {
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                NoticeDTO dto = new NoticeDTO();
                dto.setNum(rs.getInt(1));
                dto.setTitle(rs.getString(2));
                dto.setRegidate(rs.getDate(3));
                bbs.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bbs;
    }

    public NoticeDTO selectView(int num) {
        NoticeDTO dto = new NoticeDTO();
        String query = "SELECT num, title, content, regidate FROM Notice WHERE num = ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                dto.setNum(rs.getInt(1));
                dto.setTitle(rs.getString(2));
                dto.setContent(rs.getString(3));
                dto.setRegidate(rs.getDate(4));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    public int deletePost(String num) {
        int result = 0;
        try {
            String query = "DELETE FROM Notice WHERE num = ?";
            if (con == null) {
                System.out.println("DB 연결이 없습니다.");
                return 0;
            }
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, num);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
