<%@page import="com.itwillbs.member.MemberBean"%>
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
	<h1>memberInfo.jsp</h1>
	<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	if(id==null){
		// 로그인 정보 없으면 -> login페이지로 돌려보내기
		response.sendRedirect("loginForm.jsp");
	}
	
	// 로그인 정보 있으면 -> 회원 정보 조회 -> DB에서 필요한 정보 가져오기
	// DB에서 필요한 정보 가져오기
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
	String sql = "select * from itwill_member where id=?";
	System.out.println("SQL 구문 작성 완료!");   
	PreparedStatement pstmt = con.prepareStatement(sql);
	// ???
	pstmt.setString(1, id);
	// 4. SQL문 실행
	ResultSet rs = pstmt.executeQuery();
	System.out.println("SQL 실행 완료!");
	// 5. 데이터 처리
	// 해당 회원에 해당하는 회원정보 MemberBean 객체에 저장
	// MemberBean mb = new MemberBean();
	MemberBean mb = null;		// 미리 객체를 생성하지 않고
	if(rs.next()){				// if문을 거쳐서 데이터가 있을 때만 객체를 생성하므로
		mb = new MemberBean();	// 메모리의 효율적인 사용이 가능해진다
	    mb.setId(rs.getString("id"));
	    mb.setPw(rs.getString("pw"));
	    mb.setName(rs.getString("Name"));
	    mb.setAge(rs.getInt("age"));
	    mb.setGender(rs.getString("gender"));
	    mb.setEmail(rs.getString("email"));
	    mb.setRegdate(rs.getTimestamp("regdate"));
	}
	
	%>
	
	<%=mb.toString() %><hr>
	
	아이디 : <%=mb.getId() %><br>
	비밀번호 : <%=mb.getPw() %><br>
	이름 : <%=mb.getName() %><br>
	나이 : <%=mb.getAge() %><br>
	성별 : <%=mb.getGender() %><br>
	이메일 : <%=mb.getEmail() %><br>
	회원가입일 : <%=mb.getRegdate() %><br>
	
	
	<hr>
	<a href="main.jsp">메인페이지</a>
	
</body>
</html>