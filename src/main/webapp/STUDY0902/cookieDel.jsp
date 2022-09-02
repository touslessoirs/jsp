<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>cookieDel.jsp</h1>
	
	<%
	// 1. 기존의 쿠키값 가져오기
	Cookie[] cookies = request.getCookies();
	
	// 2. 삭제하려는 쿠키정보 찾기
	if(cookies != null){
		for(int i=0;i<cookies.length;i++){
			if(cookies[i].getName().equals("id"));
			// 2-1. 쿠키 삭제
			cookies[i].setMaxAge(0);
			// 2-2. 변경된 쿠키 정보를 클라이언트에게 전송
			response.addCookie(cookies[i]);
		}
	}
	%>
	
	<script type="text/javascript">
		alert("쿠키 삭제완료");
		location.href="cookieForm.jsp"
	</script>

</body>
</html>