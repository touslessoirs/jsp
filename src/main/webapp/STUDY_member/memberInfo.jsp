<%@page import="com.itwillbs.member.MemberDAO"%>
<%@page import="com.itwillbs.member.MemberBean"%>
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
	<h1>memberInfo.jsp</h1>
	<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	if(id==null){
		// 로그인 정보 없으면 -> login페이지로 돌려보내기
		response.sendRedirect("loginForm.jsp");
	}
	
	// MemberDAO 객체 생성
	MemberDAO dao = new MemberDAO();

	MemberBean mb = dao.getMember(id);
	
	%>
	
	<%=mb.toString() %><hr>
	
	아이디 : <%=mb.getId() %><br>
	비밀번호 : <%=mb.getPw() %><br>
	이름 : <%=mb.getName() %><br>
	나이 : <%=mb.getAge() %><br>
	성별 : <%=mb.getGender() %><br>
	이메일 : <%=mb.getEmail() %><br>
	회원가입일 : <%=mb.getRegdate() %><br>
	
	
	<hr>
	<a href="main.jsp">메인페이지</a>
	
</body>
</html>