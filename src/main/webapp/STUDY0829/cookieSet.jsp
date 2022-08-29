<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>cookieSet.jsp</h1>
    <h1> 서버 </h1>
    <h2> 쿠키값 생성 </h2>
 
    <%
    System.out.println(" 서버 : 클라이언트 요청 처리중... ");
    System.out.println(" 서버 : 클라이언트 요청 처리중... ");
    System.out.println(" 서버 : 클라이언트 요청 처리중... ");
    
    // 1. 쿠키값 생성 - 서블릿 API 사용
    Cookie cookie = new Cookie("id", "itwill");
    System.out.println(" 서버 : 쿠키 정보 생성 (메모리 로드, HDD 저장 X)");

	// 2. 쿠키 사용기간(유효기간 설정)
	cookie.setMaxAge(600);
	System.out.println(" 서버 : 쿠키 유효기간 설정 ");
	
	// 3. 쿠키정보를 (클라이언트에게) 전달
	response.addCookie(cookie);
	System.out.println(" 서버 : 쿠키 정보를 클라이언트로 전달 ");
	
	%>
	
	<script type="text/javascript">
	    alert("서버 처리완료, 클라이언트 정보");
	    alert("쿠키 전달");
	    // location href="cookieTest.jsp";
	</script>
	
	
</body>
</html>