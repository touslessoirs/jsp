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
	<h1>updateForm.jsp</h1>
	
	<%
    // 0. DB 정보 저장
	final String DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspex";
	final String DBID = "root";
	final String DBPW = "1234";
    
    // 1. 드라이버 로드
    Class.forName(DRIVER);
    System.out.println("드라이버 로드 성공!");
    
    // 2. DB 연결
    Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
    System.out.println("디비 연결 성공!"+con);
    
    // 3. SQL 작성 & pstmt
    String sql = "select * from itwill_member where idx=9";
    System.out.println("SQL 구문 작성 완료!");
    PreparedStatement pstmt = con.prepareStatement(sql);
    
    // 4. SQL 실행
    ResultSet rs = pstmt.executeQuery();
	
    String name="";
    int age=0;
    
    if(rs.next()){
        name = rs.getString("name");
        age = rs.getInt("age");
    }
    
    %>
    
</body>
	<form action="updatePro.jsp" method="post">
		<input type="hidden" name="idx" value="9"><br>
		이름 : <input type="text" name="name" value="<%=name %>"> <br>
		나이 : <input type="text" name="age" value="<%=age %>"> <br>
	
		<input type="submit" value="디비에 수정하기">
	</form>

</html>