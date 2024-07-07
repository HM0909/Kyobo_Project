package order;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import cart.CartDAO;
import cart.CartDTO;
import member.MemberDTO;

@WebServlet("/order/Order.do")
public class OrderController extends HttpServlet {

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        MemberDTO user = (session != null) ? (MemberDTO) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login/Login.do");
            return;
        }

        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        OrderDAO orderDAO = new OrderDAO();
        OrderDTO order = new OrderDTO();
        order.setUser_id(user.getUser_id());
        order.setOrder_date(new Timestamp(new Date().getTime()));
        order.setTotal_amount(totalAmount);

        int result = orderDAO.insertOrder(order);

        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/Order.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/orderFailure.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/order/Order.jsp");
        dispatcher.forward(request, response);
    }
}
