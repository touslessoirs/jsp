<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Timestamp"%>
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
	request.setCharacterEncoding("UTF-8");
	%>

	<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>
	<jsp:setProperty property="*" name="mb"/>
	

	<%
	mb.setRegdate(new Timestamp(System.currentTimeMillis()));
	%>
	
	<%=mb.toString() %><hr>
	<%=mb %><br>	
	
	<%
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
	String sql = "insert into itwill_member(id, pw, name, age, gender, email, regdate) values(?, ?, ?, ?, ?, ?, ?)";
	System.out.println("SQL 구문 작성 완료!");
	PreparedStatement pstmt = con.prepareStatement(sql);

	// ???
	pstmt.setString(1, mb.getId());
	pstmt.setString(2, mb.getPw());
	pstmt.setString(3, mb.getName());
	pstmt.setInt(4, mb.getAge());
	pstmt.setString(5, mb.getGender());
	pstmt.setString(6, mb.getEmail());
	pstmt.setTimestamp(7, mb.getRegdate());

	// 4. SQL문 실행
	pstmt.executeUpdate();
	System.out.println("SQL 실행 완료!");
	%>
	
	<!-- <script type="text/javascript">
		alert('회원 가입 완료!');
		location.href="loginPro.jsp";
	</script> -->
	
</body>
</html>