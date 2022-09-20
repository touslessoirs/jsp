<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>updatePro.jsp</h1>
	
	<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// 전달 정보 저장
	int idx = Integer.parseInt(request.getParameter("idx"));
	int age = Integer.parseInt(request.getParameter("age"));
	String name = request.getParameter("name");
	
	// 디비 연결 정보 (상수)
	final String DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspex";
	final String DBID = "root";
	final String DBPW = "1234";
	
	// 1. 드라이버 로드
	Class.forName(DRIVER);
	System.out.println(" 드라이버 로드 성공!");
	
	// 2. 디비 연결
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	System.out.println(" DB 연결 성공!");
	System.out.println(" con : "+con);			
	
	// 3. SQL 작성 & pstmt
	// 먼저 해당 idx의 유저가 존재하는지를 판단
	String sql = "select * from itwill_member where idx=?";
	System.out.println(" SQL 구문 작성 완료!");
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// ?????
	pstmt.setInt(1, idx);
	
	// 4. SQL 실행
	ResultSet rs = pstmt.executeQuery();
	System.out.println(" SQL 구문 실행 완료!");
	
	// 5. 데이터 실행
	if(rs.next()){
		// 회원
		// 4. SQL 작성 & pstmt
		sql = "update itwill_member set name=?, age=? where idx=?";
		pstmt = con.prepareStatement(sql);
		// ?????
		pstmt.setString(1, name);
		pstmt.setInt(2, age);
		pstmt.setInt(3, idx);
		// 5. SQL 실행
		pstmt.executeUpdate();
	} else {
		// 비회원
	}
	
	%>
	
</body>
</html>