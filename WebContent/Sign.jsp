<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>교보문고 회원가입</title>
    <script>
		function validateForm(form){
			
			const checkCnt = document.querySelectorAll('.chk:checked').length;
			
			console.log(checkCnt);
			
			if(form.id.value == ""){
				alert("아이디를 입력 하세요");
				form.id.focus();
				return false;
			}
			
			if(form.pwd1.value == ""){
				alert("비밀번호를 입력 하세요");
				form.pwd1.focus();
				return false;
			}
			
			if(form.pwd2.value == ""){
				alert("비밀번호를 입력 하세요");
				form.pwd2.focus();
				return false;
			}
			
			if(form.pwd1.value != form.pwd2.value){
				alert("비밀번호가 불일치 합니다.");
				form.pwd2.focus();
				return false;
			}
			
			if(form.name.value == ""){
				alert("이름을 입력 하세요");
				form.name.focus();
				return false;
			}
			
			if(form.gender.value == ""){
				alert("생년월일을 입력 하세요");
				form.gender.focus();
				return false;
			}
			
			if(form.job.value == ""){
				alert("이메일을 입력 하세요");
				form.job.focus();
				return false;
			}

			
		}
	</script>
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
        .signup_form_container {
            width: 100%;
            max-width: 500px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header img {
            width: 400px;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 32px; /* 텍스트 크기 증가 */
            font-weight: bold;
            margin: 10px 0;
            color: #093e76; /* 가입하기 버튼과 동일한 배경색 */
        }
        .header hr {
            border: none;
            height: 1px;
            background-color: #ddd;
            margin: 20px 0;
        }
        .signup_form_wrap {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 10px;
        }
        .signup_form_wrap h2 {
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .signup_form_wrap input[type="text"],
        .signup_form_wrap input[type="password"],
        .signup_form_wrap input[type="email"],
        .signup_form_wrap select {
            width: calc(100% - 22px); /* input 내부 패딩을 고려한 너비 조정 */
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background-color: #ffffff; /* input 배경색 변경 */
        }

        .signup_form_wrap input[type="checkbox"] {
            margin-right: 10px;
        }
        .signup_form_wrap .terms {
            text-align: left;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .signup_form_wrap .terms a {
            color: #052342;
            text-decoration: none;
        }
        .signup_form_wrap .terms a:hover {
            text-decoration: underline;
        }
        .signup_form_wrap .signup_button {
            width: 100%;
            padding: 15px;
            margin: 20px 0;
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
	<form action="${pageContext.request.contextPath}/member/Member.do" method="post" name="UserFrm" 
	onsubmit="return validateForm(this);">
    <div class="signup_form_container">
        <div class="header">
            <src="${pageContext.request.contextPath}/images/logo2.png" alt="교보문고 로고">
            <h1>정보입력</h1>
            <hr>
        </div>
        <div class="signup_form_wrap">
    
            <input type="text" name="user_id" placeholder="아이디">
            <input type="password" name="user_pw" placeholder="비밀번호">
            <input type="password" name="confirm_user_pw" placeholder="비밀번호 확인">
            <input type="text" name="name" placeholder="이름">
            <input type="date" name="age" placeholder="생년월일">
            <input type="email" name="email" placeholder="이메일">
            <div class="terms">
                <input type="checkbox" required> 개인정보 수집 및 이용안내 (필수)
                <br>
                입력하신 정보는 회원 유무 확인용으로 수집/이용 되며,
                가입 회원에 한해 입력하신 모든 정보가 저장되는 데 동의합니다.
            </div>
            <button class="signup_button">가입하기</button>
        </div>
    </div>
    </form>
</body>
</html>
