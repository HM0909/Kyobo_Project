package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/IdFind.do")
public class MemberIdFindController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/FindId.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        MemberDAO dao = new MemberDAO();
        String userId = dao.findIdByEmail(email);
        dao.close();

        String message;
        if (userId != null) {
            message = "회원님의 아이디는 " + userId + " 입니다.";
        } else {
            message = "입력하신 이메일로 등록된 아이디가 없습니다.";
        }

        req.setAttribute("message", message);
        req.getRequestDispatcher("/FindResult.jsp").forward(req, resp);
    }
}
