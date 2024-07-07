<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="notice.NoticeDTO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0 auto;
            padding: 0;
            width: 1440px;
            height: 848px;
            overflow: hidden;
            justify-content: center;
            align-items: center;
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
            margin-left: -30px;
            border: 1px solid #ddd;
            border-radius: 25px;
            padding: 5px 10px;
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
        }
        .user-info .login-signup a:hover {
            color: #007bff;
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
        .main {
            display: flex;
            padding: 20px;
        }
        .sidebar {
            width: 200px;
            margin-right: 20px;
        }
        .sidebar h2 {
            font-size: 20px;
            margin-bottom: 10px;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            margin-bottom: 10px;
        }
        .sidebar ul li a {
            text-decoration: none;
            color: #333;
        }
        .sidebar ul li a:hover {
            color: #007bff;
        }
        .content-section {
            flex: 1;
        }
        .content-section h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        .notice-section {
            margin-top: 20px;
        }
        .notice-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .notice-header h2 {
            font-size: 24px;
        }
        .notice-list {
            list-style: none;
            padding: 0;
        }
        .notice-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .notice-item a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .notice-item a:hover {
            color: #007bff;
        }
        .notice-item .date {
            color: #999;
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
    </style>
</head>
<body>

    <header class="header">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Kyobo eBook">
        </div>
        <div class="search-bar">
            <input type="text" placeholder="통합검색">
            <button>
                <img src="${pageContext.request.contextPath}/images/찾기.png" alt="Search" style="width: 40px; height: 40px;">
            </button>
        </div>
        <div class="user-info">
            <a href="#"><img src="${pageContext.request.contextPath}/images/장바구니.png" alt="Cart"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/images/회원 아이콘.png" alt="User"></a>
            <div class="login-signup">
                <a href="#">회원가입</a>
                <a href="#">로그인</a>
                <a href="#">공지사항</a>
            </div>
        </div>
    </header>
    
    <nav class="breadcrumb">
        <a href="#">eBook</a>
        <a href="#">고객센터</a>
    </nav>

    <main class="main">
        <div class="sidebar">
            <h2>고객센터</h2>
            <ul>
                <li><a href="#">eBook 공지사항</a></li>
                <li><a href="#">회원</a></li>
                <li><a href="#">도서 / 상품정보</a></li>
            </ul>
        </div>

        <div class="content-section">
            <h1>eBook 공지사항</h1>
 
            <div class="notice-section">
                <div class="notice-header">
                    <h2>공지사항</h2>
                </div>
                <ul class="notice-list">
                    <%
                        List<NoticeDTO> noticeList = (List<NoticeDTO>) request.getAttribute("noticeList");
                        if (noticeList != null) {
                            for (NoticeDTO notice : noticeList) {
                    %>
                    <li class="notice-item">
                        <a href="notice.do?action=view&num=<%= notice.getNum() %>"><%= notice.getTitle() %></a>
                        <span class="date"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getRegidate()) %></span>
                    </li>
                    <%
                            }
                        } else {
                    %>
                    <li class="notice-item">
                        <p>등록된 공지사항이 없습니다.</p>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
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

</body>
</html>
