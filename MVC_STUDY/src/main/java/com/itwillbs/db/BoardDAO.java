package com.itwillbs.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	// java.sql 패키지 import
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	// DB 연결 (커넥션 풀) - getConnection()
	private Connection getConnection() throws Exception{
		// 1+2. DB 연결
		// Context 객체 생성
		// naming - lookup()(jdbc 드라이버 찾기 위함)하기 전 프로젝트(Context)초기화
		Context initCTX = new InitialContext();
		// DB 연동 정보 불러오기
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mvcstudy");
		// DB 연결 정보 불러오기
		con = ds.getConnection();
		
		System.out.println(" [DAO] DB 연결 (커넥션 풀) 성공");
		System.out.println(" [DAO] con : "+con);
		
		return con;
		
	}
	// DB 연결 (커넥션 풀) - getConnection()
	
	// 자원 해제 - closeDB()
	public void closeDB() {
		System.out.println(" [DAO] DB 연결 자원 해제");
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// 자원 해제 - closeDB()
	
	
	// 글 쓰기 - insertBoard()
	public void insertBoard(BoardDTO dto) {
		System.out.println(" [DAO] insertBoard() 호출");
	
		int bno = 0;
		
		try {
			con = getConnection();
			// 글 번호 계산하기
			sql = "select max(bno) from itwill_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bno = rs.getInt(1)+1;
			}
			// DB에 글 정보 반영하기
			sql = "insert into itwill_board(bno, name, pass, subject, content, "
					+ "readcount, re_ref, re_lev, re_seq, date, ip, file) "
					+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);	// 위에서 계산한 bno
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPass());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			
			pstmt.setInt(6, 0);
			pstmt.setInt(7, bno);	// ref = bno
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			
			pstmt.setString(10, dto.getIp());
			pstmt.setString(11, dto.getFile());
			
			pstmt.executeUpdate();
			
			System.out.println(" [DAO] 게시판 글쓰기 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// 글 쓰기 - insertBoard()
	
	
	// 전체 글 개수 - getBoardCount()
	public int getBoardCount() {
		
		int cnt = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from itwill_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			
			System.out.println(" [DAO] 전체 글 개수 : "+cnt+"개");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cnt;
		
	}
	// 전체 글 개수 - getBoardCount()

	
	// 글 목록 조회하기 - getBoardList(startRow, pageSize)
	public List getBoardList(int startRow, int pageSize) {
		
		List boardList = new ArrayList();
		
		try {
			con = getConnection();
			sql = "select * from itwill_board "
					+ "order by re_ref desc, re_seq asc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);	// 시작행 -1
			pstmt.setInt(2, pageSize);		// 한 페이지당 글 개수
			rs = pstmt.executeQuery();
			while(rs.next()) {
				// DB -> DTO
				BoardDTO dto = new BoardDTO();
	            dto.setBno(rs.getInt(1));
	            dto.setName(rs.getString(2));
	            dto.setPass(rs.getString(3));
	            dto.setSubject(rs.getString(4));
	            dto.setContent(rs.getString(5));
	            dto.setReadcount(rs.getInt(6));
	            dto.setRe_ref(rs.getInt(7));
	            dto.setRe_lev(rs.getInt(8));
	            dto.setRe_seq(rs.getInt(9));
	            dto.setDate(rs.getDate(10));
	            dto.setIp(rs.getString(11));
	            dto.setFile(rs.getString(12));
				// DTO -> List
	            boardList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return boardList;
	}
	// 글 목록 조회하기 - getBoardList(startRow, pageSize)
	
	
	
	
}
