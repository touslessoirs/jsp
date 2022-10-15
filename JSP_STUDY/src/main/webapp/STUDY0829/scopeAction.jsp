<%@page import="java.nio.charset.CharsetEncoder"%>
<%@page import="java.beans.Encoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <%
      //request.setCharacterEncoding("UTF-8");
   %>
	<h1>scopeAction.jsp</h1>
	<h2>파라미터</h2>
<%-- 	아이디 : <%=(String)request.getAttribute("id") %><br> --%>
		아이디 : <%=request.getParameter("id") %><br>
		비밀번호 : <%=request.getParameter("pw") %><br>
	
	<hr>
	<h2>어트리뷰트</h2>
	   page : <%=pageContext.getAttribute("p") %><br>
	   request : <%=request.getAttribute("r") %><br>
	   session : <%=session.getAttribute("s") %><br>
	   application : <%=application.getAttribute("a") %><br>   

	
	
	
	
</body>
</html>