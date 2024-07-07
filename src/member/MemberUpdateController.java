package member;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/MemberInfo.do")
public class MemberUpdateController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        MemberDTO user = (session != null) ? (MemberDTO) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login/Login.do");
            return;
        }

        MemberDAO dao = new MemberDAO();
        MemberDTO dto = dao.getMemberDTO(user.getUser_id(), user.getUser_pw());
        dao.close();

        req.setAttribute("user", dto);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/MemberInformation.jsp");
        dispatcher.forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        MemberDTO user = (session != null) ? (MemberDTO) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login/Login.do");
            return;
        }

        // 폼에서 전달된 데이터를 가져옵니다.
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("user_pw");
        String birthdateStr = request.getParameter("birthdate");

        // 사용자 정보 업데이트
        user.setUser_id(name);
        user.setUser_pw(password);
        user.setEmail(email);

        try {
            java.sql.Date birthdate = java.sql.Date.valueOf(birthdateStr);
            user.setAge(birthdate);
        } catch (Exception e) {
            e.printStackTrace();
        }

        MemberDAO dao = new MemberDAO();
        dao.updateMember(user);
        dao.close();

        response.sendRedirect(request.getContextPath() + "/Index.jsp");
    }
}
