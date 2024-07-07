package member;

import java.sql.SQLException;
import comm.DBConnPool;

public class MemberDAO extends DBConnPool {

    // 아이디와 패스워드의 일치 유무를 확인하고 정보를 반환
    public MemberDTO getMemberDTO(String uid, String upass) {
        MemberDTO dto = null;
        String query = "SELECT * FROM member WHERE user_id=? AND user_pw=?";
        
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, uid);
            pstmt.setString(2, upass);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                dto = new MemberDTO();
                dto.setUser_id(rs.getString("user_id"));
                dto.setUser_pw(rs.getString("user_pw"));
                dto.setName(rs.getString("name"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setEmail(rs.getString("email"));
                dto.setAge(rs.getDate("age"));  // or setBirthdate based on the correct field in DB
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return dto;
    }

    public int insert(MemberDTO memberDTO) {
        int result = 0;
        String query = "INSERT INTO member (user_id, user_pw, name, age, email, postdate) VALUES (?, ?, ?, ?, ?, sysdate)";
        
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, memberDTO.getUser_id());
            pstmt.setString(2, memberDTO.getUser_pw());
            pstmt.setString(3, memberDTO.getName());
            pstmt.setDate(4, memberDTO.getAge()); // 나이가 DATE 타입인 것을 확인했으므로 변경하지 않음
            pstmt.setString(5, memberDTO.getEmail());
            
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return result;
    }

    // 회원 정보 업데이트 메서드
    public int updateMember(MemberDTO memberDTO) {
        int result = 0;
        String query = "UPDATE member SET user_pw=?, name=?, email=?, age=? WHERE user_id=?";
        
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, memberDTO.getUser_pw());
            pstmt.setString(2, memberDTO.getName());
            pstmt.setString(3, memberDTO.getEmail());
            pstmt.setDate(4, memberDTO.getAge());
            pstmt.setString(5, memberDTO.getUser_id());
            
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 회원 탈퇴 메서드
    public boolean deleteMember(String userId) {
        boolean result = false;
        String query = "DELETE FROM member WHERE user_id = ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, userId);
            int affected = pstmt.executeUpdate();
            result = (affected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return result;
    }
    
 // ID 찾기
    public String findIdByEmail(String email) {
        String userId = null;
        String query = "SELECT user_id FROM member WHERE email = ?";
        
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                userId = rs.getString("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        
        return userId;
    }

    // 비밀번호 찾기
    public String findPwByEmail(String email) {
        String userPw = null;
        String query = "SELECT user_pw FROM member WHERE email = ?";
        
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                userPw = rs.getString("user_pw");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        
        return userPw;
    }
}
