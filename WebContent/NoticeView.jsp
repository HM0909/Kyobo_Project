<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f8f8f8;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3;
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
                <%
                    NoticeDTO notice = (NoticeDTO) request.getAttribute("notice");
                    if (notice != null) {
                %>
                <table>
                    <tr>
                        <th>제목</th>
                        <td><%= notice.getTitle() %></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><%= notice.getContent() %></td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(notice.getRegidate()) %></td>
                    </tr>
                </table>
                <a class="button" href="notice.do?action=list">목록으로</a>
                <%
                    } else {
                %>
                <p>공지사항을 불러올 수 없습니다.</p>
                <a class="button" href="notice.do?action=list">목록으로</a>
                <%
                    }
                %>
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
