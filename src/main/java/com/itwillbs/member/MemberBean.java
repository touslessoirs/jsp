package com.itwillbs.member;

import java.sql.Timestamp;

public class MemberBean {
	// itwill_member 테이블의 정보를 저장하는 객체
	
	// 변수 선언
	private String id;
	private String pw;
	private String name;
	private int age;
	private String gender;
	private String email;
	private Timestamp regdate;

	// get(), set() 구현
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	// Alt + Shift + S + S
	// 멤버빈 클래스에 들어있는 변수의 값을 한 번에 출력하는 메서드
	// 객체안에 뭐가 들어있는지 보여줌
	@Override
	public String toString() {
		return "MemberBean [id=" + id + ", pw=" + pw + ", name=" + name + ", age=" + age + ", gender=" + gender
				+ ", email=" + email + ", regdate=" + regdate + "]";
	}
	
	
}
