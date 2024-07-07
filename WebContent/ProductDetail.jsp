<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.ProductDTO" %>
<%
    ProductDTO product = (ProductDTO) request.getAttribute("product");
    if (product == null) {
        throw new NullPointerException("Product not found");
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook - Detail</title>
    <style>
        /* 기존 스타일 유지 */
        a:link { 
    		text-decoration:none;
    		font-size: 20px;
    	}
        body {
            font-family: Arial, sans-serif;
            margin: 0 auto;
            padding: 0;
            width: 1440px;
            overflow: visible;
            justify-content: center;
            align-items: center;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: left;
            padding: 10px 20px;
            background-color: #fff;
            border-bottom: none;
            position: relative;
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
        .logo img {
            width: 174px;
            height: 92px;
        }
        .search-bar {
            flex: 1;
            display: flex;
            align-items: center;
            margin-left: 0px;
            border: 1px solid #ddd;
            border-radius: 25px;
            padding: 3px 20px;
            height: 40px;
            max-width: 500px;
            margin-top: 30px;
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
            margin-right: 10px;
            margin-top: 30px;
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
            margin-top: 40px;
        }
        .user-info .login-signup a:hover {
            color: #007bff;
        }
        .breadcrumb {
            padding: 10px 20px;
            background-color: #f8f8f8;
            border-bottom: 1px solid #ddd;
            margin-top: 40px;
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
        .content {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 20px;
            width: 1200px;
            height: auto;
        }
        .content-left,
        .content-right {
            width: 380px;
            padding-left: 80px;
        }
        .content-left .book-info,
        .content-right .ebook-info {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        .content-left .book-info h1 {
            font-size: 36px;
            margin: 0;
            text-align: center;
            width: 100%;
        }
        .content-left h1 {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .content-left .publisher {
            margin-bottom: 60px !important;
        }
        .content-left .author,
        .content-left .publication-date,
        .content-left .price,
        .content-left .publisher {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .content-left .file-information,
        .content-left .isbn,
        .content-left .age-information {
            font-size: 14px;
            margin-bottom: 5px;
        }
        .content-center {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 381px;
            height: 591px;
            text-align: center;
        }
        .content-center img {
            width: 381px;
            height: 591px;
            margin-top: 20px;
        }
        .like-button {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }
        .like-button img {
            width: 30px;
            height: 30px;
            margin-right: 10px;
        }
        .buttons {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .buttons button {
            padding: 15px 30px;
            margin-right: 10px;
            font-size: 18px;
            border: 1px solid #ddd;
            background-color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }
        .buttons button:hover {
            background-color: #f0f0f0;
        }
        .additional-content {
            padding: 0px;
            border-top: 1px solid #ddd;
            background-color: #f8f8f8;
        }
        .additional-content .tabs {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            border-bottom: 2px solid #ddd;
            margin-top: 0;
            margin-bottom: 20px;
        }
        .tabs .tab {
            padding: 10px 20px;
            font-size: 18px;
            text-align: center;
            cursor: pointer;
            color: #333;
            border-bottom: 3px solid transparent;
            transition: border-bottom 0.3s ease;
        }
        .tabs .tab:hover,
        .tabs .tab.active {
            border-bottom: 3px solid #007bff;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .content-left {
            width: 380px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
            font-family: 'Roboto', 'Noto Sans KR', 'PingFang SC', sans-serif;
        }
        .content-left p {
            margin-bottom: 5px;
            font-size: 14px;
        }
        .book-info {
            padding: 16px 0;
            border-top: 1px solid #ddd;
            margin: 24px 0 0 0;
        }
        .book-info p {
            margin: 5px 0;
            font-size: 14px;
        }
        .content-left .file-information {
            border-top: 1px solid #ddd;
            padding-top: 10px;
            margin-top: 10px;
        }
        .like-button img {
            width: 150px; 
            height: 100px; 
        }
        .price-info {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        .price-info .price {
            color: #333;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .price-info .discount-price {
            color: #e60012;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .price-info .coupon-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .price-info .coupon-button:hover {
            background-color: #0056b3;
        }
        .info-section {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        .info-section1 {
            color: #474C98;
            font-family: 'Roboto', 'Noto Sans KR', 'PingFang SC', sans-serif;
            font-size: 15x;
            padding: 15px 40px;
            background-color: rgba(80, 85, 177, 0.07);
            border-radius: 10px;
            border: 1px solid rgba(80, 85, 177, 0.3);
            line-height: 20px;
            margin-top: 30px;
            display: block;
        }
        .info-section h3 {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .info-section p {
            font-size: 14px;
            margin-bottom: 10px;
        }
        .info-section a {
            color: #007bff;
            text-decoration: none;
        }
        .info-section a:hover {
            text-decoration: underline;
        }
        .fixed-bar {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: white;
            border-top: 1px solid #ddd;
            padding: 10px 20px;
            box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
        }
        .price-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            margin-top: 20px;
        }
        .price-info .price {
            font-size: 24px;
            font-weight: bold;
            color: #000;
        }
        .buttons {
            display: flex;
            align-items: center;
        }
        .buttons button,
        .buttons .wishlist-button {
            padding: 10px 20px;
            margin-right: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            background-color: #fff;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .buttons .wishlist-button {
            border: none;
            background: none;
            font-size: 24px;
            color: #000;
        }
        .buttons .wishlist-button:hover {
            color: #007bff;
        }
        .buttons button:hover {
            background-color: #f0f0f0;
        }
        .buttons .buy-button {
            background-color: #007bff;
            color: #fff;
        }
        .buttons .buy-button:hover {
            background-color: #0056b3;
        }
        .buttons .gift-button {
            background-color: #fff;
            color: #000;
            border: 1px solid #ddd;
            margin-right: 10px;
        }
        .buttons .gift-button:hover {
            background-color: #f0f0f0;
        }
        .content-title {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            margin-top: 20px;
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
            <a href="#"><img src="${pageContext.request.contextPath}/images/회원 아이콘.png" alt="User"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/images/장바구니.png" alt="Cart"></a>
            <div class="login-signup">
                <a href="#">회원가입</a>
                <a href="#">로그인</a>
                <a href="#">공지사항</a>
            </div>
        </div>
    </header>
    <nav class="breadcrumb">
        <a href="#">eBook</a>
        <a href="#">상세보기</a>
    </nav>
    <div>
        <h1 class="content-title"><%= product.getBookTitle() %></h1>
    </div>
    <main class="content">
        <div class="content-left">
            <p class="author"><%= product.getAuthor() %> 지음</p>
            <p class="publication-date"><%= product.getPubDate() %> 출간</p>
            <p class="price"><%= product.getPrice() %>원</p>
            <p class="publisher"><%= product.getPublish() %></p>         
            <p class="file-information">* 파일정보: <%= product.getConInfo() %></p>
            <p class="isbn">* ISBN: <%= product.getIsbn() %></p>
            <p class="age-information">* 연령정보: <%= product.getAge() %></p>
        </div>
        <div class="content-center">
             <img src="${pageContext.request.contextPath}/Uploads/<%= product.getBookCover() %>" alt="<%= product.getBookTitle() %>">
        </div>
        <div class="content-right">
            <div class="price-info">
                <p class="price">정가: <%= product.getPrice() %>원</p>
            </div>
            <div class="info-section1">
                이 상품은 배송되지 않는<br>디지털 상품이며<br>
                교보eBook 웹뷰어에서<br>바로 이용가능합니다.
            </div>
            <div class="info-section2">
                <h4>이 상품의 이벤트</h4>
            </div>
            <div class="info-section3">
                <h4>카드&결제 혜택</h4>
            </div>
        </div>
    </main>
    <section class="additional-content">
        <div class="tabs">
            <div class="tab-text"><h2>작품소개</h2></div>
            <div class="tab active" onclick="showTabContent(event, 'introduction')">책소개</div>
            <div class="tab" onclick="showTabContent(event, 'summary')">목차</div>
        </div>
        <div id="introduction" class="tab-content active">
            <div class="additional-details">
                <p class="book-description"><%= product.getConInfo() %></p>
            </div>
        </div>
        <div id="summary" class="tab-content">
            <div class="additional-details">
                <h2 class="section-title">책소개</h2>
                <p class="book-description"><%= product.getConTable() %></p>
            </div>
        </div>
    </section>
    <div class="price-info">
        <span class="price"><%= product.getPrice() %> 원</span>
        <div class="buttons">
            <button class="wishlist-button">♡</button>
            <button class="gift-button">선물하기</button>
            <button class="buy-button" onclick="addToCart('<%= product.getIsbn() %>')">장바구니</button>
            <button class="buy-button">구매하기</button>
        </div>
    </div>
    <script>
        function showTabContent(event, tabId) {
            var tabContents = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove('active');
            }
            var tabs = document.getElementsByClassName('tab');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            document.getElementById(tabId).classList.add('active');
            event.currentTarget.classList.add('active');
        }
        window.addEventListener('scroll', function() {
            var fixedBar = document.querySelector('.fixed-bar');
            if (window.scrollY > 300) {
                fixedBar.style.display = 'flex';
            } else {
                fixedBar.style.display = 'none';
            }
        });
        function addToCart(isbn) {
            var contextPath = '<%= request.getContextPath() %>';
            fetch(`${contextPath}/cart/Cart.do`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `isbn=${isbn}&quantity=1`
            })
            .then(response => {
                if (response.ok) {
                    alert('장바구니에 추가되었습니다.');
                } else if (response.status === 401) {
                    alert('로그인이 필요합니다.');
                    window.location.href = `${contextPath}/login/Login.do`;
                } else {
                    alert('장바구니에 추가 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('장바구니에 추가 중 오류가 발생했습니다.');
            });
        }
    </script>

</body>
</html>
