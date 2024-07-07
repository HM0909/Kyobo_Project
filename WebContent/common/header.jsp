<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="companymember.MemberDAO"%>
<%@ page import="companymember.MemberDTO"%>
<%
	String contextPath = request.getContextPath();
	
	if (session != null && session.getAttribute("UserId") == null) {
		response.sendRedirect(contextPath + "/login/login.jsp");
	}
	
	String id = "";
	String UserName = "";
	
	if (session.getAttribute("UserId") != null && session.getAttribute("UserName") != null) {
		id = session.getAttribute("UserId").toString();
		UserName = session.getAttribute("UserName").toString();	
	}
	
	String currentPage = request.getServletPath();    
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<%=contextPath%>/css/login.css" type="text/css" />
</head>
<body>
    <div class="wrapper" id="wrap" style="height: auto; min-height: 100%;">
        <div class="header-wrapper">    
            <div class="header pagewidth">
                <header class="main-header">
                    <div class="inner">
                        <div class="logo-white">
                            <img src="<%=contextPath%>/images/logo.png" alt="Logo">
                        </div>
                        <div class="info" id="loginUserInfo">
                            <span><a href="<%=contextPath%>"><%=UserName%>님</a></span>
                            <a id="logoutBtn" href="<%=contextPath%>/login/logout.jsp"><i class="glyphicon glyphicon-log-out">로그아웃</i></a>
                            <a href="<%=contextPath%>/member/signup_view.jsp?id=<%=id%>" id="chhUserInfo">정보변경</a>
                            <a href="<%=contextPath%>/member/deleteProcess.jsp?id=<%=id%>" id="wdrlUser">회원탈퇴</a>
                        </div>
                    </div>
                </header>
            </div>
        </div>
        <div class="nav-wrapper">
            <div class="nav pagewidth">
                <ul>
                    <!-- MENU -->
                    <li <% if (currentPage.equals("/main.jsp")) { %>class="selected"<% } %>><a href="<%=contextPath%>/main.jsp">Main</a></li>
                    <li <% if (currentPage.equals("/book/book_list.jsp")) { %>class="selected"<% } %>><a href="<%=contextPath%>/book/book_list.jsp">도서목록</a></li>
                    <li <% if (currentPage.equals("/book/book_write.jsp")) { %>class="selected"<% } %>><a href="<%=contextPath%>/book/book_write.jsp">도서등록</a></li>
                    <li <% if (currentPage.equals("/salselist.jsp")) { %>class="selected"<% } %>><a href="<%=contextPath%>/salselist.jsp">정산</a></li>
                    <li <% if (currentPage.equals("/notice/noticelist.jsp")) { %>class="selected"<% } %>><a href="<%=contextPath%>/notice/noticelist.jsp">공지사항</a></li>
                    <!-- END MENU -->
                </ul>
            </div>
        </div>
    </div>
</body>
</html>