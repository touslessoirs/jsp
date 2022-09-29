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
//	private Connection getConnection() throws Exception {
//
//	}
	// DB 연결 메서드 - getConnection()
	
}	// MemberDAO 클래스 끝
