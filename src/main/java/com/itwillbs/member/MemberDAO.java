package com.itwillbs.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {

	// 공통으로 사용할 (전역)변수 선언
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// 생성자
	public MemberDAO() {
		System.out.println(" DAO : 생성자 호출(객체 생성)");
		System.out.println(" DAO : DB연결에 대한 모든 처리 준비 완료");
	}
	
	// DB 연결 메서드 - getConnection()
	private Connection getConnection() throws Exception {
		
		// DB연결정보(상수)
		final String DRIVER = "com.mysql.cj.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspex";
		final String DBID = "root";
		final String DBPW = "1234";
		// 1. 드라이버 로드
		Class.forName(DRIVER);
	    System.out.println(" 드라이버 로드 성공!");
	    // 2. DB연결
	    con = DriverManager.getConnection(DBURL, DBID, DBPW);
	    System.out.println(" DAO : DB 연결 성공");
	    System.out.println(" con : "+con);
	    return con;
	}
	// DB 연결 메서드 - getConnection()
	
	/**
	 * JavaDoc 주석 : 문법에 대한 설명을 작성하는 주석문
	 * 
	 * 이 메서드는 로그인 정보 ID를 입력받아서
	 * id에 해당하는 정보 모두를 조회 후 MemberBean이라는 객체에 담아서
	 * 리턴하는 메서드입니다. 
	 */
	
	/*
	public MemberBean getMember(String id) throws Exception {
		// DB에서 정보 조회(select) -> MemberBean 객체 만들기
		// DB에서 필요한 정보 가져오기
		// DB연결정보(상수)
		final String DRIVER = "com.mysql.cj.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		final String DBID = "root";
		final String DBPW = "1234";
		// 1. 드라이버 로드
		Class.forName(DRIVER);
	    // 2. 디비 연결
	    Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
		// 3. SQL 작성 & pstmt
	    String sql = "select * from itwill_member where id=?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		//???
		pstmt.setString(1, id);
		// 4. SQL문 실행
		ResultSet rs = pstmt.executeQuery();
		// 5. 데이터 처리
		// MemberBean mb = new MemberBean();
		MemberBean mb = null;
	 	if(rs.next()){
			// 회원정보 저장 (MemberBean)
			// rs(DB정보) -> MemberBean
	 		mb = new MemberBean();
	 		
	 		mb.setAge(rs.getInt("age"));
	 		mb.setEmail(rs.getString("email"));
	 		mb.setGender(rs.getString("gender"));
	 		mb.setId(rs.getString("id"));
	 		mb.setName(rs.getString("Name"));
	 		mb.setPw(rs.getString("pw"));
	 		mb.setRegdate(rs.getTimestamp("regdate"));
	 	}
	 	
	 	// MemberBean 객체 생성 완료
	 	System.out.println(" 정보 조회 완료! mb 리턴");
		return mb;
	}*/
	
	// 정보 조회 메서드 - getMember()
	public MemberBean getMember(String id) throws Exception {

		MemberBean mb = null;
		
		// 1. 드라이버 로드 + 2. DB 연결
		try {
			con = getConnection();
			// 3. SQL 작성 & pstmt
			sql = "select * from itwill_member where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4. SQL문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if(rs.next()) {
				// 입력한 id에 해당하는 정보가 있으면 : mb 객체 생성 후 저장
		        mb = new MemberBean();
		        mb.setAge(rs.getInt("age"));
		        mb.setEmail(rs.getString("email"));
		        mb.setGender(rs.getString("gender"));
		        mb.setId(rs.getString("id"));
		        mb.setName(rs.getString("Name"));
		        mb.setPw(rs.getString("pw"));
		        mb.setRegdate(rs.getTimestamp("regdate"));
		    }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 생성된 mb 객체 리턴
		System.out.println(" 정보 조회 완료! mb 리턴");
		return mb;
	}
	// 정보 조회 메서드 - getMember()
	
	// 정보 수정 메서드 - updateMember()
	public int updateMember(MemberBean umb) {
		int result = -1;	// 잘못된 상황(-1)을 default로 설정
		try {
			// 1. 드라이버 로드 + 2. DB 연결
			con = getConnection();
			// 비밀번호 일치 확인
			// 3. SQL 작성(select) & pstmt
			sql = "select pw from itwill_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, umb.getId());
			// 4. SQl문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if(rs.next()) {
				// 입력한 id에 해당하는 pw 있음 => 회원
				if (umb.getPw().equals(rs.getString("pw"))) {
					// 입력한 pw = DB의 pw => 본인 => 정보 수정
					// 3. SQL 작성(update) & pstmt
					sql = "update itwill_member set name=?, age=?, gender=? where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, umb.getName());
					pstmt.setInt(2, umb.getAge());
					pstmt.setString(3, umb.getGender());
					pstmt.setString(4, umb.getId());
					
//					pstmt.executeUpdate();
					result = pstmt.executeUpdate();
				}
				// 입력한 pw != DB의 pw => 비밀번호 불일치
				else {
					result = 0;
				}
			}
			// 입력한 id에 해당하는 pw 없음 => 비회원
			else {
				result = -1;
			}
			System.out.println(" DAO : 정보 수정 완료 ["+result+"]");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	// 정보 수정 메서드 - updateMember()
	
	// 정보 삭제 메서드()
    // id는 세션에서, pw는 getParameter에서 꺼내옴
	public int memberDelete(String id, String pw) {
	    // result 변수 선언
	    int result = -1;
	    try {		
	        // 1. 드라이버 로드 + 2. 디비 연결
	        con = getConnection();
	        // 3. SQL 작성(select) & pstmt
	        // 비밀번호 일치 확인
	        sql = "select pw from itwill_member where id=?";
	        pstmt = con.prepareStatement(sql);
	        // ???
	        pstmt.setString(1, id);
	        // 4. SQL문 실행
	        rs = pstmt.executeQuery();
	        // 5. 데이터 처리
	        if(rs.next()) {
	            if(pw.equals(rs.getString("pw"))) {
					// 본인 => 정보 삭제
	                // 3. SQL 작성(delete) & pstmt
	                sql = "delete from itwill_member where id=?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setString(1, id);
	                // 4. sql 실행
	                // result = 1;
	                result = pstmt.executeUpdate();
	                // executeUpdate() : sql구문을 실행했을 때 테이블에 영향을 준 row 수(int)를 리턴
	            } else {
	                result = 0;
	            }
	        } else {
	            result = -1;
	        }

	        System.out.println(" DAO : 회원정보 삭제 완료["+result+"]");

	    } catch (Exception e) {
	        e.printStackTrace();
	    }		

	    return result;
	}
	// 정보 삭제 메서드()
	
}	// MemberDAO 클래스 끝
