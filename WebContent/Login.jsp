<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교보문고 로그인</title>
    <style>
        body {
            font-family: 'Roboto', 'Noto Sans KR', 'PingFang SC', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff; /* 배경을 하얀색으로 변경 */
        }
        .login_form_wrap {
            background-color: #ffffff;
            padding: 30px 30px; /* Padding 조정 */
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 340px; /* 너비 조정 */
        }
        .login_form_wrap img {
            width: 350px;
            margin-bottom: 40px;
        }
        .login_form_wrap input[type="text"],
        .login_form_wrap input[type="password"] {
            width: 85%; /* 너비 조정 */
            padding: 15px;
            margin: 5px 0; /* 간격 조정 */
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .login_form_wrap .login_button {
            width: 100%;
            padding: 15px;
            margin: 20px 0;
            background-color: #ccc;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold; /* 폰트 굵게 */
            color: #ffffff; /* 폰트 색상 하얀색 */
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .login_form_wrap .login_button.active {
            background-color: #007bff;
            color: #fff;
        }
        .login_options {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px 0;
        }
        .login_options a {
            margin: 0 10px;
            font-size: 14px;
            color: #007bff;
            cursor: pointer;
            text-decoration: none; /* 링크 밑줄 제거 */
        }
        .login_form_wrap .social_login {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }
        .login_form_wrap .social_login img {
            width: 40px;
            height: 40px;
            margin: 0 10px;
            cursor: pointer;
        }
        .login_form_wrap .additional_options {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .login_form_wrap .additional_options button {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            background-color: #fff;
            border: 1px solid #007bff;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold; /* 폰트 굵게 */
            color: #007bff; /* 폰트 색상 파란색 */
            cursor: pointer;
        }
        .login_form_wrap .additional_options button:nth-child(2) {
            border: 1px solid #ddd;
        }
    </style>
    <script>
        function checkInput() {
            const userId = document.getElementById('userId').value;
            const userPassword = document.getElementById('userPassword').value;
            const loginButton = document.getElementById('loginButton');
            if (userId && userPassword) {
                loginButton.classList.add('active');
            } else {
                loginButton.classList.remove('active');
            }
        }

        function handleRememberMe() {
            const userId = document.getElementById('userId').value;
            const rememberMe = document.getElementById('rememberMe').checked;

            if (rememberMe) {
                localStorage.setItem('rememberMe', 'true');
                localStorage.setItem('userId', userId);
            } else {
                localStorage.removeItem('rememberMe');
                localStorage.removeItem('userId');
            }
        }

        window.onload = function() {
            const rememberMe = localStorage.getItem('rememberMe') === 'true';
            const userId = localStorage.getItem('userId');

            if (rememberMe && userId) {
                document.getElementById('userId').value = userId;
                document.getElementById('rememberMe').checked = true;
                checkInput();
            }
        }
    </script>
</head>
<body>
    <div class="login_form_wrap">
        <form action="${pageContext.request.contextPath}/login/Login.do" method="post" name="LoginFrm" onsubmit="handleRememberMe();">
            <img src="${pageContext.request.contextPath}/images/logo2.png" alt="교보문고 로고">
            <input id="userId" name="user_id" type="text" placeholder="아이디를 입력해 주세요." oninput="checkInput()">
            <input id="userPassword" name="user_pw" type="password" placeholder="비밀번호를 입력해 주세요." oninput="checkInput()">
            <button id="loginButton" class="login_button">로그인</button>
            <div class="login_options">
                <a>
                    <input type="checkbox" id="rememberMe" onclick="handleRememberMe()">
                    <label for="rememberMe">아이디 저장</label>
                </a>
                <a href="${pageContext.request.contextPath}/member/IdFind.do">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/member/PwFind.do">비밀번호 찾기</a>
            </div>
        </form>
        <div class="additional_options">
            <button onclick="window.location.href='${pageContext.request.contextPath}/member/Member.do'">회원가입</button>
        </div>
        <div class="additional_options">
            <button onclick="window.location.href='${pageContext.request.contextPath}/main.jsp'">관리자 페이지</button>
        </div>
    </div>
</body>
</html>
