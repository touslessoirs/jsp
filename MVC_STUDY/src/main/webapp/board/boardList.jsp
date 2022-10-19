<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>boardList (MVC).jsp</h1>

	<h3><a href="./BoardWrite.bo">글쓰기</a></h3>
	<h3><a href="./BoardReWrite.bo">첨부파일 글쓰기</a></h3>

	<table border="1">
	    <tr>
	        <th>번호</th>
	        <th>제목</th>
	        <th>작성자</th>
	        <th>조회수</th>
	        <th>작성일</th>
	        <th>ip</th>
	    </tr>

		<c:forEach var="dto" items="${boardList }">
			<tr>
				<td>${dto.bno }</td>
				<td>
					<a href="./BoardContent.bo?bno=${dto.bno }&pageNum=${pageNum }">${dto.subject }</a>
				</td>
		        <td>${dto.name }</td>
		        <td>${dto.readcount }</td>
		        <td>${dto.date }</td>
		        <td>${dto.ip }</td>
			</tr>
		</c:forEach>
	</table>
	
<!-- 	이전, 페이지번호, 다음 -->
	<c:if test="${totalCnt !=0 }">
		<!-- 이전 -->
		<c:if test="${startPage > pageBlock }">
			<a href="./BoardList.bo?pageNum=${startPage-pageBlock }">[이전]</a>
		</c:if>
		
		<!-- 페이지 번호 (1, 2, 3, ...)-->
		<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
			<a href="./BoardList.bo?pageNum=${i }">${i }</a>
		</c:forEach>
		
		<!-- 다음 -->
		<c:if test="${endPage < pageCount }">
			<a href="./BoardList.bo?pageNum=${startPage+pageBlock }">[다음]</a>		
		</c:if>
	
	</c:if>


</body>
</html>