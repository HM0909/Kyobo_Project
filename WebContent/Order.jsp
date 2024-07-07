<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="cart.CartDTO" %>
<%@ page import="product.ProductDTO" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="java.util.List" %>
<%	
    // 세션 객체 가져오기 & user 객체 유무로 로그인 상태 확인
    HttpSession session2 = request.getSession(false);
    MemberDTO user = (session2 != null) ? (MemberDTO) session2.getAttribute("user") : null;
    boolean loggedIn = (user != null);

    // 장바구니 항목 가져오기
    ProductDAO productDAO = new ProductDAO();
    List<CartDTO> cartItems = (List<CartDTO>) request.getAttribute("cartItems");
    
    int maxItemsToShow = 5;
    int itemCount = 0;
    double totalAmount = 0;

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kyobo eBook - Order</title>
    <style>
        /* 스타일 정의 */
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
            justify-content: space-between;
            padding: 20px;
            background-color: #fff;
            margin: 20px;
            border-radius: 10px;
        }
        .cart-container {
            flex: 3;
            margin-right: 20px;
            height: 60vh;
            flex-basis: 60%;
            overflow-y: auto; /* Enable vertical scrolling */
            padding-right: 10px;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: stretch; /* 높이 맞추기 */
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .item-select {
            flex: 0 0 5%;
            display: flex;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #ddd;
            margin-left: -10px;
        }
        .item-image {
            flex: 0 0 15%;
            display: flex;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #ddd;
        }
        .item-image img {
            width: 80px;
            height: auto;
        }
        .item-details {
            flex: 0 0 35%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 0 20px;
            border-right: 1px solid #ddd;
        }
        .item-title {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .item-price {
            color: #007bff;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .item-coupon {
            background-color: #eee;
            border: none;
            padding: 2px 5px;
            cursor: pointer;
            border-radius: 5px;
            width: 100px;
        }
        .item-quantity {
            flex: 0 0 10%;
            display: flex;
            justify-content: center;
            align-items: center;
            border-right: 1px solid #ddd;
        }
        .item-quantity input {
            width: 50px;
            text-align: center;
        }
        .item-total {
            flex: 0 0 20%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            border-right: 1px solid #ddd;
        }
        .item-delete {
            flex: 0 0 10%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .item-delete button {
            background-color: #ff4d4d;
            border: none;
            color: white;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .summary-container {
            flex: 1;
        }
        .summary {
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            width: 300px;
            height: 400px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .order-button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            text-align: center;
        }
        .order-button:hover {
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
        .payment-section {
            margin-top: 0px;
            padding: 40px;
            width: auto; /* 필요에 따라 크기 조정 */
        }
        .payment-section h3 {
            margin-bottom: 10px;
        }
        .payment-option {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
        }
        .payment-option label {
            display: block;
            margin-bottom: 5px;
        }
        .payment-option input[type="radio"] {
            margin-right: 10px;
        }
        .payment-option select {
            width: 100%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Kyobo eBook" onclick="window.location.href='${pageContext.request.contextPath}/Index.jsp'">
        </div>
        <div class="search-bar">
            <input type="text" placeholder="통합검색">
            <button>
                <img src="${pageContext.request.contextPath}/images/찾기.png" alt="Search">
            </button>
        </div>
        <div class="user-info">
            <div class="login-signup">
                <% if (loggedIn) { %>
                    <span>어서오세요 <%= user.getUser_id() %>님</span>
                    <a href="login/Logout.do">로그아웃</a>
                <% } else { %>
                    <a href="member/Member.do">회원가입</a>
                    <a href="login/Login.do">로그인</a>
                    <a href="#">공지사항</a>
                <% } %>
            </div>
        </div>
    </header>
    
<main class="main">
    <div class="cart-container">
        <h2>결제 페이지</h2>
        <% if (cartItems != null && !cartItems.isEmpty()) { 
            for (CartDTO item : cartItems) { 
                if (itemCount >= maxItemsToShow) break;
                ProductDTO product = productDAO.getProductByIsbn(item.getIsbn());
                if (product == null) continue;
                itemCount++;
                totalAmount += product.getPrice() * item.getQuantity();
        %>
            <div class="cart-item">
                <div class="item-select">
                    <input type="checkbox" checked>
                </div>
                <div class="item-image">
                    <img src="${pageContext.request.contextPath}/DBIMG/<%= product.getBookImg() %>" alt="<%= product.getBookTitle() %>">
                </div>
                <div class="item-details">
                    <p class="item-title"><%= product.getBookTitle() %></p>
                    <p class="item-price"><%= product.getPrice() %>원</p>
                    <button class="item-coupon">할인쿠폰</button>
                </div>
                <div class="item-quantity">
                    <input type="number" value="<%= item.getQuantity() %>" min="1" max="99" 
                           data-isbn="<%= product.getIsbn() %>" data-unit-price="<%= product.getPrice() %>"
                           onchange="updatePrice(this, <%= product.getPrice() %>, '<%= item.getCart_id() %>')">
                </div>
                <div class="item-total">
                    <p id="total-price-<%= item.getCart_id() %>"><%= product.getPrice() * item.getQuantity() %>원</p>
                    <p>결제 후 바로 다운로드</p>
                </div>
            </div>
        <% } %>
        <% } else { %>
            <p>장바구니에 담긴 상품이 없습니다.</p>
        <% } %>
    </div>
    <div class="summary-container">
        <div class="summary">
            <form action="<%= request.getContextPath() %>/order/Order.do" method="post">
                <div class="summary-item">
                    <p>상품 금액</p>
                    <p id="total-price"><%= totalAmount %>원</p>
                </div>
                <div class="summary-item">
                    <p>상품 할인</p>
                    <p>0원</p>
                </div>
                <div class="summary-item">
                    <h4>결제 예정 금액</h4>
                    <h4 id="final-price"><%= totalAmount %>원</h4>
                </div>
                <input type="hidden" name="totalAmount" id="hidden-total-amount" value="<%= totalAmount %>">
                <button type="submit" class="order-button">주문하기</button>
            </form>
        </div>
    </div>
</main>

<div class="payment-section">
    <h3>결제 옵션</h3>
    <div class="payment-option">
        <label><input type="radio" name="payment" value="mobile" checked>휴대폰 결제</label>
        <label><input type="radio" name="payment" value="kyobo">교보페이 (0.3% 스마트캐시 적립)</label>
        <label><input type="radio" name="payment" value="other">다른 결제 수단</label>
    </div>

    <h3>할인 및 적립</h3>
    <div class="payment-option">
        <label>할인쿠폰</label>
        <select>
            <option>사용 가능한 쿠폰이 없습니다.</option>
        </select>
    </div>
    <div class="payment-option">
        <label>캐시/포인트/e교환권</label>
        <p>보유 2,040원</p>
    </div>
    <div class="payment-option">
        <label>교보문고 기프트카드</label>
        <p>0장 사용</p>
    </div>
    <div class="payment-option">
        <label>제휴포인트 사용/적립</label>
        <p>GS&POINT / OK캐쉬백 / L.POINT / 문화상품권 / 해피머니 / 기아멤버스 / 대한항공</p>
        <button>사용/적립</button>
    </div>
</div>

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
    var updatedQuantities = {};
    var contextPath = '<%= request.getContextPath() %>';

    function updatePrice(element, pricePerItem, cartId) {
        var quantity = element.value;
        var totalPriceElement = document.getElementById('total-price-' + cartId);

        if (totalPriceElement === null) {
            console.error('Element with ID total-price-' + cartId + ' not found');
            return;
        }

        var totalPrice = pricePerItem * quantity;
        totalPriceElement.innerText = totalPrice.toLocaleString() + '원';

        // 변경된 수량을 임시로 저장
        updatedQuantities[cartId] = quantity;

        // 총 가격 업데이트 (필요한 경우)
        updateTotalPrice();
    }

    function updateTotalPrice() {
        var total = 0;
        var prices = document.querySelectorAll('.item-total p:first-child');
        prices.forEach(function(priceElement) {
            var priceText = priceElement.innerText;
            var price = parseInt(priceText.replace('원', '').replace(/,/g, ''));
            total += price;
        });
        document.getElementById('total-price').innerText = total + '원';
        document.getElementById('final-price').innerText = total + '원';
        document.getElementById('hidden-total-amount').value = total;
    }

    // 페이지 로드 시 총 가격을 계산합니다.
    window.onload = function() {
        updateTotalPrice();
    };

</script>
    
</body>
</html>
 --%>