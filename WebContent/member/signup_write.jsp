<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="../css/sign.css" type="text/css" />
</head>
<body class="skin-blue sidebar-mini" style="height: auto; min-height: 100%;">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
</script>
	<div class="wrapper" id="wrap" style="height: auto; min-height: 100%;">
		<div class="content-wrapper" style="min-height: 1031px;">
            <div id="wrap">
                <header>
                    <img src="../images/logo.png" alt="">
                    <span>WWW.EBOOK.CO.KR</span>
                </header>
                <section>
                    <ul class="step">
                        <li class="success">약관동의/인증</li>
                        <li class="active">회원정보 입력</li>
                    </ul>
		 	<form name="signditailFrm" method="post" action="writeProcess.jsp">
                    <div class="cont">
                        <div style="width: 100%;display: flex;">
                            <div style="width: 50%;">
                                <h4>기본정보</h4>
                            </div>                                
                        </div>
                    </div>

                    <div>
                        <table class="tbi">
                            <colgroup>
                                <col width="140">
                                <col width="428">
                                <col width="140">
                                <col width="428">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>공급사명(이름)<em class="req">*</em></th>
                                    <td><input type="text" name="name" id="name" maxlength="100" required=""></td>
                                    
                                    <th>사업자번호<em class="req">*</em></th>
                                    <td><input type="text" name="nameno" id="nameno" maxlength="100" required=""></td>
                                </tr>
                                
                        
                                <tr>
                                    <th>아이디<em class="req">*</em></th>
                                    <td colspan="3">
                                        <input type="text" name="id" id="id" maxlength="12" required="">
                                        <button type="button" id="ptrStfIdBtn">중복확인</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>비밀번호<em class="req">*</em></th>
                                    <td colspan="3">
                                        <div class="form_ip_pw full">
                                            <input type="password" class="form_ip" name="password" id="password" maxlength="15" required="" autocomplete="new-password">
                                        </div>
                                        <div>8~15자리의 비밀번호(영문+숫자+특수문자 조합)를 입력하셔야 합니다.</div>
                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <th>전화번호<em class="req">*</em></th>
                                    <td colspan="3">
								        <input type="text" id="phone1" name="phone1" class="tel" maxlength="3" required="" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
								        <em>-</em>
								        <input type="text" id="phone2" name="phone2" class="tel" maxlength="4" required="" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
								        <em>-</em>
								        <input type="text" id="phone3" name="phone3" class="tel" maxlength="4" required="" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                    </td>
                                    
                                    
                                </tr>
                                <tr>
                                    <th>주소<em class="req">*</em></th>
                                    <td colspan="3">
                                        <input type="text" id="sample6_postcode"  name="postcode" placeholder="우편번호">
										<button type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button><br>
										<input type="text" id="sample6_address" name="address" class="addr" placeholder="주소"><br>
										<input type="text" id="sample6_detailAddress" name="detailAddress" class="addr" placeholder="상세주소">
										<input type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목">
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일<em class="req">*</em></th>
                                    <td colspan="3">
                                        <div style="display: inline-flex;">
	                                        <input type="text" title="이메일 계정" value="" id="email"  name="emailAccount" required="">
	                                        <span style="line-height: 40px;">&nbsp;@&nbsp;</span>
	                                        <input type="text" title="이메일 도메인" value="" id="email_domain" name="emailDomain" autocomplete="off">
                                        </div>
                                        <button type="button" id="emailBtn" style="margin-left: 0;">인증요청</button>
                                    </td>
                                </tr>
                
                            </tbody>
                        </table>
                    </div>

                    <div class="cont">
                        <h4>정산정보</h4>
                        <div>
                            <table class="tbi">
                                <colgroup>
                                    <col width="140">
                                    <col width="428">
                                    <col width="140">
                                    <col width="428">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th>은행명<em class="req">*</em></th>
                                    <td><input type="text" name="bank" id="bank" required="">은행</td>
                                    
                                    <th>예금주<em class="req">*</em></th>
                                    <td><input type="text" name="accname" id="accname" required=""></td>
                                </tr>
                                <tr>
                                    <th>계좌번호<em class="req">*</em></th>
                                    <td colspan="3">
                                        <input type="text" name="bankno" id="bankno" placeholder="&quot;-&quot; 없이 입력해주세요." maxlength="20" required="" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
				
                  <div class="btn_wrap">
                   	<button type="button" id="btnApln" class="btn_lg btn_line_primary" onclick="location.href='../login/login.jsp';">취소</button>
                    <button type="submit" id="btnTmpSave" class="btn_lg btn_primary">저장</button>
                 </div>
                </form>
                </section>    
            </div>
        </div>       
    </div>
</body>
</html>
