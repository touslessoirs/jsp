<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>cookiePro.jsp</h1>
	<%
	request.setCharacterEncoding("UTF-8");
	
	Cookie cookie2 = new Cookie("language", request.getParameter("language"));
	
	cookie2.setMaxAge(600);
	
	response.addCookie(cookie2);
	
	%>
	
	<script type="text/javascript">
		alert("언어정보 쿠키 생성완료");
		location.href="cookieForm.jsp"
	</script>
	
</body>
</html>