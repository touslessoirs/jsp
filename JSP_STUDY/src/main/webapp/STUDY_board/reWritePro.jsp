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
	<h1>reWritePro.jsp</h1>

	<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// 전달 정보 저장 -> 액션태그
	// bno, re_ref, re_lev, re_seq, subject, name, pass, content
	int bno = Integer.parseInt(request.getParameter("bno"));
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));
	String subject = request.getParameter("subject");
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String content = request.getParameter("content");
	%>
	
	<jsp:useBean id="dto" class="com.itwillbs.board.BoardDTO"/>
	<jsp:setProperty property="*" name="dto"/>
	
	<%
	// ip 정보 저장
	dto.setIp(request.getRemoteAddr());
	
	// dto에 저장한 정보 DB에 반영하기
	BoardDAO dao = new BoardDAO();
	dao.reInsertBoard(dto);
	
	// BoardList로 이동
	response.sendRedirect("boardList.jsp");
	
	%>
</body>
</html>