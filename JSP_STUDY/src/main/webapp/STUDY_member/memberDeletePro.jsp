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
	<h1>memberDeletePro.jsp</h1>
	<%
	    // 로그인 제어
	    String id = (String)session.getAttribute("id");
	    if(id==null){
	        response.sendRedirect("loginForm.jsp");
	    }
	    
	    // 한글 처리
	    request.setCharacterEncoding("UTF-8");
	    
	    // 전달해준 정보(pw) 저장
	    String pw = request.getParameter("pw");
	    
	    // DB에 정보 조회 후 회원정보가 동일한 경우 삭제

	    // MemberDAO 객체 생성
	    MemberDAO dao = new MemberDAO();
	
	    // 정보 삭제() - memberDelete()
	    int result = dao.memberDelete(id, pw);
	    
		if(result == 1){
			session.invalidate();%>
		    <script type="text/javascript">
		        alert('삭제 성공!');
		        location.href="main.jsp";
		        // 로그인 정보 없음 -> loginForm.jsp 이동
		    </script>
		
		<%} else if (result == 0) {%>
		        <script type="text/javascript">
		           alert('삭제 실패 - 비밀번호 오류');
		           history.back();
		        </script>
	        
	    <%} else {	// result == -1%>
		        <script type="text/javascript">
		           alert('삭제 실패 - 비회원');
		           history.back();
		        </script>
		<%} %>
	
</body>
</html>