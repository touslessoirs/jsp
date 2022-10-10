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
	<h1>boardContent.jsp</h1>
	<%
	// 주소줄에서 넘어온 글 정보 가져오기
	int bno = Integer.parseInt(request.getParameter("bno"));
	
	// 주소줄에서 넘어온 페이지 정보 가져오기
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	// 조회수 1 증가
	dao.updateReadcount(bno);
	
	// 해당 글 정보 출력해서 dto에 저장
	BoardDTO dto = dao.getBoard(bno);

	// 저장한 정보 출력하기
	%>
	
	<table border="1">
	    <tr>
	        <td>글번호</td>
	        <td><%=dto.getBno() %></td>
	        <td>조회수</td>
	        <td><%=dto.getReadcount() %></td>
	    </tr>
	    <tr>
	        <td>작성자</td>
	        <td><%=dto.getName() %></td>
	        <td>작성일</td>
	        <td><%=dto.getDate() %></td>
        </tr>
	    <tr>
	        <td>제목</td>
	        <td colspan="3"><%=dto.getSubject()%></td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td colspan="3"><%=dto.getContent() %></td>
	    </tr>
	    <tr>
	        <td>첨부파일</td>
	        <td colspan="3"><%=dto.getFile() %></td>
	    </tr>
	    <tr>
	        <td colspan="4">
	            <input type="button" value="수정" onclick="location.href='updateForm.jsp?bno=<%=dto.getBno()%>&pageNum=<%=pageNum%>';">
				<input type="button" value="삭제" onclick="location.href='deleteForm.jsp?bno=<%=dto.getBno()%>&pageNum=<%=pageNum%>';">
	            <input type="button" value="답글">
	            <!-- 조회중이었던 페이지로 돌아가기 -->
	            <input type="button" value="목록"
	                onclick="location.href='boardList.jsp?pageNum=<%=pageNum%>';">
	        </td>
	    </tr>
	
	</table>
</body>
</html>