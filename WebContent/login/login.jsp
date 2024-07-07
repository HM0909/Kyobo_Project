<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" href="../css/login.css" type="text/css" />
<script>
	function login() {
		var form = document.getElementById("loginForm");

		if (form.userId.value == ""){
			alert("아이디를 입력 하세요");
			form.userId.focus();
			return false;
		}
		
		if (form.password.value == ""){
			alert("비밀번호를 입력 하세요");
			form.password.focus();
			return false;
		}
		
		form.submit();
	}	
</script>
</head>
<body>
	<div class="wrapper" id="wrap" style="height: auto; min-height: 100%;">
		<div class="content-wrapper" style="min-height: 1031px;">
            <!-- Main content -->
            <form id="loginForm" name="loginForm" method="post" action="./loginProcess.jsp" novalidate="novalidate">
                <div id="loginWrap">
                    <div class="logo">
                        <img src="/dist/images/logo.png" alt="">
                        <strong>로고이미지</strong>
                        <span></span>
                        <br><br><br><br><br>
                        <p style="font-size:11px; margin: 45px 45px 0px 45px;" align="justify">
                            ▶  접속(로그인) 실패 시 사용중인 브라우저 쿠키 및 캐시 삭제를 권장합니다.
                        </p><p style="font-size:10px; margin: 0px 45px 0px 45px;" align="justify">
                            (ex. Chrome PC 브라우저 실행&gt; 설정&gt; 개인 정보 보호 및 보안&gt; 인터넷 사용 기록 삭제 &gt; 쿠키 및 기타 사이트 데이터(체크)&gt; 인터넷 사용 기록 삭제&gt;
                            재접속)</p>
                        <p style="font-size:11px; margin: 15px 45px 0px 45px;" align="justify">
                            ▶ 비밀번호 오류 횟수(5회) 초과 시, ‘비밀번호 찾기’ 이용하여 ‘비밀번호 
                        </p><p style="font-size:11px; margin: 0px 45px 0px 45px;" align="justify">
                            재설정’ 후 로그인 가능합니다.
                        </p><p style="font-size:11px; margin: 0px 45px 0px 45px;" align="justify">
                            ▶ 계정 관련 문의 : dsteam@kyobobook.co.kr</p>
                    </div>
                    <div class="login">
                        <strong>&nbsp;</strong>

                        <input type="text" name="userId" id="userId" placeholder="아이디" class="form-control" required="required">
                        <input type="password" name="password" id="password" placeholder="비밀번호" class="form-control" required="required">
                        <input type="hidden" name="loginDvsn" id="loginDvsn">
                        <div class="idpw">
                        <span>
                            <input type="checkBox" name="saveId" id="saveId">
                            <label for="saveId" style="font-weight:400">아이디 저장</label>
                        </span>
                            <a class="schBtn-id" id="openFindIdPop">아이디 찾기</a>
                            <a class="schBtn-pw" id="openFindPwPop">비밀번호 찾기</a>
                    </div>
                    <div class="btn">
                        <button type="button" id="loginBtn" onclick="login();">로그인</button>
                        <a href="../member/sign.jsp" id="goMembersJoin">관리자 가입</a>
                    </div>
                </div>
               </div>
            </form>
        </div>    
    </div>     
</body>
</html>