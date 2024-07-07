package cart;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import product.ProductDAO;
import product.ProductDTO;

@WebServlet("/cart/Cart.do")
public class CartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login/Login.do");
            return;
        }

        String action = request.getParameter("action");
        if ("updateQuantity".equals(action)) {
            updateQuantity(request, response);
        } else if ("deleteItem".equals(action)) {
            deleteItem(request, response);
        } else {
            addItemToCart(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login/Login.do");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        List<CartDTO> cartItems = cartDAO.getCartItems(session.getAttribute("user_id").toString());

        request.setAttribute("cartItems", cartItems);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Cart.jsp");
        dispatcher.forward(request, response);
    }

    private void addItemToCart(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String isbnParam = request.getParameter("isbn");
        String quantityParam = request.getParameter("quantity");

        if (isbnParam == null || quantityParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ISBN or quantity");
            return;
        }

        int quantity;
        int isbn;
        try {
            quantity = Integer.parseInt(quantityParam);
            isbn = Integer.parseInt(isbnParam); // String을 int로 변환
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity or ISBN format");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        ProductDTO product = productDAO.getProductByIsbn(isbn);

        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        CartDTO cartItem = new CartDTO();
        HttpSession session = request.getSession(false);
        cartItem.setUser_id(session.getAttribute("user_id").toString());
        cartItem.setIsbn(String.valueOf(isbn)); // ISBN을 String으로 저장
        cartItem.setQuantity(quantity);

        int result = cartDAO.insertCartItem(cartItem);

        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/cart/Cart.do");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add item to cart");
        }
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login/Login.do");
            return;
        }

        String cartId = request.getParameter("cartId");
        String quantityParam = request.getParameter("quantity");

        if (cartId == null || quantityParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing cartId or quantity");
            return;
        }

        int quantity;
        try {
            quantity = Integer.parseInt(quantityParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity format");
            return;
        }

        CartDTO cartItem = new CartDTO();
        cartItem.setCart_id(Long.parseLong(cartId));
        cartItem.setQuantity(quantity);

        CartDAO cartDAO = new CartDAO();
        int result = cartDAO.updateCartItem(cartItem);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String jsonResponse = "{ \"success\": " + (result > 0) + " }";
        out.print(jsonResponse);
        out.flush();
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login/Login.do");
            return;
        }

        String cartId = request.getParameter("cartId");

        if (cartId == null || cartId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing cartId");
            return;
        }

        try {
            long cartIdLong = Long.parseLong(cartId);
            CartDAO cartDAO = new CartDAO();
            int result = cartDAO.deleteCartItem(cartIdLong);

            // 수량 업데이트 처리
            Map<String, String[]> parameterMap = request.getParameterMap();
            for (String key : parameterMap.keySet()) {
                if (key.startsWith("updatedQuantities[")) {
                    long id = Long.parseLong(key.substring(19, key.length() - 1));
                    int quantity = Integer.parseInt(request.getParameter(key));
                    CartDTO cartItem = new CartDTO();
                    cartItem.setCart_id(id);
                    cartItem.setQuantity(quantity);
                    cartDAO.updateCartItem(cartItem);
                }
            }

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            String jsonResponse = "{ \"success\": " + (result > 0) + " }";
            out.print(jsonResponse);
            out.flush();

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid cartId format");
        }
    }
}
