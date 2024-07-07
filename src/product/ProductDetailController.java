package product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/product/ProductDetail.do")
public class ProductDetailController extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "C:/Users/MD/Desktop/Project/DBIMG";
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 10; // 10MB

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isbnParam = request.getParameter("isbn");
        int isbn = Integer.parseInt(isbnParam); // String을 int로 변환
        ProductDAO dao = new ProductDAO();
        ProductDTO product = dao.getProductByIsbn(isbn);

        if (product != null) {
            request.setAttribute("product", product);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/ProductDetail.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            MultipartRequest multipartRequest = new MultipartRequest(
                request, UPLOAD_DIRECTORY, MAX_FILE_SIZE, "UTF-8", new DefaultFileRenamePolicy());

            String fileName = multipartRequest.getFilesystemName("file");
            String isbnParam = multipartRequest.getParameter("isbn");
            int isbn = Integer.parseInt(isbnParam); // String을 int로 변환

            // 이미지 경로를 클라이언트가 접근 가능한 경로로 설정합니다.
            String imagePath = request.getContextPath() + "/DBIMG/" + fileName;

            ProductDAO dao = new ProductDAO();
            dao.updateProductImage(isbn, imagePath);

            response.sendRedirect(request.getContextPath() + "/product/ProductDetail.do?isbn=" + isbn);
        } catch (Exception ex) {
            request.setAttribute("message", "File Upload Failed due to " + ex);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
