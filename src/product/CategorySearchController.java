package product;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.SearchCategoryPage;
import util.SearchPage;

@WebServlet("/product/CategorySearch.do")
public class CategorySearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String categoryName = request.getParameter("categoryName");

        if (query == null || query.trim().isEmpty() || categoryName == null || categoryName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        int categoryNo = getCategoryNoFromName(categoryName);

        // 페이징 관련 파라미터 처리
        int pageNum = 1;
        int pageSize = 10; // 기본값

        if (request.getParameter("pageNum") != null) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }

        if (request.getParameter("pageSize") != null) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        // 검색 결과와 페이징 처리를 위한 메서드 호출
        List<ProductDTO> searchResults = productDAO.searchProductsInCategory(query, categoryNo, pageNum, pageSize);
        int totalCount = productDAO.getTotalCountByCategory(query, categoryNo);

        int blockPage = 5;
        String pagingStr = SearchCategoryPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI(), query, categoryName);

        request.setAttribute("searchResults", searchResults);
        request.setAttribute("query", query);
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("paging", pagingStr);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("pageSize", pageSize);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/SearchCategory.jsp");
        dispatcher.forward(request, response);
    }

    private int getCategoryNoFromName(String categoryName) {
        switch (categoryName.toLowerCase()) {
            case "economy":
                return 10;
            case "religion":
                return 20;
            case "development":
                return 30;
            case "it":
                return 40;
            case "humanities":
                return 50;
            default:
                return 0;
        }
    }
}
