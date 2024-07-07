<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="companymember.MemberDAO"%>
<%@ page import="companymember.MemberDTO"%>
<%@ page import="util.JSFunction"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("password"); 
	
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.selectView(userId, userPwd);
    
    dao.close();
    
    if (dto != null && dto.getId() != null) {
    	session.setAttribute("UserId", dto.getId());
    	session.setAttribute("UserName", dto.getName());
    	
    	response.sendRedirect("../main.jsp");
    } else {
    	JSFunction.alertLocation("로그인 정보가 올바르지 않습니다.", "./login.jsp", out);
    }	
%>