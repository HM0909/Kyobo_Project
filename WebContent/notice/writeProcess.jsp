<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.NoticeDTO"%>
<%

    String title = request.getParameter("title");
    String content = request.getParameter("content");

    NoticeDTO dto = new NoticeDTO();
    dto.setTitle(title);
    dto.setContent(content);

    NoticeDAO dao = new NoticeDAO(); // 적절한 방식으로 DAO 객체 생성
    int result = dao.insertNotice(dto);
    dao.close();

    if (result > 0) {
        response.sendRedirect("noticelist.jsp");
    } else {
        out.println("<script>alert('글쓰기에 실패했습니다.'); history.back();</script>");
    }
%>
