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
	<h1>select.jsp</h1>
	
	<table border="1">
	    <tr>
	        <th>idx</th>
	        <th>name</th>
	        <th>gender</th>
	        <th>age</th>
	        <th>jumin</th>
	    </tr>
		
	<%
	// 0. DB 정보 저장
	final String DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspex";
	final String DBID = "root";
	final String DBPW = "1234";

	// 1. 드라이버 로드
	Class.forName(DRIVER);
	System.out.println("드라이버 로드 성공!");

	// 2. 디비 연결
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	System.out.println("디비 연결 성공!");

	// 3. SQL 작성 & pstmt
	String sql = "select * from itwill_member1 order by idx desc";
	System.out.println("SQL 구문 작성 완료!");
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// 4. SQL 실행
	ResultSet rs = pstmt.executeQuery();
	System.out.println("SQL 구문 실행 완료!");
	
	// 5. 데이터 처리
	while(rs.next()){
	    int idx = rs.getInt("idx");
	    String name = rs.getString("name");
	    String gender = rs.getString("gender");
	    int age = rs.getInt("age");
	    String jumin = rs.getString("jumin");
	 
	    out.println("idx : "+idx+"<br>");
	    out.println("name : "+name+"<br>");
	    out.println("gender : "+gender+"<br>");
	    out.println("age : "+age+"<br>");
	    out.println("jumin : "+jumin+"<br>"+"<hr>");
	%>
	
		<tr>
	        <td><%=idx %></td>
	        <td><%=name %></td>
	        <td><%=gender %></td>
	        <td><%=age %></td>
	        <td><%=jumin %></td>
	    </tr>
		
	
	<%}%>
	</table>
	
	
</body>
</html>