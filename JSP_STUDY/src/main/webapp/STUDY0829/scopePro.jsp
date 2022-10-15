<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<% /*request.setAttribute("id", "BUSAN");
	String id = (String)request.getAttribute("id");
	form 입력값과 상관없이 속성 설정값 가져오기*/
	
	String id = request.getParameter("id");%>
	
	1. HTML - a 태그
<%-- 		<a href="scopeAction.jsp?id=<%=id %>&pw=1234"></a> --%>
	2. JavaScript - location.href 태그
		<script type="text/javascrip">
<%-- 		location.href='scopeAction.jsp?id=<%=id %>&pw=1234';	 --%>
		</script>
	3. JSP - response.sendRedirect() 태그
		<%// response.sendRedirect("scopeAction.jsp?"+id+"&pw=1234");%>
		<%// response.sendRedirect("scopeAction.jsp?"+URLEncoder.encode(id)+"&pw=1234");%>
	4. JSP - 액션 태그 forward
		<jsp:forward page="scopeAction.jsp">
			<jsp:param value="99999" name="pw"/>
		</jsp:forward>
		



</body>
</html>