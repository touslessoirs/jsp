<%@page import="com.itwillbs.board.BoardDAO"%>
<%@page import="com.itwillbs.board.BoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>fwritePro.jsp.</h1>
	
	<%
	// 파일을 업로드 할 폴더
	String realPath = request.getRealPath("/upload");
	System.out.println(" @realPath : "+realPath);
	
	// 업로드 파일의 크기 제한 : 20MB
	int maxSize = 20*1024*1024;
	
	// MultipartRequest 객체 생성
	MultipartRequest multi 
		= new MultipartRequest (request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	System.out.println(" 파일 업로드 성공!");	
	
	// 전달 정보(subject, name, pass, content, file) 저장
	BoardDTO dto = new BoardDTO();
	dto.setSubject(multi.getParameter("subject"));
	dto.setName(multi.getParameter("name"));
	dto.setPass(multi.getParameter("pass"));
	dto.setContent(multi.getParameter("content"));
	dto.setFile(multi.getFilesystemName("file"));	// 내부적으로 실제 파일 구분하기 위함
// 	dto.setFile(multi.getOriginalFileName("file"));	// 유저에게 보여주기 위함
	// ip 주소 저장
	dto.setIp(request.getRemoteAddr());

	// dto에 저장한 정보 DB에 저장하기
	BoardDAO dao = new BoardDAO();
	
	dao.insertBoard(dto);
	
	// boardList로 이동
	response.sendRedirect("boardList.jsp");
	
	%>
	
</body>
</html>