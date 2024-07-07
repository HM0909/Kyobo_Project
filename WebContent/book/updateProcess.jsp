<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="book.BookDTO"%>
<%@ page import="book.BookDAO"%>
<%@ page import="util.JSFunction"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	String saveDirectory = application.getRealPath("/Uploads");
	int maxPostSize = 1024 * 10000; // (1MB)
	String encoding = "UTF-8";

 	// MultipartRequest(request객체,저장위치,파일의 최대크기,인코딩,이름정책)
	MultipartRequest mr = new MultipartRequest(request,saveDirectory,maxPostSize,encoding);

 	Enumeration formNames = mr.getFileNames();
		
	Map<String,String> map = new HashMap<>();
		
	while(formNames.hasMoreElements()){
		String file = (String)formNames.nextElement();
		String file_name = mr.getFilesystemName(file);
			
		String ori_file_name = mr.getOriginalFileName(file);
			
		System.out.println("원본: " + ori_file_name);
		System.out.println("서버: " + file_name);
			
		map.put(ori_file_name, file_name);
	}
		
	Set<String> keys = map.keySet();
	
	for (String key : keys) {
		System.out.println("원본파일명 :  " + key + "  ,  " + "서버파일명 :  " + map.get(key));
		
		if (key != null) {
			String fileName = key; 
			String ext = fileName.substring(fileName.lastIndexOf(".")); // 파일 확장자 (.txt)
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());  // 날짜 정보를 이용해서 새로운 파일명 생성
			String newFileName = now + ext;  // 20240525_121022.txt
					
			// 파일명 변경
			// D:\work\jspworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FileUploadProject\Uploads\javascript사아트 모음.txt
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
					   
			oldFile.renameTo(newFile);
				
			map.put(map.get(key),newFileName);	
		}
	} 
	 
	int i = 0;
	String[] files = new String[3];
	
	for (String key : keys) {
		if (key != null) {
			files[i++] = key;
		}
	}
	  	  
	// System.out.println(map.get(files[0]));
	// System.out.println(map.get(files[1]));
	// System.out.println(map.get(files[2]));
	  
	BookDAO dao = new BookDAO(application);
	
	// 저장된 값 조회 
	BookDTO dto = dao.selectView(mr.getParameter("isbn"));
	
	dto.setIsbn(Integer.parseInt(mr.getParameter("isbn")));
	dto.setCategorym(mr.getParameter("categorym"));
	dto.setBooktitle(mr.getParameter("booktitle"));
	dto.setPublish(mr.getParameter("publish"));
	dto.setAuthor(mr.getParameter("author"));
	dto.setCatagoryno(Integer.parseInt(mr.getParameter("categoryno")));
	dto.setAge(mr.getParameter("age"));
	dto.setPubdate(mr.getParameter("pubdate"));
	dto.setPrice(Integer.parseInt(mr.getParameter("price")));
	dto.setConinfo(mr.getParameter("coninfo"));
	dto.setContable(mr.getParameter("contable"));
	
	// 파일을 수정 안하면 변경하지 않음 
	if (map.get(files[0]) != null) {
		dto.setBookimg(map.get(files[0]));	
	}
	
	if (map.get(files[1]) != null) {
		dto.setBookcover(map.get(files[1]));	
	}
	
	if (map.get(files[2]) != null) {
		dto.setBookfile(map.get(files[2]));	
	}
	
	int iResult = dao.updateEdit(dto);
	
	dao.close();
	
	if (iResult > 0) {
	    response.sendRedirect("./book_view.jsp?isbn=" + mr.getParameter("isbn")); 
	} else{
	    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
	}
%>