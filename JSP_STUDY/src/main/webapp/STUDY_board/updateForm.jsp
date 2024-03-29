<%@page import="com.itwillbs.board.BoardDTO"%>
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
	<h1>updateForm.jsp</h1>
	
	<%
	// 글 정보(bno), 페이지 정보(pageNum) 출력하기
	
	// 글 정보(bno), 페이지 정보(pageNum) 가져오기
	int bno = Integer.parseInt(request.getParameter("bno"));
	String pageNum = request.getParameter("pageNum");
	
	// BoardDAO 객체 생성
	BoardDAO dao = new BoardDAO();
	
	// 글 정보 가져오기 메서드 호출
	BoardDTO dto = dao.getBoard(bno);
	%>

	<fieldset>
		<form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post" name="fr" onsubmit="return check();">
	        <input type="hidden" name="bno" value="<%=dto.getBno() %>">	<!--*3-->
	        제목 : <input type="text" name="subject" value="<%=dto.getSubject() %>"><br>
	        작성자 : <input type="text" name="name" value="<%=dto.getName() %>"><br>
	        비밀번호 : <input type="password" name="pass" placeholder="비밀번호를 입력하세요"><br>
	        내용 : <textarea rows="10" cols="20" name="content"><%=dto.getContent() %></textarea>
	        <hr>
	        <input type="submit" value="글 수정하기">
	    </form>
	</fieldset>
	
	<script type="text/javascript">
		function check(){
			alert("체크 함수 실행")
			var pass = document.fr.pass.value;
			if (pass=""){
				alert("비밀번호를 입력하세요");
				document.fr.pass.focus();
				return false;	// check() 종료하는 것이 아니라 submit 동작을 막는 것
			}
			
		}
	
	</script>
</body>
</html>