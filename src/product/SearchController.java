package product;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/product/Search.do")
public class SearchController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        // 페이지 번호와 페이지 크기를 파라미터로 받습니다.
        int pageNum = 1;
        int pageSize = 10; // 기본값: 10개씩 보기

        try {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        } catch (NumberFormatException e) {
            // pageNum 파라미터가 없거나 잘못된 값인 경우 기본값 사용
        }

        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (NumberFormatException e) {
            // pageSize 파라미터가 없거나 잘못된 값인 경우 기본값 사용
        }

        if (query == null || query.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Index.jsp");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        int totalCount = productDAO.getTotalCount(query); // 전체 검색 결과 수
        List<ProductDTO> searchResults = productDAO.searchProducts(query, pageNum, pageSize); // 페이지에 맞는 결과만 가져오기

        // 로그 추가
        System.out.println("SearchController - Query: " + query + ", PageNum: " + pageNum + ", PageSize: " + pageSize);
        System.out.println("SearchController - TotalCount: " + totalCount);
        System.out.println("SearchController - SearchResults: " + searchResults.size());

        request.setAttribute("searchResults", searchResults);
        request.setAttribute("query", query);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("pageSize", pageSize);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Search.jsp");
        dispatcher.forward(request, response);
    }
}
