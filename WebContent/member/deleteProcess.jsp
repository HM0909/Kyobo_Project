<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="companymember.MemberDAO"%>
<%@ page import="companymember.MemberDTO"%>
<%@ page import="util.JSFunction"%>
<%
	String id = session.getAttribute("UserId").toString();
	
	MemberDAO dao = new MemberDAO();
		
	int delResult = 0;
	
	delResult = dao.deletePost(id);
	dao.close();
	
	if (delResult > 0) {
		JSFunction.alertLocation("회원탈퇴 되었습니다", "../login/login.jsp", out);
	} else {
        JSFunction.alertBack("회원탈퇴에 실패하였습니다.", out);
	}
%>
