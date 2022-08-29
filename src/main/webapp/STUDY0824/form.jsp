<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>form.jsp</h1>
	<fieldset>
	<legend>폼태그</legend>
	<form action="formPro.jsp" method="post">
	<h3>폼태그 : 정보를 입력받아서 전달하는 태그</h3>
	이름 : <input type="text" name="name"><br>
	나이 : <input type="text" name="age"><br>
	전화번호 : <input type="text" name="tel"><br>
	비밀번호 : <input type="password" name="pw"><br>
	성별 : <input type="radio" name="gender" value="남">남자
		  <input type="radio" name="gender" value="여">여자<br>
	취미 : <input type="checkbox" name="hobby" value="게임">게임
		  <input type="checkbox" name="hobby" value="운동">운동
		  <input type="checkbox" name="hobby" value="요리">요리<br>
	강의장 : <select name="num">
	<option value="">강의장을 선택하시오.</option>
	<option value="1">1강의장</option>
	<option value="2">2강의장</option>
	<option value="3">3강의장</option>
	<option value="4">4강의장</option>
	<option value="5">5강의장</option>
	</select>
	
	<input type="submit" value="입력하기">
	</form>
	</fieldset>
</body>
</html>