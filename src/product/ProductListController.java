package product;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ProductListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        String sortOrder = request.getParameter("sortOrder");
        int pageNum = 1;
        int pageSize = 10;

        // pageNum 파라미터가 있을 경우 파싱
        if (request.getParameter("pageNum") != null) {
            try {
                pageNum = Integer.parseInt(request.getParameter("pageNum"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // pageSize 파라미터가 있을 경우 파싱
        if (request.getParameter("pageSize") != null) {
            try {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // 로그 추가
        System.out.println("Category: " + category + ", SortOrder: " + sortOrder + ", PageNum: " + pageNum + ", PageSize: " + pageSize);

        // ProductDAO를 사용하여 데이터베이스에서 데이터를 가져옴
        ProductDAO dao = new ProductDAO();
        int categoryNo = Integer.parseInt(category);
        List<ProductDTO> products = null;
        
        if ("highest".equals(sortOrder)) {
            products = dao.selectProductByHighestPrice(categoryNo, pageNum, pageSize);
        } else if ("lowest".equals(sortOrder)) {
            products = dao.selectProductByLowestPrice(categoryNo, pageNum, pageSize);
        } else if ("newest".equals(sortOrder)) {
            products = dao.selectProductByNewest(categoryNo, pageNum, pageSize);
        } else {
            products = dao.selectProductCategory(categoryNo, pageNum, pageSize);
        }

        int totalCount = dao.getTotalCountByCategory(categoryNo);

        // 데이터를 JSP로 전달
        if (products != null) {
            request.setAttribute("products", products);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("pageNum", pageNum);
            request.setAttribute("categoryName", category);
            request.setAttribute("sortOrder", sortOrder);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/IT.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Products not found");
        }
    }
}
