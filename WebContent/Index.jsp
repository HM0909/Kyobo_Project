<%@page import="banner.BannerDTO"%>
<%@page import="product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="banner.BannerDTO" %>

<%
    // 세션 객체 가져오기 & user 객체 유무로 로그인 상태 확인
    HttpSession session2 = request.getSession(false);
    MemberDTO user = (session2 != null) ? (MemberDTO) session2.getAttribute("user") : null;
    boolean loggedIn = (user != null);

    // 최신 신간 도서 목록 가져오기
    List<ProductDTO> latestBooks = (List<ProductDTO>) request.getAttribute("latestBooks");

    // 배너 목록 가져오기
    List<BannerDTO> banners = (List<BannerDTO>) request.getAttribute("banners");
    
 	// 이름 순으로 정렬된 제품 목록 가져오기
    List<ProductDTO> productsByName = (List<ProductDTO>) request.getAttribute("productsByName");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook</title>
    <style>
    	a:link { text-decoration:none;}
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
            height: 40px;
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
        .user-info .login-signup {
            display: flex;
            align-items: center;
            margin-left: 20px;
            margin-top: 30px;
        }
        .user-info .login-signup a {
            text-decoration: none;
            color: black;
            font-size: 18px;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            margin-left: 15px;
        }
        .banner {
            display: flex;
            overflow: hidden;
            margin-bottom: 20px;
            position: relative;
            width: 100%;
        }
        .banner-inner {
            display: flex;
            transition: transform 0.5s ease-in-out;
            width: 100%;
        }
        .banner-item {
            min-width: 100%;
            box-sizing: border-box;
            position: relative;
            text-align: center;
            color: white;
        }
        .banner-item img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .banner-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .banner-content h2 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }
        .banner-content p {
            font-size: 16px;
        }
        .banner-buttons {
            position: absolute;
            top: 50%;
            width: 100%;
            display: flex;
            justify-content: space-between;
            transform: translateY(-50%);
        }
        .banner-buttons button {
            background-color: rgba(0, 0, 0, 0.5);
            border: none;
            color: white;
            padding: 10px;
            cursor: pointer;
        }
        .banner-buttons button:hover {
            background-color: rgba(0, 0, 0, 0.8);
        }
        .ebooks {
            display: flex;
            flex-wrap: wrap;
        }
        .ebook {
            flex: 0 0 20%;
            margin: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: center;
        }
        .ebook img {
            max-width: 100%;
            height: auto;
        }
        .ebook p {
            margin: 5px 0;
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

    <main style="padding: 20px;">
        <div class="banner">
            <% if (banners != null && !banners.isEmpty()) { %>
                <% for (int i = 0; i < banners.size(); i++) { 
                    BannerDTO banner = banners.get(i); %>
                    <div class="banner-item" style="<%= i == 0 ? "display: block;" : "display: none;" %>">
                        <img src="<%= request.getContextPath() %>/<%= banner.getImagePath() %>" alt="배너 이미지">
                        <div class="banner-content">
                            <h2><%= banner.getTitle() %></h2>
                            <p><%= banner.getDescription() %></p>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <p>배너가 없습니다.</p>
            <% } %>
            <div class="banner-buttons">
                <button id="prevBtn">〈</button>
                <button id="nextBtn">〉</button>
            </div>
        </div>

        <h2>잠시만 주목</h2>
        <h1 style="margin-bottom: 10px;">오늘의 eBook</h1>
         <div class="ebooks">
            <% if (productsByName != null && !productsByName.isEmpty()) { %>
                <% for (ProductDTO book : productsByName) { %>
                    <div class="ebook">
                        <a href="${pageContext.request.contextPath}/product/ProductDetail.do?isbn=<%= book.getIsbn() %>">
                            <img src="${pageContext.request.contextPath}/Uploads/<%= book.getBookCover() %>" alt="<%= book.getBookTitle() %>">
                        </a>
                        <p><strong><%= book.getBookTitle() %></strong></p>
                        <p><%= book.getAuthor() %></p>
                    </div>
                <% } %>
            <% } else { %>
                <p>이름 순으로 정렬된 도서가 없습니다.</p>
            <% } %>
        </div>
        
        <h2>신간은 못참지</h2>
        <h1 style="margin-bottom: 10px;">오늘의 신간</h1>
        <div class="ebooks">
            <% if (latestBooks != null && !latestBooks.isEmpty()) { %>
                <% for (ProductDTO book : latestBooks) { %>
                    <div class="ebook">
                        <a href="${pageContext.request.contextPath}/product/ProductDetail.do?isbn=<%= book.getIsbn() %>">
                            <img src="${pageContext.request.contextPath}/Uploads/<%= book.getBookCover() %>" alt="<%= book.getBookTitle() %>">
                        </a>
                        <p><strong><%= book.getBookTitle() %></strong></p>
                        <p><%= book.getAuthor() %></p>
                    </div>
                <% } %>
            <% } else { %>
                <p>신간 도서가 없습니다.</p>
            <% } %>
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
            <p>대표이사: 안병현, 김상훈 | 서울특별시 종로구 종로 1 |사업자등록번호: 102-81-11670</p>
            <p>대표전화: 1544-1900(발신자 부담전화) | FAX: 0502-987-5711(지역번호 공통) | 서울특별시 통신판매업신고번호: 제 653호</p>
            <p>© KYOOBO BOOK CENTRE</p> 
        </div>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const bannerItems = document.querySelectorAll(".banner-item");
            let currentIndex = 0;

            function showBanner(index) {
                bannerItems.forEach((item, i) => {
                    item.style.display = (i === index) ? "block" : "none";
                });
            }

            document.getElementById("prevBtn").addEventListener("click", function() {
                currentIndex = (currentIndex > 0) ? currentIndex - 1 : bannerItems.length - 1;
                showBanner(currentIndex);
            });

            document.getElementById("nextBtn").addEventListener("click", function() {
                currentIndex = (currentIndex < bannerItems.length - 1) ? currentIndex + 1 : 0;
                showBanner(currentIndex);
            });

            // 초기 배너 표시
            showBanner(currentIndex);
        });
    </script>
</body>
</html>
