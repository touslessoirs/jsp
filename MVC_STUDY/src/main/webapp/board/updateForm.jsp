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
	<h1>updateForm (MVC).jsp</h1>
	
	<fieldset>
	    <form action="./BoardUpdatePro.bo?pageNum=${pageNum }" method="post">
			<input type="hidden" name="bno" value="${dto.bno }">
	        제목 : <input type="text" name="subject" value=${dto.subject }><br>
	        작성자 : <input type="text" name="name" value=${dto.name }><br>
	        비밀번호 : <input type="password" name="pass"><br>
	        내용 : <textarea rows="10" cols="20" name="content">${dto.content }</textarea>
	        <hr>
	        <input type="submit" value="글 수정하기">
	    </form>
	</fieldset>
	
	
</body>
</html>