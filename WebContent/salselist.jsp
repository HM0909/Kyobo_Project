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
                        <h3></h3>
                        <div class="box"><td align="center">
                            <div class="tbHead mt_15">
                                <br>
                                <span>총 판매 금액 <h6>1,500,100</h6> 원</span>
                            </div>
                        </div>
                        <br>
                        <div class="box">
                            <input type="date" th:field="*{start}">
                            ~
                            <input type="date" th:field="*{end}">
                            <input type="submit" value="조회"/>
                        </div>	
                        <br>
                		<br>
                        <table>
                            <tbody>
                               <tr>
									<th>구매일시</th>
									<th>판매번호</th>
									<th>도서명</th>
									<th>정가</th>
									<th>고객아이디</th>
								</tr>
								<tr>
									<td>2024-08-23 11:10:21</td>
									<td>160801003</td>
									<td>교보문고 책</td>
									<td>12,000원</td>
									<td>Admin</td>
								</tr>
								<tr>
									<td>2024-08-23 11:10:21</td>
									<td>160801003</td>
									<td>교보문고 책</td>
									<td>12,000원</td>
									<td>Admin</td>
								</tr>
								<tr>
									<td>2024-08-23 11:10:21</td>
									<td>160801003</td>
									<td>교보문고 책</td>
									<td>12,000원</td>
									<td>Admin</td>
								</tr>
								<tr>
									<td>2024-08-23 11:10:21</td>
									<td>160801003</td>
									<td>교보문고 책</td>
									<td>12,000원</td>
									<td>Admin</td>
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
</body>
</html>
