<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="notice.NoticeDAO"%>
<%@ page import="notice.NoticeDTO"%>
<%
	String num = request.getParameter("num");

	NoticeDAO dao = new NoticeDAO();
	NoticeDTO dto = dao.selectView(num);
	
	dao.close();
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" href="../css/board.css" type="text/css" />
<script>
	function deletePost(num) {
		let confirmed = confirm("정말로 삭제하겠습니까?")  // true , flase
		
		if (confirmed) {
			/*let form = document.noticeFrm;
			form.method = "post";               // 전송 방식 
	        form.action = "DeleteProcess.jsp";  // 전송 경로
	        form.submit();
	        */
	        location.href = "./deleteProcess.jsp?num=" + num;
		}	
	}
</script>
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
						<br>
						<form name="noticeFrm" method="post" >
							    <table border="1" width="90%">
							        <tr>
							            <td>제목</td>
							            <td>
							                <input type="text" name="title" value="<%= dto.getTitle() %>" style="width: 90%;" readonly />
							            </td>
							        </tr>
							        <tr>
							            <td>내용</td>
							            <td>
							                <textarea name="content" style="width: 90%; height: 100px;" readonly ><%= dto.getContent() %></textarea>
							            </td>
							        </tr>
							        <tr>
							            <td colspan="2" align="center">
							            <button type="button" onclick="deletePost('<%= dto.getNum() %>')" id="btnTmpDelete" class="align-button">삭제</button>
							            </td>
							        </tr>
							    </table>
						</form>
					  </div>
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
</body>
</html>