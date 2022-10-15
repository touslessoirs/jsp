<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>cookieForm.jsp</h1>
	
	<%
	// id 쿠키
	// 쿠키 배열로 가져오기
	Cookie[] cookies = request.getCookies();
	
	// 내가 원하는 정보와 일치하는 쿠키 조회
	String value="";
	if(cookies!=null){
		for(int i=0;i<cookies.length;i++){
			if(cookies[i].getName().equals("id")){
				out.println("쿠키값 : "+cookies[i].getValue()+"<br>");
				value = cookies[i].getValue();
			}
		}
	}
	%>
	
	<input type="text" name="id" value=<%=value%>>
	<input type="button" value="쿠키값 생성" onclick="location.href='cookieSet.jsp';">
	<input type="button" value="쿠키값 삭제" onclick="location.href='cookieDel.jsp';">
	<hr>
		
	<%
	// 언어정보 쿠키
	Cookie[] cookies2 = request.getCookies();
	
	String lang="";
	if(cookies2 != null){
		for(int i=0;i<cookies2.length;i++){
			// lang 쿠키 중에서...
			if(cookies2[i].getName().equals("language")){
				System.out.println(cookies2[i].getValue());
				lang = cookies2[i].getValue();
				// kor 쿠키 찾기
				if(cookies2[i].getValue().equals("kor")){
					out.println("언어 : 한글");
				// eng 쿠키 찾기
				} else {
					out.println("language : english");				
				}
			}
		}
	}
	

	// 선택한 언어로 선택 유지하기
	%>
	<form action="cookiePro.jsp" method="post">
		<input type="radio" name="language" value="kor"
		<%if(lang.equals("kor")){
		%>checked	
		<%}%>>한국어
		<input type="radio" name="language" value="eng"
		<%if(lang.equals("eng")){ %>
		checked
		<%} %>>영어<br>
		<input type="submit" value="언어 설정">
	</form>
	
</body>
</html>