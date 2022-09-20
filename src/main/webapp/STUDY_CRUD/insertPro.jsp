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
	<h1>insertPro.jsp</h1>
	
	<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// 전달된 정보 저장하기
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	int age = Integer.parseInt(request.getParameter("age"));
	String jumin = request.getParameter("jumin");
	
	// 디비 연결 정보 (상수)
	final String DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspex";
	final String DBID = "root";
	final String DBPW = "1234";
	
	// 1. 드라이버 로드
	Class.forName(DRIVER);
	System.out.println("드라이버 로드 성공!");
	
	// 2. DB 연결
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	System.out.println("디비 연결 성공!");
	System.out.println(" con : "+con);
	
	// 3. SQL 작성 & ptmt 객체 생성
	String sql = "insert into itwill_member (name, gender, age, jumin) values (?, ?, ?, ?)";
	System.out.println("SQL 구문 작성 완료!");
	PreparedStatement pstmt = con.prepareStatement(sql);
	System.out.println("pstmt 객체 생성 완료!");
	
	// ????
	pstmt.setString(1, name);
	pstmt.setString(2, gender);
	pstmt.setInt(3, age);
	pstmt.setString(4, jumin);
	
	// 4. SQL 실행
	pstmt.executeUpdate();
	System.out.println("SQL 구문 실행 완료!");
	
	// select.jsp 페이지로 이동
	response.sendRedirect("select.jsp");
	
	%>
	
	
</body>
</html>