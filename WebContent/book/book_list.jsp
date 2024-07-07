<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List,java.util.Map,java.util.HashMap"%>
<%@ page import="book.BookDAO"%>
<%@ page import="book.BookDTO"%>
<%	
	Map<String, Object> requestMap = new HashMap<String, Object>();
	
	BookDAO dao = new BookDAO(application);
	List<BookDTO> bookList = dao.selectListPage(requestMap);
	
	dao.close();
    request.setAttribute("bookList", bookList);
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
						<!-- 검색 폼 -->
					    <form method="get">  
						    <table border="1" width="90%">
							    <tr>
							        <td align="center">
							            <select name="searchField">
							                <option value="booktitle">도서명</option>
							                <option value="isbn">ISBN</option>
							            </select>
							            <input type="text" name="searchWord" />
							            <input type="submit" value="검색" />
							        </td>
							    </tr>
						    </table>
					    </form>
					    
					    <!-- 목록 테이블 -->
						<table>
							<tbody>
								<tr>
									<th>번호</th>
									<th>ISBN</th>
									<th>분류</th>
									<th>도서명</th>
									<th>저자</th>
									<th>출판사</th>
									<th>정가</th>
									<th>판매여부</th>
									<th>승인</th>
								</tr>
		
							        <c:forEach items="<%=bookList %>" var="row" varStatus="loop" >  
							        
							        	<tr>
							        		<td>${loop.index + 1}</td> <!-- /* ${bookList.size() - loop.index} -->
							        		<td>${row.getIsbn() }</td>
							        		<td>${row.getCatagoryname() }</td>
							        		<td>
							        			<a href="book_view.jsp?isbn=${row.getIsbn()}">${row.getBooktitle()}</a>	
							        		</td>
							        		<td>${row.getAuthor()}</td>
							        		<td>${row.getPublish()}</td>
							        		<td>${row.getPrice()}</td>
							        		<td>${row.getSales()}</td>
							        		<td><button type="button">판매</button></td>
							        	</tr>
							        </c:forEach>
						       
   						
							</tbody>			
						</table>
					</div>
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
	</div>
</body>
</html>