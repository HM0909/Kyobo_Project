<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="book.BookDAO"%>
<%@ page import="book.BookDTO"%>
<%
	String isbn = request.getParameter("isbn");

	BookDAO dao = new BookDAO(application);
	BookDTO dto = dao.selectView(isbn);
	
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" href="../css/ditail.css" type="text/css" />
<script>
	function deletePost(isbn) {
		let confirmed = confirm("정말로 삭제하겠습니까?")  // true , flase
		
		if (confirmed) {
			/*let form = document.writeFrm;
			form.method = "post";               // 전송 방식 
	        form.action = "DeleteProcess.jsp";  // 전송 경로
	        form.submit();
	        */
	        location.href = "./deleteProcess.jsp?isbn=" + isbn;
		}	
	}
	
	function updatePost() {
		let confirmed = confirm("수정 하시겠습니까?")  // true , flase
		
		if (confirmed) {
			let form = document.updateFrm;
			form.method = "post";               // 전송 방식 
	        form.action = "updateProcess.jsp";  // 전송 경로
	        form.submit();
		}	
	}
</script>
</head>
<body>
	<div class="wrapper" id="wrap" style="height: auto; min-height: 100%;">
		<div class="content-wrapper" style="min-height: 1031px;">	
			<%@ include file="../common/header.jsp" %>
		<form name="updateFrm" method="post" action="updateProcess.jsp" enctype="multipart/form-data">
			<input type="hidden" name="num" value="" /> 
            <div class="pagewidth">
				<div class="page-wrap">
					<div class="content">
                                          <div class="tbHead mt_15">
                            <h6>콘텐츠 구분</h6>
                        </div>
                        <table class="tbIpt">
                            <colgroup>
                                <col class="th">
                                <col class="td">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>상품구분<em class="req">*</em></th>
                                    <td colspan="4">
                                            
                                        <span class="form radio">
                                                <input type="radio" name="categorym" id="dgctPrdcKindCode001" value="1" onclick="return(false);" checked="checked">
                                                <label for="dgctPrdcKindCode1" style="opacity: .5">일반도서</label>
                                        </span>
                                    </td>
                                </tr>
                                
                            </tbody>
                        </table>

                        <!-- 기본정보 -->
                        <div id="baseTab" class="tab-input">	
                            <div class="tbHead mt_40">
                                <h6>기본 정보</h6>
                                
                            </div>
                            <div class="tbBody">
                            	<table class="tbIpt">
                                    <colgroup>
                                        <col class="th">
                                        <col class="td">
                                        <col class="th">
                                        <col class="td">
                                    </colgroup>
                                
                                    <tbody>
                                        <tr id="isbnArea">
                                            <th>전자책e-ISBN<em class="req">*</em></th>
                                            <td colspan="6">
                                                <input type="text" class="onlyNumber" id="isbn" name="isbn" value="<%= dto.getIsbn() %>" maxlength="40" style="width: 275px" readonly>                                
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>도서명<em class="req">*</em></th>
                                            <td colspan="6">
                                                <input type="text" id="booktitle" name="booktitle"  value="<%= dto.getBooktitle() %>" style="width: 50%">
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>출판사<em class="req">*</em></th>
                                             <td colspan="2">
                                                <input type="text" id="publish" name="publish"  value="<%= dto.getPublish() %>">
                                            </td>

                                            <th>저자명</th>
                                            <td colspan="3">
                                                <div class="new_input_style">
                                                    <input type="text" id="author" name="author" value="<%= dto.getAuthor() %>">
                                                </div>
                                            </td>
                                        
                                        </tr>
                                

                                        <tr>
									    <th>상품분류<em class="req">*</em></th>
									     <td colspan="6">
									        <select id="categoryno" name="categoryno" required="">
									            <option value="10" <%= "10".equals(dto.getCatagoryno()) ? "selected" : "" %>>경제</option>
            									<option value="20" <%= "20".equals(dto.getCatagoryno()) ? "selected" : "" %>>종교</option>
            									<option value="30" <%= "30".equals(dto.getCatagoryno()) ? "selected" : "" %>>자기계발</option>
            									<option value="40" <%= "40".equals(dto.getCatagoryno()) ? "selected" : "" %>>IT</option>
            									<option value="50" <%= "50".equals(dto.getCatagoryno()) ? "selected" : "" %>>인문</option>
									        </select>
									    </td>
									</tr>

                                        <tr>
                                            <th>연령제한<em class="req">*</em></th>
                                            <td colspan="2">
                                                <select id="age" name="age">
                                                    <option value="0" <%= "0".equals(dto.getAge()) ? "selected" : "" %>>전체이용가</option>
                                                    <option value="19" <%= "19".equals(dto.getAge()) ? "selected" : "" %>>19세 이상</option>
                                                </select>
                                            </td>

                                            <th>출간일<em class="req">*</em></th>
                                            <td colspan="3">
                                                <input type="date" id="pubdate" name="pubdate" class="date"  value="<%= dto.getPubdate() %>">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <div id="baseTab" class="tab-input">	
                            		<div class="tbHead mt_40">
                                    	<h6>가격 정보</h6>
                  					</div>
                                <div class="tbBody" style="">
                                    <table class="tbIpt">
                                        <colgroup>
                                            <col class="th">
                                            <col class="td">
                                            <col class="th">
                                            <col class="td">
                                        </colgroup>
                                        <tbody>
                                            <tr>                                         
                                                <th>전자책정가<em class="req">*</em></th>
                                                <td colspan="3">
                                                   <input type="text" class="onlyNumber chg-table-amt text-right" name="price" id="price" value="<%= dto.getPrice()%>"><span class="unit">원</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div id="intcTab" class="tab-input">                        
                                    <div class="tbHead mt_40">
                                        <h6>도서소개 정보</h6>
                                    </div>
                                    <div class="tbBody">
                                        <table class="tbIpt">
                                            <colgroup>
                                                <col style="width:12%;">
                                                <col style="width:38%;">
                                                <col style="width:12%;">
                                                <col style="width:38%;">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th>책소개<em class="req">*</em></th>
                                                    <td colspan="3">
                                                        <textarea rows="5" cols="" id="coninfo" name="coninfo" value=""><%= dto.getConinfo()%></textarea>
                                                    </td> 
                                                </tr>
                                                
                                                <tr>
                                                    <th>목차</th>
                                                    <td id="divCtntCntt" colspan="3">
                                                            <textarea rows="5" id="contable" name="contable" placeholder="" data-dgct-ctnt-num="1" value=""><%= dto.getContable() %></textarea>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <th>책소개 상세이미지</th>
                                                    <td colspan="3">
                                                        <input type="hidden" id="bkcrdImgFileUrladrs" name="bkcrdImgFileUrladrs" value="<%= dto.getBookimg() %>">
                                                    
                                                        <div class="filebox">
                                                            <input type="text" readonly="readonly" class="upload-name">
                                                            <input type="file" name="bookimg" id="bookimg">
                                                        </div>
														
														 <% if (dto.getBookimg() != null && !dto.getBookimg().isEmpty()) { %>
													        <img src="<%= dto.getBookimg() %>" alt="책소개 상세이미지" style="max-width: 100%; height: auto;">
													     <% } %>
                                                        <ul class="list_style3 mt_10">
                                                            <li>jpg 사이즈 : 가로 754px / 세로 16000px 이내</li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div> 
                                </div>                                   
                                
                            
                                    <div class="tbHead mt_40">
                                        <h6 style="margin-right: 10px;">파일 정보</h6>
                                    </div>
                                    <div class="tbBody">
                                        <table class="tbIpt">
                                            <colgroup>
                                                <col class="th">
                                                <col class="td">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th>표지이미지<em class="req">*</em></th>
                                                    <td id="cverFileTdArea" style="vertical-align: top;" colspan="3">                                                            
                                                        <div class="filebox preview-image">
                                                            <input type="text" readonly="readonly" class="upload-name">
                                                            <input type="file"  name="bookcover" id="bookcover"/>
                                                        </div>                                                            
                                                    	<img src="<%= dto.getBookcover() %>" alt="표지이미지" style="max-width: 100%; height: auto;">
                                                        <ul class="list_style3 mt_10">
                                                            <li>*지원 파일 형식 : JPG, PNG</li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <th id="ortxFileThArea">도서파일<em class="req">*</em></th>
                                                    <td id="ortxFileTdArea" style="vertical-align: top;" colspan="3">

                                                        <div class="filebox">
                                                            <input type="text" readonly="readonly" class="upload-name"  value="<%= dto.getBookfile() %>">
                                                            <input type="file" name="bookfile" id="bookfile" >
                                                        </div>
                                                        <ul class="list_style3 mt_10">
                                                            <li>*지원 파일 형식 : EPUB, PDF​</li>
                                                        </ul>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
	                            </div>
	                        </div>                
	                    </div>        
               		 </div>    


                <div class="btn_wrap">
                    <button type="button" id="btnTmpEdit" class="btn_lg btn_primary" onclick="updatePost();">수정</button>
                    <button type="button" onclick="location.href='book_list.jsp';" id="btnTmpList" class="btn_lg btn_primary">목록</button>
                    <button type="button" onclick="deletePost('<%= dto.getIsbn() %>')" id="btnTmpDelete" class="btn_lg btn_primary">삭제</button>
                </div>
           </form>	
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