package product;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import banner.BannerDAO;
import banner.BannerDTO;

@WebServlet("/index.do")
public class IndexController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        BannerDAO bannerDAO = new BannerDAO();

        List<ProductDTO> latestBooks = productDAO.getLatestBooks(4); // 최신 신간 도서 4권 가져오기
        List<ProductDTO> productsByName = productDAO.getProductsByName(1, 8); // 이름 순으로 정렬된 제품 목록 10개 가져오기
        List<BannerDTO> banners = bannerDAO.getBanners(); // 배너 정보 가져오기

        request.setAttribute("latestBooks", latestBooks);
        request.setAttribute("productsByName", productsByName);
        request.setAttribute("banners", banners);

        System.out.println("Latest books in controller: " + latestBooks.size());
        System.out.println("Banners in controller: " + banners.size());
        System.out.println("Products by name in controller: " + productsByName.size());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Index.jsp");
        dispatcher.forward(request, response);
    }
}
