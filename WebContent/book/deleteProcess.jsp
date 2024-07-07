<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="book.BookDTO"%>
<%@ page import="book.BookDAO"%>
<%@ page import="util.JSFunction"%>
<%
	String isbn = request.getParameter("isbn");
	
	BookDAO dao = new BookDAO(application);
		
	int delResult = 0;
	
	delResult = dao.deletePost(isbn);
	dao.close();
	
	if (delResult > 0) {
		JSFunction.alertLocation(isbn + "글 삭제되었습니다", "./book_list.jsp", out);
	} else {
        JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
%>









