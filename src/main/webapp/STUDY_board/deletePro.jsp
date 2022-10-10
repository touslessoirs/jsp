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
	<h1>deletePro.jsp</h1>
	
	<%
	request.setCharacterEncoding("UTF-8");
	
	// 전달 정보(pageNum) 저장
	String pageNum = request.getParameter("pageNum");

	// 전달 정보 (bno,  pass) 저장 - java
	int bno = Integer.parseInt(request.getParameter("bno"));
	String pass = request.getParameter("pass");

	// 삭제할 정보 DB에 반영하기
	BoardDAO dao = new BoardDAO();

	int result = dao.deleteBoard(bno, pass);
	if(result == -1){
		// 삭제 실패 - 글 정보 없음
	%>
	    <script type="text/javascript">
	        alert('게시판 글 없음!');
	        history.back();
	    </script>
	<%
	} else if(result == 0){
		// 삭제 실패 - 글 비밀번호 오류
	%>
	    <script type="text/javascript">
	        alert('게시판 비밀번호 오류!');
	        history.back();
	    </script>
	<%
	} else {
		// 삭제 성공 -> boardList 이동
	%>
	    <script type="text/javascript">
	        alert('게시글 삭제 완료!')
	        location.href="boardList.jsp?pageNum=<%=pageNum%>";
	    </script>
	<%
	}
	%>

</body>
</html>