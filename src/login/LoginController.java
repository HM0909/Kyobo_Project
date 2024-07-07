package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import member.MemberDAO;
import member.MemberDTO;

@WebServlet("/login/Login.do")
public class LoginController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Login.jsp").forward(req, resp);
        System.out.println("doGet called");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 디버깅 메시지 출력
        System.out.println("doPost called");

        // 요청 파라미터 가져오기
        String userId = req.getParameter("user_id");
        String userPw = req.getParameter("user_pw");

        // 디버깅 메시지 출력
        System.out.println("User ID: " + userId);
        System.out.println("User PW: " + userPw);

        // DAO를 통해 데이터 읽기
        MemberDAO dao = new MemberDAO();
        MemberDTO dto = dao.getMemberDTO(userId, userPw);
        dao.close();

        // 사용자 인증
        HttpSession session = req.getSession();
        if (dto != null) {
            session.setAttribute("user", dto);
            session.setAttribute("user_id", userId); // user_id를 세션에 직접 설정
            session.setAttribute("loginSuccess", true);
            resp.sendRedirect(req.getContextPath() + "/index.do");
        } else {
            // 로그인 실패 시 로그인 페이지로 포워딩
            session.setAttribute("loginSuccess", false);
            req.setAttribute("loginFailed", true);
            req.getRequestDispatcher("/Login.jsp").forward(req, resp);
        }
    }
}
