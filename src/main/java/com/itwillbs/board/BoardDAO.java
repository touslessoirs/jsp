package com.itwillbs.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardDAO {

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	public BoardDAO() {
		System.out.println(" DAO : BoardDAO() 객체 생성");
		System.out.println(" DAO : itwill_board 테이블 접근준비 완료");
	}
	
	
	// DB 연결 메서드 - getConnection()
	private Connection getConnection() throws Exception {
		// DB 연결 정보
		final String DRIVER = "com.mysql.cj.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		final String DBID = "root";
		final String DBPW = "1234";
		
		// 1. 드라이버 로드
		Class.forName("DRIVER");
		System.out.println(" 드라이버 로드 성공");
		
		// 2. DB 연결
		con = DriverManager.getConnection(DBURL, DBID, DBPW);
	    System.out.println(" DAO : DB 연결 성공!");
	    System.out.println(" DAO : "+con);
	    
	    return con;
	}
	// DB 연결 메서드 - getConnection()
	
	
	// 글쓰기 메서드 - insertBoard()
	public void insertBoard(BoardDTO dto) {
		System.out.println(" DAO : insertBoard() 호출");
	    int bno = 0;	// 글 번호 저장할 변수
	    
	    try {
	    	// 1+2. DB 연결
			con = getConnection();
		    // 3. SQL 작성(글 번호 계산) & pstmt
		    sql = "select max(bno) from itwill_member";
		    pstmt = con.prepareStatement(sql);
		    // 4. SQL 실행
		    pstmt.executeQuery();
		    // 5. 데이터 처리
		    if(rs.next()) {
		    	bno = rs.getInt(1)+1;
		    }
		    
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    
	}
	// 글쓰기 메서드 - insertBoard()
	
	
}
