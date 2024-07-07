package category;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.ProductDAO;
import product.ProductDTO;

@WebServlet("/category/Category.do")
public class CategoryController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("CategoryController doGet called");

        String action = req.getParameter("action");
        String categoryName = req.getParameter("categoryName");
        System.out.println("Action: " + action + ", CategoryName: " + categoryName);

        if (action == null) {
            action = "list"; // 기본적인 동작을 하도록 설정
        }

        ProductDAO productDAO = new ProductDAO();
        List<ProductDTO> products = null;

        int pageNum = 1;
        int pageSize = 10;

        if (req.getParameter("pageNum") != null) {
            try {
                pageNum = Integer.parseInt(req.getParameter("pageNum"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (req.getParameter("pageSize") != null) {
            try {
                pageSize = Integer.parseInt(req.getParameter("pageSize"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        int categoryNo = 0;
        if (categoryName != null) {
            switch (categoryName) {
                case "Economy":
                    categoryNo = 10;
                    break;
                case "Religion":
                    categoryNo = 20;
                    break;
                case "Development":
                    categoryNo = 30;
                    break;
                case "IT":
                    categoryNo = 40;
                    break;
                case "Humanities":
                    categoryNo = 50;
                    break;
                default:
                    break;
            }
        }

        if ("view".equals(action) && categoryNo != 0) {
            System.out.println("Category No: " + categoryNo);
            int totalCount = productDAO.getTotalCountByCategory(categoryNo);
            System.out.println("Total Count: " + totalCount);
            products = productDAO.selectProductCategory(categoryNo, pageNum, pageSize);
            System.out.println("Products: " + (products != null ? products.size() : "null"));
            req.setAttribute("products", products);
            req.setAttribute("totalCount", totalCount);
            req.setAttribute("pageSize", pageSize);
            req.setAttribute("pageNum", pageNum);
            req.setAttribute("categoryName", categoryName);

            // 카테고리별로 다른 JSP 페이지로 이동
            String jspPage = "/IT.jsp";
            if ("Economy".equals(categoryName)) {
                jspPage = "/Economy.jsp";
            } else if ("Religion".equals(categoryName)) {
                jspPage = "/Religion.jsp";
            } else if ("Development".equals(categoryName)) {
                jspPage = "/Development.jsp";
            } else if ("IT".equals(categoryName)) {
                jspPage = "/IT.jsp";
            } else if ("Humanities".equals(categoryName)) {
                jspPage = "/Humanities.jsp";
            }

            RequestDispatcher dispatcher = req.getRequestDispatcher(jspPage);
            dispatcher.forward(req, resp);
        } else {
            // 기본적인 리스트 뷰로 이동
            if (req.getParameter("categoryNo") != null) {
                try {
                    categoryNo = Integer.parseInt(req.getParameter("categoryNo"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            System.out.println("Category No: " + categoryNo);
            int totalCount = productDAO.getTotalCountByCategory(categoryNo);
            System.out.println("Total Count: " + totalCount);
            products = productDAO.selectProductCategory(categoryNo, pageNum, pageSize);
            System.out.println("Products: " + (products != null ? products.size() : "null"));
            req.setAttribute("products", products);
            req.setAttribute("totalCount", totalCount);
            req.setAttribute("pageSize", pageSize);
            req.setAttribute("pageNum", pageNum);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/productList.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
