<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.NoticeDTO"%>
<%@ page import="util.JSFunction"%>
<%
	String num = request.getParameter("num");
	
	NoticeDAO dao = new NoticeDAO();
		
	int delResult = 0;
	
	delResult = dao.deletePost(num);
	dao.close();
	
	if (delResult > 0) {
		JSFunction.alertLocation(num + "글 삭제되었습니다", "noticelist.jsp", out);
	} else {
        JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
%>

