<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>dbConnection.jsp</h1>

	<%
	// DB연결정보 저장
	final String DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspex";
	final String DBID = "root";
	final String DBPW = "1234";
	
	// 1. 드라이버 로드
	Class.forName(DRIVER);
	System.out.println("드라이버 로드 성공!");
	
	// 2. DB 연결하기
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	System.out.println("디비 연결 성공!");
	System.out.println(" con : "+con);
	
	// 3. SQL 작성 & stmt 객체 생성
	String sql = "insert into itwill_member (name, gender, age, jumin) values ('ITWILL', 'M', 11, '900101-1231231')";
	System.out.println("SQL 구문 작성 완료!");
	
	// 4. SQL문 실행
// 	Statement stmt = con.createStatement();
// 	System.out.println("stmt 객체 생성 완료!");
// 	stmt.executeUpdate(sql);
	PreparedStatement pstmt = con.prepareStatement(sql);
	System.out.println("pstmt 객체 생성 완료");
	pstmt.executeUpdate(sql);
	System.out.println("SQL 실행 완료!");
	
	
	
	%>

</body>
</html>