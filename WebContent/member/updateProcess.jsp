<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="companymember.MemberDAO" %>
<%@ page import="companymember.MemberDTO" %>
<%@ page import="util.JSFunction" %>

<%
    MemberDAO dao = new MemberDAO();

    String memberId = request.getParameter("id");
    MemberDTO dto = dao.selectView(memberId);

    dto.setPassword(request.getParameter("password"));
    dto.setName(request.getParameter("name"));
    dto.setNameno(request.getParameter("nameno"));
    dto.setPhone(request.getParameter("phone1"), request.getParameter("phone2"), request.getParameter("phone3"));
    dto.setAddress(request.getParameter("address"));
    dto.setEmail(request.getParameter("emailAccount"), request.getParameter("emailDomain"));
    dto.setBank(request.getParameter("bank"));
    dto.setAccname(request.getParameter("accname"));
    dto.setBankno(request.getParameter("bankno"));

    int updateResult = dao.updateEdit(dto);

    if (updateResult > 0) {
        JSFunction.alertBack( memberId + "정보가 수정되었습니다", out);
    } else {
        JSFunction.alertBack("수정하기에 실패하였습니다.", out); 
    }
%>
