<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>eBook사이트</title>
<link rel="stylesheet" href="./css/board.css" type="text/css" />
</head>
<body>
	<div class="wrapper" id="wrap" style="height: auto; min-height: 100%;">
		<div class="content-wrapper" style="min-height: 1031px;">	
			<%@ include file="/common/header.jsp" %>
			
			<div class="pagewidth">
				<div class="page-wrap">
					<div class="content">
						<!-- CONTENT -->
						<div class="dashHome">
							<h4>디지털콘텐츠 현황</h4>
							<ul>
								<li>
									<a href=""><span>판매도서</span><em id="tmpCnt">0</em></a>
								</li>
							
								<li>
									<a href=""><span>등록대기</span><em id="tmpCnt">0</em></a>
								</li>
								<li>
									<a href=""><span>판매수</span><em id="tmpCnt">0</em></a>
								</li>
								<li>
									<a href=""><span>판매액</span><em id="tmpCnt">0</em></a>
								</li>
							</ul>
						</div>

						<div class="dashHome">
							<h4>공지사항</h4>
							<a href="/notice/noticelist.jsp"><img src="../images/logo.png" alt=""></a>
							<table>
	                            <tbody>
	                                <tr>
	                                    <th class="notice">번호</th>
	                                    <th class="notice">제목</th>
	                                    <th class="notice">작성일</th>
	                                </tr>
	                                
	                                <tr>
	                                    <td>${row.num}</td>
	                                    <td>${row.title}</td>
	                                    <td>${row.regidate}</td>
	                                </tr>
	                            </tbody>
	                       	</table>	
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
	</div>
</body>
</html>
</html>