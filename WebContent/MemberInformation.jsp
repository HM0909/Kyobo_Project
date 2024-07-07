<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%
	// 세션 객체 가져오기  & user 객체 유무로 로그인 상태 확인
	HttpSession session2 = request.getSession(false);
	MemberDTO user = (session2 != null) ? (MemberDTO) session.getAttribute("user") : null;
	boolean loggedIn = (user != null);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook - Member Information</title>
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
		    max-width: 800px; /* 원하는 너비로 설정 */
		    margin: 0 auto; 
        }
        .content-section h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .content-section form {
            display: flex;
            flex-direction: column;
        }
        .content-section label {
            margin-bottom: 5px;
        }
        .content-section input[type="text"],
        .content-section input[type="password"],
        .content-section input[type="email"],
        .content-section input[type="date"],
        .content-section input[type="number"] {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            outline: none;
        }
        .content-section .buttons {
            display: flex;
            justify-content: space-between;
        }
        .content-section .buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .content-section .buttons .save {
            background-color: #007bff;
            color: white;
        }
        .content-section .buttons .cancel {
            background-color: #ddd;
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
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Kyobo eBook" onclick="window.location.href='${pageContext.request.contextPath}/index.do'">
        </div>
        <div class="search-bar">
            <input type="text" placeholder="통합검색">
            <button>
                <img src="${pageContext.request.contextPath}/images/찾기.png" alt="Search" style="width: 40px; height: 40px;">
            </button>
        </div>
        <div class="user-info">
            
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

    <main class="main">
        <div class="sidebar">
            <h2>회원 메뉴</h2>
            <ul>
                <li><a>내 정보 수정</a></li>
                <li><a href="${pageContext.request.contextPath}/cart/Cart.do">장바구니 정보</a></li>
                <li><a href="${pageContext.request.contextPath}/member/MemberDelete.do">회원 탈퇴</a></li>
            </ul>
        </div>

        <div class="content-section">
            <h2>회원 정보</h2>
            <% if (loggedIn) { %>
            <div class="info-box">
                <form class="member-form" action="${pageContext.request.contextPath}/member/MemberInfo.do" method="post">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" value="<%= user.getUser_id() %>">
                    
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="user_pw" value="<%= user.getUser_pw() %>">

                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" readonly>
                    
                    <label for="birthdate">생년월일</label>
                    <input type="date" id="birthdate" name="birthdate" value="<%= user.getAge() %>">
                    
                    <div class="buttons">
                        <button type="submit" class="save">수정</button>
                        <button type="button" class="cancel" onclick="window.location.href='MemberInfo.do'">취소</button>
                    </div>
                </form>
            </div>
            <% } else { %>
            <p>로그인이 필요합니다. <a href="${pageContext.request.contextPath}/login/Login.do">로그인</a></p>
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
            <p>대표이사: 안병현, 김상훈 | 서울특별시 종로구 종로 1 | 사업자등록번호: 102-81-11670</p>
            <p>대표전화: 1544-1900(발신자 부담전화) | FAX: 0502-987-5711(지역번호 공통) | 서울특별시 통신판매업신고번호: 제 653호</p>
            <p>© KYOOBO BOOK CENTRE</p>
        </div>
    </footer>
</body>
</html>