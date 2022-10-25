<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>reWriteForm (MVC).jsp</h1>

	<fieldset>
		<!-- 주소줄에 담아 넘긴 정보이므로 param.pageNum -->
	    <form action="./BoardReWriteAction.bo?pageNum=${param.pageNum }" method="post">
	    	<input type="hidden" name="bno" value=${param.bno }>
	    	<input type="hidden" name="re_ref" value=${param.re_ref }>
	    	<input type="hidden" name="re_lev" value=${param.re_lev }>
	    	<input type="hidden" name="re_seq" value=${param.re_seq }>
	        제목 : <input type="text" name="subject" value="[답글] ${param.subject }"><br>
	        작성자 : <input type="text" name="name"><br>
	        비밀번호 : <input type="password" name="pass"><br>
	        내용 : <textarea rows="10" cols="20" name="content"></textarea>
	        <hr>
	        <input type="submit" value="글쓰기">
	    </form>
	</fieldset>
	
</body>
</html>