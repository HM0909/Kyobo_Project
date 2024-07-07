<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List,java.util.Map,java.util.HashMap"%>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.NoticeDTO"%>
<%	
	Map<String, Object> requestMap = new HashMap<String, Object>();
	
	NoticeDAO dao = new NoticeDAO();
	List<NoticeDTO> noticeList = dao.selectListPage(requestMap);
	
	dao.close();
    request.setAttribute("noticeList", noticeList);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="../css/board.css" type="text/css" />
</head>
<body>
    <div class="wrapper" id="wrap" style="height: auto; min-height: 100%;">
        <div class="content-wrapper" style="min-height: 1031px;">    
            <%@ include file="../common/header.jsp" %>
            <div class="pagewidth">
                <div class="page-wrap">
                    <div class="content">
                        <!-- CONTENT -->
                        <h3></h3>
                        <br>
                        <br>
                        <table>
                            <tbody>
                                <tr>
                                    <th class="notice">번호</th>
                                    <th class="notice">제목</th>
                                    <th class="notice">작성일</th>
                                </tr>
                                
                               <c:forEach items="${noticeList}" var="row" varStatus="loop" >  
                                <tr>
                                    <td>${row.num}</td>
                                    <td><a href="noticeview.jsp?num=${row.num}">${row.title}</a></td>
                                    <td>${row.regidate}</td>
                                </tr>
                             </c:forEach>
                            </tbody>
                        </table>        
                      </div>
                    </div>
                    
                	<button type="button" class="right-align-button" onclick="location.href='noticewirte.jsp';">등록</button>
                	
                    <div class="sidebar">    
                            
                        <!-- SIDEBAR -->    
                        
                        
                        <!-- SIDEBAR -->
                
                    </div>
                
                    <!-- <div class="footer">
                        <p><a href="http://validator.w3.org/check/referer" title="valid XHTML">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer" title="valid CSS">CSS</a> &nbsp;&nbsp; &copy; YourWebsiteName. Design: <a href="http://www.spyka.net">spyka webmaster</a> | <a href="http://www.justfreetemplates.com">Free Web Templates</a></p> 
                    </div>
                    <div style="font-size: 0.8em; text-align: center;">
                        <br />
                        Design downloaded from Zeroweb.org: <a href="http://www.zeroweb.org">Free website templates, layouts, and tools.</a><br />
                        <br />
                    </div> -->
                </div>    
            </div>    
        </div>        
</body>
</html>
