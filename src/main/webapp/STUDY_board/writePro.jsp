<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>writePro.jsp</h1>

	<%
	request.setCharacterEncoding("UTF-8");
	
	// 전달받은 정보 dto에 저장하기 + ip 주소 저장%>
	<jsp:useBean id="dto" class="com.itwillbs.board.BoardDTO"/>
	<jsp:setProperty property="*" name="dto"/>
		
	<%
	dto.setIp(request.getRemoteAddr());		

	// dto에 저장한 정보 DB에 반영하기
	BoardDAO dao = new BoardDAO();
	
	dao.insertBoard(dto);
	
	// boardList로 이동하기
	response.sendRedirect("boardList.jsp");
	%>

</body>
</html>