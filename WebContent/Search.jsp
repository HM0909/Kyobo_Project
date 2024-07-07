<%@page import="util.SearchPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="product.ProductDTO" %>
<%
    HttpSession session2 = request.getSession(false);
    MemberDTO user = (session2 != null) ? (MemberDTO) session2.getAttribute("user") : null;
    boolean loggedIn = (user != null);

    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("searchResults");
    String query = (String) request.getAttribute("query");
    String categoryName = (String) request.getAttribute("categoryName");

    Integer totalCountObj = (Integer) request.getAttribute("totalCount");
    int totalCount = (totalCountObj != null) ? totalCountObj : 0;

    Integer pageSizeObj = (Integer) request.getAttribute("pageSize");
    int pageSize = (pageSizeObj != null) ? pageSizeObj : 10;

    int blockPage = 5;

    Integer pageNumObj = (Integer) request.getAttribute("pageNum");
    int pageNum = (pageNumObj != null) ? pageNumObj : 1;

    String reqUrl = request.getContextPath() + "/product/Search.do";

    String paging = SearchPage.pagingStr(totalCount, pageSize, blockPage, pageNum, reqUrl, query);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook - Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0 auto;
            padding: 0;
            width: 100%;
            max-width: 1440px;
            overflow-x: hidden;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            background-color: #fff;
        }
        .logo img {
            width: 174px;
            height: 92px;
        }
        .search-bar {
            flex: 1;
            display: flex;
            align-items: center; 
            justify-content: center;
            margin: 0 20px;
        }
        .search-bar form {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 25px;
            padding: 3px 20px;
            height: 40px;
            width: 100%;
            max-width: 500px;
        }
        .search-bar input[type="text"] {
            width: 100%;
            border: none;
            outline: none;
            padding: 10px;
            border-radius: 20px;
        }
        .search-bar button {
            background: none;
            border: none;
            cursor: pointer;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .user-info a {
            margin-left: 10px;
            text-decoration: none;
            color: #333;
            font-size: 18px;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        }
        .user-info a:hover {
            color: #007bff;
        }
        .user-info .login-signup a {
            text-decoration: none;
            color: black;
            font-size: 18px;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            margin-left: 15px;
            margin-top: -30px;
        }
        .user-info .login-signup a:hover {
            color: #007bff;
        }
        .footer {
            background-color: #f8f8f8;
            padding: 20px;
            border-top: 1px solid #ddd;
        }
        .footer .footer-links {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
        .footer .footer-links a {
            color: #333;
            text-decoration: none;
            margin: 0 10px;
        }
        .footer .company-info {
            text-align: center;
            color: #666;
            font-size: 14px;
        }
        .footer .social-icons {
            text-align: center;
            margin-top: 10px;
        }
        .footer .social-icons img {
            width: 30px;
            height: 30px;
            margin: 0 5px;
        }
        .main-content {
            padding: 20px;
        }
        .breadcrumb {
            padding: 10px 20px;
            background-color: #f8f8f8;
            border-bottom: 1px solid #ddd;
        }
        .breadcrumb a {
            color: #333;
            text-decoration: none;
            margin-right: 5px;
        }
        .breadcrumb a:after {
            content: '>';
            margin-left: 5px;
        }
        .breadcrumb a:last-child:after {
            content: '';
        }
        .filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .search-container {
            display: flex;
            align-items: center;
            flex: 1;
        }
        .search-container input[type="text"] {
            width: 400px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            outline: none;
        }
        .search-container button {
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-left: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        .select-container {
            display: flex;
            align-items: center;
        }
        .select-container select {
            margin-left: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            outline: none;
        }
        .book-list {
            display: flex;
            flex-direction: column;
        }
        .book-images {
            display: flex;
            border-bottom: 1px solid #ddd;
            padding: 20px 0;
        }
        .book-images img {
            width: 150px;
            height: 150px; 
            margin-right: 20px;
        }
        .book-info {
            flex: 1;
        }
        .book-title {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }
        .book-writer {
            margin: 5px 0;
        }
        .book-PublicationDay {
            margin: 5px 0;
        }
        .book-price {
            color: green;
            margin: 5px 0;
        }
        .book-Detail {
            margin: 10px 0;
            overflow: hidden;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2; 
            text-overflow: ellipsis; 
            white-space: normal; 
            height: calc(2 * 1.2em); 
        }
        .book-buttons {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .book-buttons button {
            margin: 5px 0;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }
        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            border: 1px solid #ddd;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
        }
        .pagination a.active {
            background-color: #333;
            color: white;
        }
        .nav {
            background-color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: center;
            border: none;
        }
        .nav ul {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
        }
        .nav li {
            margin-right: 40px;
        }
        .nav a {
            color: black;
            text-decoration: none;
            font-size: 30px; 
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 4px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .nav a:hover {
            background-color: #f0f0f0;
            color: #007bff;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Kyobo eBook" onclick="window.location.href='${pageContext.request.contextPath}/index.do'">
        </div>
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/product/Search.do" method="get">
                <input type="text" name="query" placeholder="통합검색" value="<%= query %>">
                <button type="submit">
                    <img src="${pageContext.request.contextPath}/images/찾기.png" alt="Search" style="width: 40px; height: 40px;">
                </button>
            </form>
        </div>
        <div class="user-info">
            <a href="${pageContext.request.contextPath}/cart/Cart.do"><img src="${pageContext.request.contextPath}/images/장바구니.png" alt="Cart"></a>
            <a href="${pageContext.request.contextPath}/member/MemberInfo.do"><img src="${pageContext.request.contextPath}/images/회원 아이콘.png" alt="User"></a>
            <div class="login-signup">
                <%
                    if (loggedIn) {
                        out.println("<span>어서오세요 " + user.getUser_id() + "님</span>");
                        out.println("<a href='login/Logout.do'>로그아웃</a>");
                    } else {
                        out.println("<a href='member/Member.do'>회원가입</a>");
                        out.println("<a href='login/Login.do'>로그인</a>");
                        out.println("<a href='#' onclick=''>공지사항</a>");
                    }
                %>
            </div>
        </div>
    </header>
    
    <nav class="nav">
        <ul>
            <li class="gnb_images">
                <a class="gnb_link" href="category/Category.do?action=view&categoryName=Economy">경제</a>
            </li>
            <li class="gnb_images">
                <a class="gnb_link" href="category/Category.do?action=view&categoryName=Religion">종교</a>
            </li>
            <li class="gnb_images">
                <a class="gnb_link" href="category/Category.do?action=view&categoryName=Development">자기계발</a>
            </li>
            <li class="gnb_images">
                <a class="gnb_link" href="category/Category.do?action=view&categoryName=IT">IT</a>
            </li>
            <li class="gnb_images">
                <a class="gnb_link" href="category/Category.do?action=view&categoryName=Humanities">인문</a>
            </li>
        </ul>
    </nav>

    <main class="main-content">
        <div class="breadcrumb">
            <a href="#">홈</a>
            <a href="#">검색 결과</a>
        </div>

        <div class="filter-bar">
            <div class="search-container">
                
            </div>
            <div class="select-container">
                <select>
                    <option>최신순</option>
                    <option>인기순</option>
                    <option>낮은 가격순</option>
                    <option>높은 가격순</option>
                </select>
                <select>
                    <option>10개씩 보기</option>
                    <option>20개씩 보기</option>
                </select>
            </div>
        </div>

        <div class="book-list">
            <% if (products != null && !products.isEmpty()) { %>
                <% for (ProductDTO product : products) { %>
                    <div class="book-images">
                        <img src="${pageContext.request.contextPath}/Uploads/<%= product.getBookCover() %>" alt="<%= product.getBookTitle() %>">
                        <div class="book-info">
                            <h3 class="book-title">
                                <a href="${pageContext.request.contextPath}/product/ProductDetail.do?isbn=<%= product.getIsbn() %>">
                                    <%= product.getBookTitle() %>
                                </a>
                            </h3>
                            <p class="book-writer"><%= product.getAuthor() %></p>
                            <p class="book-PublicationDay"><%= product.getPubDate() %></p>
                            <p class="book-price"><%= product.getPrice() %>원</p>
                            <p class="book-Detail"><%= product.getConInfo() %></p>
                        </div>
                        <div class="book-buttons">
                            <button class="add-to-cart" data-isbn="<%= product.getIsbn() %>">장바구니에 추가</button>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="book-images">
                    <p>검색 결과가 없습니다.</p>
                </div>
            <% } %>
        </div>

        <div class="pagination">
            <%= paging %>
        </div>
    </main>

    <footer class="footer">
        <div class="footer-links">
            <a href="#">회사소개</a>
            <a href="#">이용약관</a>
            <a href="#">개인정보처리방침</a>
            <a href="#">청소년보호정책</a>
            <a href="#">대량주문안내</a>
            <a href="#">협력사여러분</a>
            <a href="#">광고소개</a>
            <a href="#">서비스 가이드</a>
        </div>
        <div class="company-info">
            <p>대표이사: 안병현, 김상훈 | 서울특별시 종로구 종로 1 | 사업자등록번호: 102-81-11670</p>
            <p>대표전화: 1544-1900(발신자 부담전화) | FAX: 0502-987-5711(지역번호 공통) | 서울특별시 통신판매업신고번호: 제 653호</p>
            <p>© KYOOBO BOOK CENTRE</p>
        </div>
    </footer>

    <script>
    const contextPath = '<%= request.getContextPath() %>';
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
            const isbn = this.getAttribute('data-isbn');
            const quantity = 1; // Default quantity
            console.log(`Adding to cart: ISBN=${isbn}, Quantity=${quantity}`);

            fetch(`${contextPath}/cart/Cart.do`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `isbn=${isbn}&quantity=${quantity}`
            })
            .then(response => {
                if (response.ok) {
                    alert('장바구니에 추가되었습니다.');
                } else if (response.status === 401) {
                    alert('로그인이 필요합니다.');
                    window.location.href = `${contextPath}/login/Login.do`;
                } else {
                    console.error('Error response:', response);
                    alert('장바구니에 추가 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Fetch error:', error);
                alert('장바구니에 추가 중 오류가 발생했습니다.');
            });
        });
    });
    </script>
</body>
</html>
