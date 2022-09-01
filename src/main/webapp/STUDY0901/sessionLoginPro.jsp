<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>sessionLoginPro.jsp</h1>
	<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	// id=admin, pw=1234일 때 본인 로그인
	// => sessionMain.jsp 이동하기
	// => 로그인 성공한 ID 정보를 유지하기
	
	// 로그인 실패 (비밀번호 오류, 비회원)
	
	String userID = "admin";
	String userPW = "1234";
	
	if(userID.equals(id)){
		if(userPW.equals(pw)){
			// 로그인 성공
			out.println("본인 로그인");
			session.setAttribute("id", id);
			response.sendRedirect("sessionMain.jsp");
			
		} else {
			// 비밀번호 오류
			out.println("비밀번호 오류");
		}
	} else {
		// 비회원
		out.println("비회원");
	}
	
	%>
</body>
</html>