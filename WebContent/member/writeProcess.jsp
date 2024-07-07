<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="companymember.MemberDAO"%>
<%@ page import="companymember.MemberDTO"%>
<%
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String nameno = request.getParameter("nameno");
    String phone1 = request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String postcode = request.getParameter("postcode");
    String address = request.getParameter("address");
    String detailAddress = request.getParameter("detailAddress");
    String extraAddress = request.getParameter("extraAddress");
    String emailAccount = request.getParameter("emailAccount");
    String emailDomain = request.getParameter("emailDomain");
    String bank = request.getParameter("bank");
    String accname = request.getParameter("accname");
    String bankno = request.getParameter("bankno");
    

    MemberDTO dto = new MemberDTO();
    dto.setId(id);
    dto.setPassword(password);
    dto.setName(name);
    dto.setNameno(nameno);
    dto.setPhone(phone1, phone2, phone3);
    dto.setAddress(postcode, address, detailAddress, extraAddress);
    dto.setEmail(emailAccount, emailDomain);
    dto.setBank(bank);
    dto.setAccname(accname);
    dto.setBankno(bankno);

    MemberDAO dao = new MemberDAO(); // 적절한 방식으로 DAO 객체 생성
    int result = dao.insertMember(dto);
    dao.close();
    

    if (result > 0) {
    	out.println("<script>alert('회원가입이 완료 되었습니다.'); location.href='../login/login.jsp';</script>");
    } else {
        out.println("<script>alert('회원 가입에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
