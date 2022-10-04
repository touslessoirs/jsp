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
	<h1>memberUpdatePro.jsp</h1>

	<%
	String id = (String)session.getAttribute("id");
	if(id==null){
		response.sendRedirect("loginForm.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
	
	// 전달 정보 (수정할 데이터) 저장
	%>
	<jsp:useBean id="umb" class="com.itwillbs.member.MemberBean"/>
	<jsp:setProperty property="*" name="umb"/>
	
	<%
	MemberDAO dao = new MemberDAO();
	
	int result = dao.updateMember(umb);
	
	if(result == 1){%>
	    <script type="text/javascript">
	        alert('수정 성공!');
	        location.href="main.jsp";
	    </script>
	
	<%} else if (result == 0) {%>
        <script type="text/javascript">
           alert('수정 실패 - 비밀번호 오류');
           history.back();
        </script>
        
    <%} else {	// result == -1%>
        <script type="text/javascript">
           alert('수정 실패 - 비회원');
           history.back();
        </script>
	<%} %>
	
</body>
</html>