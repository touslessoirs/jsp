<%@page import="com.itwillbs.member.MemberDAO"%>
<%@page import="com.itwillbs.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>memberUpdate.jsp</h1>
	<%
	String id = (String)session.getAttribute("id");
	// 로그인 정보 없음 -> loginForm.jsp로 이동
	if(id==null){
		System.out.println("로그인 정보 없음");
		response.sendRedirect("loginForm.jsp");
	}
	
	// DB에서 수정할 회원의 정보 출력하기
	MemberDAO dao = new MemberDAO();
	
	MemberBean mb = dao.getMember(id);


	if (mb!=null){%>
	<fieldset>
	    <form action="memberUpdatePro.jsp" method="post" name="fr" onsubmit="return check();">
	        아이디 : <input type="text" name="id" value="<%=mb.getId() %>" readonly><br>
	        비밀번호 : <input type="password" name="pw" value="" placeholder="비밀번호를 입력하세요."><br>
	        이름 : <input type="text" name="name" value="<%=mb.getName() %>"><br>
	        나이 : <input type="text" name="age" value="<%=mb.getAge()%>"><br>
	        성별 : <input type="radio" name="gender" value="남"
	        <%if(mb.getGender().equals("남")) {
	        %> checked <%} %>>남
	        	  <input type="radio" name="gender" value="여"
	        	  <%if(mb.getGender().equals("여")) {
	        	  %> checked <%} %>>여<br>
	        이메일 : <input type="text" name="email" value="<%=mb.getEmail() %>" readonly><br>
	        <hr><hr>
	        <input type="submit" value="수정하기">
	    </form>
	</fieldset>
	<%} %>
	
	<script type="text/javascript">
		function check(){
			if(window.document.fr.pw.value == ""){
				alert("비밀번호를 입력하세요");
				document.fr.pw.focus();
				return false;	// submit=false
			}
			alert("check() 끝");
		}
	</script>
</body>
</html>