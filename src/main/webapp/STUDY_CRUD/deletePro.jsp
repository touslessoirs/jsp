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
	<h1>deletePro.jsp</h1>
	
	<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// 전달정보 저장
	String name = request.getParameter("name");
	String jumin = request.getParameter("jumin");
	
	// 전달정보에 해당하는 회원 정보 삭제하기
	// 디비 연결 정보 (상수)
	final String DRIVER = "com.mysql.cj.jdbc.Driver";
	final String DBURL = "jdbc:mysql://localhost:3306/jspex";
	final String DBID = "root";
	final String DBPW = "1234";
	
	// 1. 드라이버 로드
	Class.forName(DRIVER);
	System.out.println(" 드라이버 로드 성공!");
	
	// 2. DB 연결
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	System.out.println(" DB 연결 성공!");
	System.out.println(" con : "+con);
	
	// 3. SQL 작성 & ptmt 객체 생성
	// DB에서 해당 name을 가진 유저의 주민번호 조회하기
	String sql = "select jumin from itwill_member where name=?";
	System.out.println(" SQL 구문 작성 완료!");
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// ?????
	pstmt.setString(1, name);
	
	// 4. SQL 실행
	ResultSet rs = pstmt.executeQuery();
	
	// 5. 데이터 처리
	if(rs.next()){
		// 주민번호(NN)가 있다 = 회원
		if (jumin.equals(rs.getString("jumin"))){
			// 폼에 입력한 주민번호 = DB에서 조회한 주민번호
			// => 삭제
			// 3. SQL 작성 & pstmt 객체 생성/
			sql = "delete from itwill_member where jumin=?";
			pstmt = con.prepareStatement(sql);
			// ?????
			pstmt.setString(1, jumin);
			// 4. SQL 실행
			pstmt.executeUpdate();
		} else {// 회원이지만, 주민번호 불일치 %>
		<script type="text/javascript">
			alert('주민번호 불일치');
			location.href="deleteForm.jsp";
		</script>
		<%}
	} else {
		// 비회원%>
		<script type="text/javascript">
			alert('해당하는 회원 정보가 없습니다');
			location.href="deleteForm.jsp";
		</script>
	<%
	}
	%>
</body>
</html>