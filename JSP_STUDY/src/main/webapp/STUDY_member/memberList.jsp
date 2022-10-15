<%@page import="com.itwillbs.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>memberList.jsp</h1>

	<%
	
	String id = (String)session.getAttribute("id");
	// 로그인을 안했거나, admin 계정이 아니면 로그인 페이지로 이동하기
	if((id==null) || (!id.equals("admin"))){
	    response.sendRedirect("loginForm.jsp");
	}
	
	// DB에 저장된 회원정보를 모두 가져오기
	
	// MemberDAO 객체 생성
	MemberDAO dao = new MemberDAO();
	 
	// dao 객체 안에 회원정보 전부를 조회하는 메서드 호출
	ArrayList memberList = dao.memberList();
	 
	// 정보 출력
	System.out.println(memberList);
	
	%>

	<table border="1">
		<tr>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>나이</th>
			<th>성별</th>
			<th>이메일</th>
			<th>회원가입일</th>
		</tr>
		<%
			for(int i=0;i<memberList.size();i++){
				// memberList에서 차례대로 하나씩 꺼내서 MemberBean에 저장함
				MemberBean mb = (MemberBean)memberList.get(i);
		%>
		<tr>
			<td><%=mb.getId() %></td>
			<td><%=mb.getPw()%></td>
			<td><%=mb.getName() %></td>
			<td><%=mb.getAge() %></td>
			<td><%=mb.getGender() %></td>
			<td><%=mb.getEmail() %></td>
			<td><%=mb.getRegdate() %></td>
		</tr>
		<%} %>
	</table>
	
	<br><hr>
	<a href="main.jsp">메인페이지</a>

</body>
</html>