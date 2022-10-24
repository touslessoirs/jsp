<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>boardDeleteForm (MVC).jsp</h1>

	<fieldset>
		<form action="./BoardDeleteAction.bo?pageNum=${param.pageNum }" method="post">
			<input type="hidden" name="bno" value="${param.bno }">
			비밀번호 : <input type="password" name="pass">
			<input type="submit" value="글 삭제하기">
		</form>
	</fieldset>

</body>
</html>