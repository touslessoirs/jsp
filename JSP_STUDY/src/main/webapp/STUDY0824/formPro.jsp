<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>formPro.jsp</h1>

	<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String tel = request.getParameter("tel");
	
	String pw = request.getParameter("pw");
	String gender = request.getParameter("gender");
// 	String hobby1 = request.getParameter("hobby");
// 	String hobby2 = request.getParameter("hobby");
// 	String hobby3 = request.getParameter("hobby");
	
	String[] hobbys = request.getParameterValues("hobby");
	%>
	
	이름 : <%=name %><br>
	나이 : <%=age %><br>
	전화번호 : <%=tel %><br>
	성별 : <%=gender %><br>
<%-- 	취미1 : <%=hobbys[0] %><br> --%>
<%-- 	취미2 : <%=hobbys[1] %><br> --%>
<%-- 	취미3 : <%=hobbys[2] %><br> --%>
	
	<%
	
	if(hobbys!=null){/*
		for(int i=0;i<hobbys.length;i++){
		out.println("<h3>취미"+(i+1)+" : "+hobbys[i]);
		}
		
	}*/
		for(int i=0;i<hobbys.length;i++){
		%>
			<h3>취미<%=i+1%> : <%=hobbys[i]%></h3>
		<%
		}
	}
	%>
	
	<%
	String num=request.getParameter("num");
	%>
	강의실 : <%=num %> 강의장
	 
</body>
</html>