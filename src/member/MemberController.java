package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/Member.do")
public class MemberController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Sign.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 요청 파라미터 가져오기
        String userId = req.getParameter("user_id");
        String userPw = req.getParameter("user_pw");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String ageStr = req.getParameter("age");
        java.sql.Date age = java.sql.Date.valueOf(ageStr);

        // DTO 객체에 설정
        MemberDTO dto = new MemberDTO();
        dto.setUser_id(userId);
        dto.setUser_pw(userPw);
        dto.setName(name);
        dto.setEmail(email);
        dto.setAge(age);

        // DAO를 통해 데이터베이스에 삽입
        MemberDAO dao = new MemberDAO();
        int result = dao.insert(dto);
        dao.close();

        // 결과에 따른 페이지 이동
        if (result == 1) {
        	resp.sendRedirect(req.getContextPath() + "/SignUp.jsp");
        } else {
        	resp.sendRedirect(req.getContextPath() + "/member/Member.do");
        }
    }
}
