<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<br>
						<form name="noticeFrm" method="post" action="writeProcess.jsp">
							    <table border="1" width="90%">
							        <tr>
							            <td>제목</td>
							            <td>
							                <input type="text" name="title" style="width: 90%;" />
							            </td>
							        </tr>
							        <tr>
							            <td>내용</td>
							            <td>
							                <textarea name="content" style="width: 90%; height: 100px;"></textarea>
							            </td>
							        </tr>
							        <tr>
							            <td colspan="2" align="center">
							               <div><button type="submit" class="align-button">완료</button></div>
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