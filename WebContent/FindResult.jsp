<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교보문고 결과</title>
    <style>
        body {
            font-family: 'Roboto', 'Noto Sans KR', 'PingFang SC', sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .success_container {
            width: 100%;
            max-width: 500px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header img {
            width: 250px;
            margin-bottom: 30px;
        }
        .header h1 {
            font-size: 32px; /* 텍스트 크기 증가 */
            font-weight: bold;
            margin: 10px 0;
            color: #093e76; /* 로고와 동일한 배경색 */
        }
        .message {
            font-size: 24px;
            font-weight: bold;
            margin: 20px 0;
            color: #052342;
        }
        .details {
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
        }
        .success_button {
            width: 100%;
            padding: 15px;
            background-color: #093e76;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="success_container">
        <div class="header">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="교보문고 로고">
            <h1>결과</h1>
        </div>
        <div class="message">
            ${message}
        </div>
        <button class="success_button" onclick="window.location.href='${pageContext.request.contextPath}/Index.jsp'">홈으로 돌아가기</button>
    </div>
</body>
</html>
