<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>main.jsp</h1>
	<%
	String id = (String)session.getAttribute("id");
	if(id==null){	// 넘어온 id(로그인 성공한 id) 정보 없음
		response.sendRedirect("loginForm.jsp");	// 로그인 페이지로 되돌아감
	}
	
	// 로그인 성공%>
	<h3> <%=id %>님 환영합니다~~~ </h3>
	
	<hr>
	<input type="button" value="로그아웃" onclick="location.href='logoutPro.jsp'"><br>

	<a href="memberInfo.jsp">회원정보 조회</a>
	<a href="memberUpdate.jsp">회원정보 수정</a><br>

</body>
</html>