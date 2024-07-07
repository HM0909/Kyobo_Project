package product;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import comm.DBConnPool;

public class ProductDAO extends DBConnPool {
    
    public ProductDAO() {
        super(); // DBConnPool의 생성자를 호출하여 데이터베이스 연결 초기화
    }

    // 카테고리 번호로 제품을 선택하는 메서드 (페이징 포함)
    public List<ProductDTO> selectProductCategory(int categoryNo, int pageNum, int pageSize) {
        List<ProductDTO> productDTOList = new ArrayList<>();
        String query = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL WHERE CATAGORYNO = ? ORDER BY PUBDATE DESC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, categoryNo);
            pstmt.setInt(2, pageNum * pageSize);
            pstmt.setInt(3, (pageNum - 1) * pageSize);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO dto = new ProductDTO();
                dto.setIsbn(rs.getInt("ISBN")); // int로 수정
                dto.setCategoryM(rs.getString("CATAGORYM"));
                dto.setBookTitle(rs.getString("BOOKTITLE"));
                dto.setAuthor(rs.getString("AUTHOR"));
                dto.setPublish(rs.getString("PUBLISH"));
                dto.setAge(rs.getString("AGE"));
                dto.setPubDate(rs.getString("PUBDATE"));
                dto.setPrice(rs.getInt("PRICE")); // int로 수정
                dto.setConInfo(rs.getString("CONINFO"));
                dto.setConTable(rs.getString("CONTABLE"));
                dto.setBookImg(rs.getString("BOOKIMG"));
                dto.setBookCover(rs.getString("BOOKCOVER"));
                dto.setBookFile(rs.getString("BOOKFILE"));
                dto.setSales(rs.getString("SALES"));
                dto.setId(rs.getString("ID"));
                dto.setCategoryNo(rs.getInt("CATAGORYNO"));
                productDTOList.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productDTOList;
    }

    // 전체 상품 수를 가져오는 메서드
    public int getTotalCountByCategory(int categoryNo) {
        int totalCount = 0;
        String query = "SELECT COUNT(*) FROM PRODUCTDITAIL WHERE CATAGORYNO = ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, categoryNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalCount;
    }

    // ISBN으로 제품을 선택하는 메서드
    public ProductDTO getProductByIsbn(int isbn) {
        ProductDTO product = null;
        String query = "SELECT * FROM PRODUCTDITAIL WHERE ISBN = ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, isbn);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    // 카테고리 이름으로 제품을 선택하는 메서드
    public List<ProductDTO> getProductsByCategory(String categoryName) {
        List<ProductDTO> productList = new ArrayList<>();
        String query = "SELECT * FROM PRODUCTDITAIL WHERE CATAGORYNO = (SELECT CATAGORYNO FROM CATEGORY WHERE CATAGORYNAME = ?)";
        
        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, categoryName);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return productList;
    }

    public List<ProductDTO> searchProducts(String query, int pageNum, int pageSize) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL WHERE LOWER(BOOKTITLE) LIKE LOWER(?) OR LOWER(AUTHOR) LIKE LOWER(?) ORDER BY PUBDATE DESC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + query + "%");
            pstmt.setString(2, "%" + query + "%");
            pstmt.setInt(3, end);
            pstmt.setInt(4, start);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // 로그 추가
        System.out.println("searchProductsInCategory - Query: " + query + ", PageNum: " + pageNum + ", PageSize: " + pageSize);
        System.out.println("searchProductsInCategory - Results: " + productList.size());
        
        return productList;
    }

    public int getTotalCount(String query) {
        int totalCount = 0;
        String sql = "SELECT COUNT(*) FROM PRODUCTDITAIL WHERE BOOKTITLE LIKE ? OR AUTHOR LIKE ?";

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + query + "%");
            pstmt.setString(2, "%" + query + "%");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCount;
    }

    public List<ProductDTO> searchProductsInCategory(String query, int categoryNo, int pageNum, int pageSize) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL WHERE (BOOKTITLE LIKE ? OR AUTHOR LIKE ?) AND CATAGORYNO = ? ORDER BY PUBDATE DESC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + query + "%");
            pstmt.setString(2, "%" + query + "%");
            pstmt.setInt(3, categoryNo);
            pstmt.setInt(4, end);
            pstmt.setInt(5, start);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
    
    public int getTotalCountByCategory(String query, int categoryNo) {
        int totalCount = 0;
        String sql = "SELECT COUNT(*) FROM PRODUCTDITAIL WHERE (BOOKTITLE LIKE ? OR AUTHOR LIKE ?) AND CATAGORYNO = ?";
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + query + "%");
            pstmt.setString(2, "%" + query + "%");
            pstmt.setInt(3, categoryNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCount;
    }

    // 이미지 경로 업데이트 메서드
    public void updateProductImage(int isbn, String imagePath) throws SQLException {
        String query = "UPDATE PRODUCTDITAIL SET BOOKIMG = ? WHERE ISBN = ?";

        try {
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, imagePath);
            pstmt.setInt(2, (isbn)); // int로 수정
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<ProductDTO> getLatestBooks(int limit) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCTDITAIL ORDER BY TO_DATE(PUBDATE, 'YYYY-MM-DD') DESC FETCH FIRST ? ROWS ONLY";

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        System.out.println("Latest books fetched: " + productList.size());
        return productList;
    }
    
    public List<ProductDTO> selectProductByHighestPrice(int categoryNo, int pageNum, int pageSize) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL WHERE CATAGORYNO = ? ORDER BY PRICE DESC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, categoryNo);
            pstmt.setInt(2, end);
            pstmt.setInt(3, start - 1);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
    
    public List<ProductDTO> selectProductByLowestPrice(int categoryNo, int pageNum, int pageSize) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL WHERE CATAGORYNO = ? ORDER BY PRICE ASC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, categoryNo);
            pstmt.setInt(2, end);
            pstmt.setInt(3, start - 1);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
    
    public List<ProductDTO> selectProductByNewest(int categoryNo, int pageNum, int pageSize) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL WHERE CATAGORYNO = ? ORDER BY PUBDATE DESC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, categoryNo);
            pstmt.setInt(2, end);
            pstmt.setInt(3, start - 1);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
    
 // 이름 순으로 정렬된 제품 목록을 가져오는 메서드
    public List<ProductDTO> getProductsByName(int pageNum, int pageSize) {
        List<ProductDTO> productList = new ArrayList<>();
        String sql = "SELECT * FROM ( "
                     + "SELECT A.*, ROWNUM AS RNUM "
                     + "FROM (SELECT * FROM PRODUCTDITAIL ORDER BY BOOKTITLE ASC) A "
                     + "WHERE ROWNUM <= ? "
                     + ") "
                     + "WHERE RNUM > ?";
        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;

        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, end);
            pstmt.setInt(2, start - 1);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setIsbn(rs.getInt("ISBN")); // int로 수정
                product.setCategoryM(rs.getString("CATAGORYM"));
                product.setBookTitle(rs.getString("BOOKTITLE"));
                product.setAuthor(rs.getString("AUTHOR"));
                product.setPublish(rs.getString("PUBLISH"));
                product.setAge(rs.getString("AGE"));
                product.setPubDate(rs.getString("PUBDATE"));
                product.setPrice(rs.getInt("PRICE")); // int로 수정
                product.setConInfo(rs.getString("CONINFO"));
                product.setConTable(rs.getString("CONTABLE"));
                product.setBookImg(rs.getString("BOOKIMG"));
                product.setBookCover(rs.getString("BOOKCOVER"));
                product.setBookFile(rs.getString("BOOKFILE"));
                product.setSales(rs.getString("SALES"));
                product.setId(rs.getString("ID"));
                product.setCategoryNo(rs.getInt("CATAGORYNO"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return productList;
    }
}

