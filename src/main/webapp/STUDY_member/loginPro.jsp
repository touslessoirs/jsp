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
	<h1>loginPro.jsp</h1>
	
	<%
	request.setCharacterEncoding("UTF-8");
	
	%>

	<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>	
	<jsp:setProperty property="*" name="mb"/>
	
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
	// 입력한 id에 맞는 비밀번호 DB에서 조회하기
	String sql = "select pw from itwill_member where id=?";
	System.out.println("SQL 구문 작성 완료!");
	PreparedStatement pstmt = con.prepareStatement(sql);
	// ???
	pstmt.setString(1, mb.getId());
	// 4. SQL문 실행
	ResultSet rs = pstmt.executeQuery();
	System.out.println("SQL 실행 완료!");
	// 5. 데이터 처리
	if(rs.next()){
		// 입력한 pw와 DB에서 조회한 pw 비교하기
		if(mb.getPw().equals(rs.getString("pw"))){
			// pw 일치 = 본인 (로그인 성공)
			// id정보 세션에 저장
			session.setAttribute("id", mb.getId());
			// main.jsp로 이동
			response.sendRedirect("main.jsp");
		} else {
			// pw 불일치 => 비밀번호 오류
			// 페이지 뒤로가기
			response.sendRedirect("loginForm.jsp");
			%>
				<script type="text/javascript">
					alert("비밀번호가 다릅니다!"");
					history.back;
				</script>
			<%
		}
	} else {
		// 입력한 id에 맞는 비밀번호가 DB에 없음
		%>
		<script type="text/javascript">
			alert('회원정보가 없습니다!');
			history.back;
		</script>
	<%
	}
	%>
		
</body>
</html>