<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="companymember.MemberDAO"%>
<%@ page import="companymember.MemberDTO"%>
<%
    String id = request.getParameter("id");
    
    MemberDAO dao = new MemberDAO();
    MemberDTO dto = dao.selectView(id);
    
    dao.close();
%>
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

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
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
 			</header>
            <section>
                <form name="signditailFrm" method="post" action="updateProcess.jsp">
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
                                    <td><input type="text" name="name" id="name" value="<%= dto.getName() %>" maxlength="100" required=""></td>
                                    
                                    <th>사업자번호<em class="req">*</em></th>
                                    <td><input type="text" name="nameno" id="nameno" value="<%= dto.getNameno() %>" maxlength="100" required=""></td>
                                </tr>
                                
                                <tr>
                                    <th>아이디<em class="req">*</em></th>
                                    <td colspan="3">
                                        <input type="text" name="id" id="id" maxlength="12" value="<%= dto.getId() %>" required="" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <th>비밀번호<em class="req">*</em></th>
                                    <td colspan="3">
                                        <div class="form_ip_pw full">
                                            <input type="password" class="form_ip" name="password" id="password" maxlength="15" required="" value="<%= dto.getPassword() %>" autocomplete="new-password">
                                        </div>
                                        <div>8~15자리의 비밀번호(영문+숫자+특수문자 조합)를 입력하셔야 합니다.</div>
                                    </td>
                                </tr>   
                                <tr>
                                    <th>전화번호</th>
                                    <td>
                                        <input type="text" id="phone1" name="phone1" class="tel" maxlength="3" value="<%= dto != null && dto.getPhone() != null ? dto.getPhone().length() >= 3 ? dto.getPhone().substring(0, 3) : "" : "" %>" required="" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                        <em>-</em>
                                        <input type="text" id="phone2" name="phone2" class="tel" maxlength="4" value="<%= dto != null && dto.getPhone() != null ? dto.getPhone().length() >= 7 ? dto.getPhone().substring(3, 7) : "" : "" %>" required="" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                        <em>-</em>
                                        <input type="text" id="phone3" name="phone3" class="tel" maxlength="4" value="<%= dto != null && dto.getPhone() != null ? dto.getPhone().length() >= 11 ? dto.getPhone().substring(7, 11) : "" : "" %>" required="" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td>
                                        <input type="text" id="sample6_postcode" name="postcode" value="<%= dto.getAddress() != null ? dto.getAddress().split(",")[0] : "" %>" placeholder="우편번호">
                                        <button type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button><br>
                                        <input type="text" id="sample6_address" name="address" class="addr" value="<%= dto.getAddress() != null ? dto.getAddress().split(",")[1] : "" %>" placeholder="주소"><br>
                                        <input type="text" id="sample6_detailAddress" name="detailAddress" class="addr" value="<%= dto.getAddress() != null ? dto.getAddress().split(",")[2] : "" %>" placeholder="상세주소">
                                        <input type="text" id="sample6_extraAddress" name="extraAddress" value="<%= dto.getAddress() != null ? dto.getAddress().split(",")[3] : "" %>" placeholder="참고항목">
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        <input type="text" title="이메일 계정" value="<%= dto.getEmail() != null ? dto.getEmail().split("@")[0] : "" %>" id="email" name="emailAccount" required="">
                                        <span style="line-height: 40px;">&nbsp;@&nbsp;</span>
                                        <input type="text" title="이메일 도메인" value="<%= dto.getEmail() != null ? dto.getEmail().split("@")[1] : "" %>" id="email_domain" name="emailDomain" autocomplete="off">
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
                                        <td><input type="text" name="bank" id="bank" value="<%= dto.getBank() %>" required="">은행</td>
                                        <th>예금주<em class="req">*</em></th>
                                        <td><input type="text" name="accname" id="accname" value="<%= dto.getAccname() %>" required=""></td>
                                    </tr>
                                    <tr>
                                        <th>계좌번호<em class="req">*</em></th>
                                        <td colspan="3">
                                            <input type="text" name="bankno" id="bankno" value="<%= dto.getBankno() %>" placeholder="- 없이 입력해주세요." maxlength="20" required="" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="btn_wrap">
                        <button type="submit" id="btnTmpEdit" class="btn_lg btn_primary">수정</button>
                    </div>
                </form>
            </section>
        </div>
    </div>
</div>
</body>
</html>
