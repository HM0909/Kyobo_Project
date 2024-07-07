package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/MemberDelete.do")
public class MemberDeleteController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // GET 요청을 받아서 Delete.jsp 페이지로 포워드합니다.
        req.getRequestDispatcher("/Delete.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session2 = req.getSession(false);
        MemberDTO user = (session2 != null) ? (MemberDTO) session2.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login/Login.do");
            return;
        }

        MemberDAO dao = new MemberDAO();
        boolean result = dao.deleteMember(user.getUser_id());
        dao.close();

        if (result) {
            session2.invalidate();
            req.setAttribute("message", "회원 탈퇴가 성공적으로 처리되었습니다.");
        } else {
            req.setAttribute("message", "회원 탈퇴에 실패했습니다.");
        }

        // 탈퇴 후 Index.jsp로 리다이렉트합니다.
        resp.sendRedirect(req.getContextPath() + "/Index.jsp");
    }
}
