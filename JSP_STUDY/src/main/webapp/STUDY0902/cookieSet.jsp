<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>cookieSet.jsp</h1>
	
	<%
	// 1. 쿠키값 생성 - 서블릿 API 사용
	Cookie cookie = new Cookie("id", "itwill");
	// 2. 쿠키 사용기간(유효기간 설정)
	cookie.setMaxAge(600);
	// 3. 쿠키정보를 (클라이언트에게) 전달
	response.addCookie(cookie);
	System.out.println(" 서버 : 쿠키 정보를 클라이언트로 전달 ");
	%>

	<script type="text/javascript">
		alert("쿠키 생성완료");
		location.href="cookieForm.jsp"
	</script>


</body>
</html>