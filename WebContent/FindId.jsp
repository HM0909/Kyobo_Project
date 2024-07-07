<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교보문고 아이디 찾기</title>
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
        .Find_form_wrap {
            background-color: #ffffff;
            padding: 30px 30px; /* Padding 조정 */
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 340px; /* 너비 조정 */
        }
        .Find_form_wrap img {
            width: 200px;
            margin-bottom: 20px;
        }
        .Find_form_wrap input[type="text"],
        .Find_form_wrap input[type="email"] {
            width: 85%; /* 너비 조정 */
            padding: 15px;
            margin: 5px 0; /* 간격 조정 */
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .Find_form_wrap .login_button {
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
        .Find_form_wrap .login_button.active {
            background-color: #007bff;
            color: #fff;
        }
    </style>
    <script>
        function checkInput() {
            var userName = document.querySelector('input[name="user_name"]').value;
            var email = document.querySelector('input[name="email"]').value;
            var loginButton = document.getElementById('loginButton');
            if (userName && email) {
                loginButton.classList.add('active');
            } else {
                loginButton.classList.remove('active');
            }
        }
    </script>
</head>
<body>
    <form action="${pageContext.request.contextPath}/member/IdFind.do" method="post" name="FindIdFrm">
        <div class="Find_form_wrap">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="교보문고 로고">
            <input name="user_name" type="text" placeholder="이름을 입력해 주세요." oninput="checkInput()">
            <input name="email" type="email" placeholder="이메일 주소를 입력해 주세요." oninput="checkInput()">
            <button id="loginButton" class="login_button">이메일로 아이디 찾기</button>
        </div>
    </form>
    
</body>
</html>
