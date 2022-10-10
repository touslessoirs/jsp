package com.itwillbs.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
		final String DBURL = "jdbc:mysql://localhost:3306/jspex";
		final String DBID = "root";
		final String DBPW = "1234";
		
		// 1. 드라이버 로드
		Class.forName(DRIVER);
		System.out.println(" 드라이버 로드 성공");
		
		// 2. DB 연결
		con = DriverManager.getConnection(DBURL, DBID, DBPW);
	    System.out.println(" DAO : DB 연결 성공");
	    System.out.println(" DAO : "+con);
	    
	    return con;
	}
	// DB 연결 메서드 - getConnection()
	
	
	// 자원 해제 메서드 - closeDB()
	public void closeDB() {
		System.out.println(" DAO : DB 연결자원 해제");
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	// 자원 해제 메서드 - closeDB()
	
	
	// 글쓰기 메서드 - insertBoard()
	public void insertBoard(BoardDTO dto) {
		System.out.println(" DAO : insertBoard() 호출");
	    int bno = 0;	// 글 번호 저장할 변수
	    
	    try {
	    	// 1+2. DB 연결
			con = getConnection();
		    // 3. SQL 작성(글 번호 계산) & pstmt
		    sql = "select max(bno) from itwill_board";
		    pstmt = con.prepareStatement(sql);
		    // 4. SQL 실행
		    rs = pstmt.executeQuery();
		    
		    // 5. 데이터 처리
		    if(rs.next()) {
//		    	bno = rs.getInt(bno)+1;
//		    	bno = rs.getInt("max(bno)")+1;	// getInt()는 max(bno)의 가장 높은 값을 int형으로 가져옴
		    	bno = rs.getInt(1)+1;			// 숫자 1 = getInt()의 첫 번째 인덱스
		    }
		    
		    System.out.println(" DAO : 글번호 = "+bno);
		    
		    	// 3. SQL 작성(insert) & pstmt
		    	sql = "insert into itwill_board (bno, name, pass, subject, content, "
		    			+ " readcount, re_ref, re_lev, re_seq, date, ip, file) "
		    			+ " values (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
		        pstmt = con.prepareStatement(sql);
	            // ???
	            pstmt.setInt(1, bno);
	            pstmt.setString(2, dto.getName());
	            pstmt.setString(3, dto.getPass());
	            pstmt.setString(4, dto.getSubject());
	            pstmt.setString(5, dto.getContent());
	            
	            pstmt.setInt(6, 0);
	            pstmt.setInt(7, bno);
	            pstmt.setInt(8, 0);
	            pstmt.setInt(9, 0);
	            
	            pstmt.setString(10, dto.getIp());
	            pstmt.setString(11, dto.getFile());
		    	
		    	// 4. SQL 실행
	            pstmt.executeUpdate();
	            
	            System.out.println(" DAO : 게시판 글쓰기 완료");
	            
	    } catch (Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	closeDB();
	    }
	    
	}
	// 글쓰기 메서드 - insertBoard()
	
	
	// 글 정보 가져오기 메서드 - getBoardList()
	public ArrayList getBoardList() {
		System.out.println(" DAO : getBoardList() 호출");
		
		// 글 목록 정보를 저장하는 배열
		ArrayList boardList = new ArrayList();
		
		try {
			con = getConnection();
	        // 3. SQL 작성(select) & pstmt
	        sql = "select * from itwill_board";
	        pstmt = con.prepareStatement(sql);
	        // 4. SQL 실행
	        rs = pstmt.executeQuery();
	        
	        // 5. 데이터 처리 (DB->DTO->List)
			while(rs.next()) {
				// DB 정보 -> DTO에 저장
				BoardDTO dto = new BoardDTO();
	            dto.setBno(rs.getInt("bno"));
	            dto.setName(rs.getString("name"));
	            dto.setPass(rs.getString("pass"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setContent(rs.getString("content"));
	            dto.setReadcount(rs.getInt("readcount"));
	            dto.setRe_ref(rs.getInt("re_ref"));
	            dto.setRe_lev(rs.getInt("re_lev"));
	            dto.setRe_seq(rs.getInt("re_seq"));
	            dto.setDate(rs.getDate("date"));
	            dto.setIp(rs.getString("ip"));
	            dto.setFile(rs.getString("file"));
	            
	            // DTO -> ArrayList에 저장
	            boardList.add(dto);
			}
			
			System.out.println(" DAO : 게시판 목록 조회 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return boardList;
		
	}
	// 글 정보 가져오기 메서드 - getBoardList()

	
	// 글 정보 가져오기 메서드 - getBoardList(startRow, pageSize)
	public ArrayList getBoardList(int startRow, int pageSize) {
		System.out.println(" DAO : getBoardList() 호출");
		
		ArrayList boardList = new ArrayList();
		
		try {
			con = getConnection();
			// 3. SQL 작성(select) & pstmt
			sql = "select * from itwill_board "
					+ "order by re_ref desc, re_seq asc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			// ?????
			pstmt.setInt(1, startRow-1);	// row는 0부터 시작
			pstmt.setInt(2, pageSize);
			// 4. SQL 실행
			rs = pstmt.executeQuery();
	        // 5. 데이터 처리 (DB->DTO->List)
			while(rs.next()) {
				// DB 정보 -> DTO에 저장
				BoardDTO dto = new BoardDTO();
	            dto.setBno(rs.getInt("bno"));
	            dto.setName(rs.getString("name"));
	            dto.setPass(rs.getString("pass"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setContent(rs.getString("content"));
	            dto.setReadcount(rs.getInt("readcount"));
	            dto.setRe_ref(rs.getInt("re_ref"));
	            dto.setRe_lev(rs.getInt("re_lev"));
	            dto.setRe_seq(rs.getInt("re_seq"));
	            dto.setDate(rs.getDate("date"));
	            dto.setIp(rs.getString("ip"));
	            dto.setFile(rs.getString("file"));
	            
	            // DTO -> ArrayList에 저장
	            boardList.add(dto);
			}
			
			System.out.println(" DAO : 게시판 목록 조회 성공");
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return boardList;
	}
	
	
	// 글 정보 가져오기 메서드 - getBoardList(startRow, pageSize)
	
	
	// 전체 글 개수 - getBoardCount()
	public int getBoardCount() {
		int cnt = 0;
		
		try {
			con = getConnection();
			// 3. SQL 작성 & pstmt 객체
			sql = "select count(*) from itwill_board";
			pstmt = con.prepareStatement(sql);
			// 4. SQL 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if(rs.next()) {
//				cnt = rs.getInt(count(*));
				cnt = rs.getInt(1);
			}
		
			 System.out.println(" DAO : 전체 글의 개수 "+cnt+"개");
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cnt;
	}
	// 전체 글 개수 - getBoardCount()
	
	
	// 조회수 1 증가 - updateReadcount(bno)
	public void updateReadcount(int bno) {
		try {
			con = getConnection();
			// 3. SQL 작성(update) & pstmt 객체
			sql = "update itwill_board set readcount=readcount+1 where bno=?";
	        pstmt = con.prepareStatement(sql);
	        // ?????
	        pstmt.setInt(1, bno);
	        // 4. SQL 실행
	        pstmt.executeUpdate();
	        
	        System.out.println(" DAO : 조회수 1 증가 완료");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	closeDB();
	    }
		
	}
	// 조회수 1 증가 - updateReadcount(bno)
	
	
	// 게시글 정보 조회 - getBoard(bno)
	public BoardDTO getBoard(int bno) {
		BoardDTO dto = null;
		
		try {
			con = getConnection();
			// 3. SQL 작성(select) & pstmt 객체
			sql = "select * from itwill_board where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			// 4. SQL 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if(rs.next()) {
				dto = new BoardDTO();	// true일 때 객체 생성
	            dto.setBno(rs.getInt("bno"));
	            dto.setName(rs.getString("name"));
	            dto.setPass(rs.getString("pass"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setContent(rs.getString("content"));
	            dto.setReadcount(rs.getInt("readcount"));
	            dto.setRe_ref(rs.getInt("re_ref"));
	            dto.setRe_lev(rs.getInt("re_lev"));
	            dto.setRe_seq(rs.getInt("re_seq"));
	            dto.setDate(rs.getDate("date"));
	            dto.setIp(rs.getString("ip"));
	            dto.setFile(rs.getString("file"));
	        }

	        System.out.println(" DAO : 게시글 조회 완료");
	 
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeDB();
	    }
	 
	    return dto;
	    
	}
	// 게시글 정보 조회 - getBoard(bno)
	
	
	// 게시글 수정 - updateBoard(DTO)
	public int updateBoard(BoardDTO dto) {
		
		int result = -1;
		
		try {
			con = getConnection();
			// SQL 작성(select) & pstmt 객체
			sql = "select pass from itwill_board where bno=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, dto.getBno());	// bno (X)
	        // 4. SQL 실행
	        rs = pstmt.executeQuery();
			// 5. 데이터 처리 (비밀번호 확인)
	        if(rs.next()) {
	        	if(dto.getPass().equals(rs.getString("pass"))) {
	        		// 비밀번호 일치
	        		// 3. SQL 작성(update) & pstmt 객체
	        		sql = "update itwill_board set subject=?, name=?, content=? where bno=?";
	                pstmt = con.prepareStatement(sql);
	                // ?????
	                pstmt.setString(1, dto.getSubject());
	                pstmt.setString(2, dto.getName());
	                pstmt.setString(3, dto.getContent());
	                pstmt.setInt(4, dto.getBno());
	                // 4. SQL 실행
	                result = pstmt.executeUpdate();
	        	} else {
	        	// 비밀번호 오류
	        	result = 0;
	        	}
	        } else {
	        	// 게시판 글 없음
	        	result = -1;
	        }
	        
	        System.out.println(" DAO : 게시판 정보 수정완료 ("+result+")");
	        
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
		
	}
	// 게시글 수정 - updateBoard(DTO)

	
	// 게시글 삭제 - deleteBoard(bno, pass)
	public int deleteBoard(int bno, String pass) {
		
		int result = -1;
		
		try {
			con = getConnection();
			// 3. SQL 작성(select) & pstmt 객체
			sql = "select pass from itwill_board where bno=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, bno);
	        // 4. SQL 실행
	        rs = pstmt.executeQuery();
	        // 5. 데이터 처리 (비밀번호 확인)
	        if(rs.next()) {
	        	if(pass.equals(rs.getString("pass"))) {
	        		// 비밀번호 일치
	        		// 3. SQL 작성(delete) & pstmt 객체
	        		sql = "delete from itwill_board where bno=?";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setInt(1, bno);
	                // 4. SQL 실행
	                result = pstmt.executeUpdate();
	        	} else {
		        	// 비밀번호 오류
		        	result = 0;
	        	}
	        } else {
	        	// 게시판 글 없음
	        	result = -1;
	        }
	        
	        System.out.println(" DAO : 게시판 정보 삭제완료 ("+result+")");
	        
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;
	}
	// 게시글 삭제 - deleteBoard(bno, pass)
	
}
