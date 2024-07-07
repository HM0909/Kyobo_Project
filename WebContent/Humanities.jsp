<%@page import="util.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="product.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="util.BoardPage" %>
<%
    HttpSession session2 = request.getSession(false);
    MemberDTO user = (session2 != null) ? (MemberDTO) session2.getAttribute("user") : null;
    boolean loggedIn = (user != null);
    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");

    Integer totalCountObj = (Integer) request.getAttribute("totalCount");
    int totalCount = (totalCountObj != null) ? totalCountObj : 0;

    Integer pageSizeObj = (Integer) request.getAttribute("pageSize");
    int pageSize = (pageSizeObj != null) ? pageSizeObj : 10;

    int blockPage = 5;

    Integer pageNumObj = (Integer) request.getAttribute("pageNum");
    int pageNum = (pageNumObj != null) ? pageNumObj : 1;

    String categoryName = request.getParameter("categoryName");
    String reqUrl = request.getContextPath() + "/category/Category.do";

    String order = request.getParameter("order");
    if (order == null || order.isEmpty()) {
        order = "newest";
    }

    String paging = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, reqUrl, categoryName);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook - Humanities</title>
    <style>
        /* 스타일은 기존 스타일 유지 */
        a:link { 
    		text-decoration:none;
    		font-size: 20px;
    	}

    body {
        font-family: Arial, sans-serif;
        margin: 0 auto;
        padding: 0;
        width: 1440px;
        height: 848px;
        overflow: hidden;
        justify-content: center;
        align-items: center;
        width: 100%;
        overflow: auto;
    }
    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 20px;
        background-color: #fff;
        border-bottom: none;
    }
    .logo img {
        width: 174px;
        height: 92px;
    }
    .search-bar {
        flex: 1;
        display: flex;
        align-items: center;
        margin-left: 10px;
        border: 1px solid #ddd;
        border-radius: 25px;
        padding: 5px 15px;
        height: 40px;
        max-width: 600px;
        position: relative;
    }
    .search-bar input[type="text"] {
        width: 100%;
        border: none;
        outline: none;
        padding: 5px;
        border-radius: 20px;
        height: 100%;
    }
    .search-bar button {
        background: none;
        border: none;
        cursor: pointer;
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
    }
    .search-bar button img {
        width: 40px;
        height: 20px;
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
    .nav .gnb_link.active {
        color: #17ba24;
        font-weight: bold;
    }
    .user-info .login-signup {
        display: flex;
        align-items: center;
        margin-left: 20px;
        margin-top: 40px;
    }
    .user-info .login-signup a {
        text-decoration: none;
        color: black;
        font-size: 18px;
        font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        margin-left: 15px;
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
                <input type="text" name="query" placeholder="통합검색">
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
                        out.println("<span><h3>어서오세요 '" + user.getUser_id() + "'님</h3></span>");
                        out.println("<a href='" + request.getContextPath() + "/login/Logout.do'>로그아웃</a>");
                    } else {
                        out.println("<a href='" + request.getContextPath() + "/member/Member.do'>회원가입</a>");
                        out.println("<a href='" + request.getContextPath() + "/login/Login.do'>로그인</a>");
                        out.println("<a href='" + request.getContextPath() + "/Notice/notice.do'>공지사항</a>");
                    }
                %>
            </div>
        </div>
    </header>
    
   <nav class="nav">
    <ul>
        <li class="gnb_images">
            <a class="gnb_link" href="/kyobo/category/Category.do?action=view&categoryName=Economy">경제</a>
        </li>
        <li class="gnb_images">
            <a class="gnb_link" href="/kyobo/category/Category.do?action=view&categoryName=Religion">종교</a>
        </li>
        <li class="gnb_images">
            <a class="gnb_link" href="/kyobo/category/Category.do?action=view&categoryName=Development">자기계발</a>
        </li>
        <li class="gnb_images">
            <a class="gnb_link" href="/kyobo/category/Category.do?action=view&categoryName=IT">IT</a>
        </li>
        <li class="gnb_images">
            <a class="gnb_link active" href="/kyobo/category/Category.do?action=view&categoryName=Humanities">인문</a>
        </li>
    </ul>
</nav>

    <main class="main-content">
        <div class="breadcrumb">
            <a href="#">eBook</a>
            <a href="#">인문</a>
        </div>
        <div class="filter-bar">
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/product/CategorySearch.do" method="get">
                    <input type="text" name="query" placeholder="분야내 검색" value="<%= request.getParameter("query") %>">
                    <input type="hidden" name="categoryName" value="<%= request.getParameter("categoryName") %>">
                    <input type="hidden" name="order" value="<%= order %>">
                    <button type="submit">
                        <img src="${pageContext.request.contextPath}/images/찾기.png" alt="검색" style="width: 15px; height: 15px;">
                    </button>
                </form>
            </div>
			           <div class="select-container">
			    <select id="orderSelect" onchange="changeOrder()">
			        <option value="newest" <%= "newest".equals(order) ? "selected" : "" %>>최신순</option>
			        <option value="lowestPrice" <%= "lowestPrice".equals(order) ? "selected" : "" %>>낮은 가격순</option>
			        <option value="highestPrice" <%= "highestPrice".equals(order) ? "selected" : "" %>>높은 가격순</option>
			    </select>
			    <div class="select-container">
			        <select id="pageSize" name="pageSize" onchange="changePageSize()">
			            <option value="10" <%= pageSize == 10 ? "selected" : "" %>>10개씩 보기</option>
			            <option value="20" <%= pageSize == 20 ? "selected" : "" %>>20개씩 보기</option>
			        </select>
			    </div>
			</div>
			<script>
			function changeOrder() {
		        const order = document.getElementById('orderSelect').value;
		        const url = new URL(window.location.href);
		        url.searchParams.set('sortOrder', order);
		        url.searchParams.set('pageNum', 1); // 정렬 변경 시 첫 페이지로 이동
		        window.location.href = url.toString();
		    }
			
			    function changePageSize() {
			        const pageSize = document.getElementById('pageSize').value;
			        const url = new URL(window.location.href);
			        url.searchParams.set('pageSize', pageSize);
			        url.searchParams.set('pageNum', 1); // 페이지 크기 변경 시 첫 페이지로 이동
			        window.location.href = url.toString();
			    }
			</script>
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
                            <form action="${pageContext.request.contextPath}/cart/Cart.do" method="post">
                                <input type="hidden" name="isbn" value="<%= product.getIsbn() %>">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit">장바구니에 추가</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="book-images">
                    <p>해당 카테고리에 상품이 없습니다.</p>
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
        <div class="social-icons">
            <a href="#"><img src="images/facebook.png" alt="Facebook"></a>
            <a href="#"><img src="images/twitter.png" alt="Twitter"></a>
            <a href="#"><img src="images/instagram.png" alt="Instagram"></a>
            <a href="#"><img src="images/blog.png" alt="Blog"></a>
        </div>
    </footer>
</body>
</html>
