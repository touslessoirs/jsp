package com.itwillbs.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {
	// DAO(Data Access Object) : 데이터(DB) 처리객체
	// => DB에 관한 모든 동작을 수행

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
	
	// DB 연결해주는 메서드 구현 (1, 2단계 동작을 한번에)
	private Connection getConnection() throws Exception {
		
		// DB연결정보(상수)
		final String DRIVER = "com.mysql.cj.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		final String DBID = "root";
		final String DBPW = "1234";
		// 1. 드라이버 로드
		Class.forName(DRIVER);
	    System.out.println("드라이버 로드 성공!");
	    // 2. 디비 연결 (Connection 선언은 위에서 함)
	    con = DriverManager.getConnection(DBURL, DBID, DBPW);
	    System.out.println("DAO : 디비 연결 성공!");
	    System.out.println("DAO : "+con);
	    
		return con;
	}
	
	// 정보 조회 메서드()
	
	/**
	 * JavaDoc 주석 : 문법에 대한 설명을 작성하는 주석문
	 * 
	 * 이 메서드는 로그인 정보 ID를 입력받아서
	 * id에 해당하는 정보 모두를 조회 후 MemberBean이라는 객체에 담아서
	 * 리턴하는 메서드입니다. 
	 */
	
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
	 	System.out.println("정보 조회 완료! mb 리턴");
		return mb;
	}
	// 정보 조회 메서드() 끝
	
	
	// 정보 수정 메서드()
	public int updateMember(MemberBean umb){
		// [1] 정상 수정, [0] 비밀번호 오류, [-1] 회원정보 없음
		
		// result 변수를 선언한 후*1
		// 1로 초기화(수정됐다는 상황)를 default로 두기보다는 잘못된 상황을 default로!
		int result = -1;
		
		try {
			// 1. 드라이버 로드 + 2. 디비 연결
			// 전역변수이므로 getConnection();만으로도 실행가능 (con에 저장됐다는 걸 확인하기위함)
			con = getConnection();

		    // 3. SQL 작성(select) & pstmt
			// 본인여부 체크
			sql = "select pw from itwill_member where id=?";
			pstmt = con.prepareStatement(sql);
			// ???
			// id값 umb에서 가져오기
			pstmt.setString(1, umb.getId());
		    // 4. SQL문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if(rs.next()) {
				// 비밀번호가 있다 (회원)
				if(umb.getPw().equals(rs.getString("pw"))) {
					// 본인 -> 정보 수정
					// 3. SQL 작성(update - 이름, 나이, 성별을 수정하는 구문) & pstmt
					sql = "update itwill_member set name=?, age=? gender=? where id=?";
			    	pstmt = con.prepareStatement(sql);
			    	
			    	pstmt.setString(1, umb.getName());
			    	pstmt.setInt(2, umb.getAge());
			    	pstmt.setString(3, umb.getGender());
			    	pstmt.setString(4, umb.getGender());
			    	// 4. sql 실행
					pstmt.executeUpdate();
					
					// 수정 후 1이라는 데이터 값 주기
					result = 1;
				} else {
					// 비밀번호 오류
					result = 0;
				}
			} else {
				// 비밀번호가 없다 (비회원) => pw는 NN옵션이 걸려있으므로 pw값이 없다=비회원
				// return -1; (X) => updateMember() 하나의 메서드 안에서 return은 하나만 사용하기!
				result = -1;
			}
			
			System.out.println(" DAO : 정보 수정완료 ("+result+")");
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return result;	// result 리턴*1
	}
	
	// 정보 수정 메서드() 끝
	
	
	// 정보 삭제 메서드()
	public int memberDelete(String id, String pw){
		// result 변수 선언
		int result = -1;
		try {		
			// 1. 드라이버 로드 + 2. 디비 연결
			con = getConnection();
			// 3. SQL 작성(select) & pstmt
			sql = "select pw from itwill_member where id=?";
			pstmt = con.prepareStatement(sql);
			// ???
			pstmt.setString(1, id);
			// 4. SQL문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if(rs.next()) {
				if(pw.equals(rs.getString("pw"))) {
					// 3. SQL 작성(delete) & pstmt
					sql = "delete from itwill_member where id=?";
					pstmt = con.prepareStatement(sql);
					// ???
					pstmt.setString(1, id);
					// 4. sql 실행
					// result = 1;
					result = pstmt.executeUpdate();	//int 타입의 변수에 뭔가를 넣었으므로 int 리턴
					// executeUpdate() : sql구문 (insert,update,delete)을
					// 실행했을 때 테이블에 영향을 준 row 수를 리턴
				} else {
					result = 0;
				}
			} else {
				result = -1;
			}
			
			System.out.println(" DAO : 회원정보 삭제 완료("+result+")");
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return result;
	}
	// 정보 삭제 메서드() 끝

	// 회원정보 조회(all) 메서드()
	public ArrayList memberList(){
		// 회원정보를 저장할 (가변길이) 배열
		ArrayList mList = new ArrayList();
		
		
		try {
			// 1+2. DB 연결
			con = getConnection();
			// 3. SQL 작성(select) & pstmt
			// sql = "select * from itwill_member";
			// 관리자(admin) 정보를 제외한 정보 조회하기
			sql = "select * from itwill_member where id!=?";
			pstmt = con.prepareStatement(sql);
			// ????
			pstmt.setString(1, "admin");
			// 4. SQL문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			while(rs.next()) {
				// 데이터 있을 때
				// DB(테이블) 정보 객체에 저장해서 가져오기
				
				// DB(테이블) 정보 -> MemberBean
				MemberBean mb = new MemberBean();
				
				mb.setAge(rs.getInt("age"));
				mb.setEmail(rs.getString("email"));
				mb.setGender(rs.getString("Gender"));
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setPw(rs.getString("pw"));
				mb.setRegdate(rs.getTimestamp("regdate"));
				
				// MemberBean -> ArrayList
				mList.add(mb);
			}	// if문 끝
			System.out.println("DAO : 회원목록 조회 성공!");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	return mList;
		
	}
	// 회원정보 조회(all) 메서드() 끝
	
	
}	// class
