<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		function cookieSet(){
			alert("서버로 페이지 요청(request)");
			location.href='cookieSet.jsp';
		}
		function cookieDel(){
			alert("서버로 페이지 요청(request)");
			location.href='cookieDel.jsp';
		}
	</script>

</head>
<body>
	<h1>cookieTest.jsp</h1>
	<hr>
	<h1>클라이언트</h1>
	<input type="button" value="쿠키값 생성" onclick="cookieSet();">
	<input type="button" value="쿠키값 삭제" onclick="cookieDelete();">
</body>
</html>