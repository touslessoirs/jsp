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
	<h1>updatePro.jsp</h1>
	
	<%
	request.setCharacterEncoding("UTF-8");
	
	// 전달 정보(pageNum) 저장
	String pageNum = request.getParameter("pageNum");

	// 전달된 정보 (수정할 데이터 - bno, name, pass, subject, content) 저장 - 액션태그
	%>
	<jsp:useBean id="dto" class="com.itwillbs.board.BoardDTO"/>
	<jsp:setProperty property="*" name="dto"/>
	
	<%
	// 수정할 정보 DB에 반영하기
	BoardDAO dao = new BoardDAO();
	
	int result = dao.updateBoard(dto);
	if(result == -1){
		// 수정 실패 - 글 정보 없음
	%>
	    <script type="text/javascript">
	        alert('게시판 글 없음!');
	        history.back();
	    </script>
	<%
	} else if(result == 0){
		// 수정 실패 - 글 비밀번호 오류
	%>
	    <script type="text/javascript">
	        alert('게시판 비밀번호 오류!');
	        history.back();
	    </script>
	<%
	} else {
		// 수정 성공 -> boardList 이동
	%>
	    <script type="text/javascript">
	        alert('게시글 수정 완료!')
	        location.href="boardList.jsp?pageNum=<%=pageNum%>";
	    </script>
	<%
	}
	%>

</body>
</html>