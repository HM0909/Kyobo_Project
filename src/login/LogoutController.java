package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/login/Logout.do")
public class LogoutController extends HttpServlet {
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		
		if(session != null) { // 만약 세션이 존재하면
			session.invalidate(); // 세션에 속해있는 값들을 모두 없앤다.
		}
		
		resp.sendRedirect(req.getContextPath() + "/index.do");
	}

}
