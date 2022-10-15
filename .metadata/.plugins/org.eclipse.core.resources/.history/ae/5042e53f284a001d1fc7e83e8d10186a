<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>fileDown.jsp</h1>
	
	<%
	// 파일명 정보 저장
	String fileName = request.getParameter("fime_name");
	
	// 서버에 업로드된 폴더명 (가상 경로)
	String savePath = "upload";
	
	// 서버에 업로드된 폴더의 실제 위치 = 내가 다운로드할 폴더의 위치
// 	String Path = request.getRealPath("/upload");	// (X)
	// 서블릿(jsp) 프로젝트 객체를 생성한 다음
	ServletContext CTX = getServletContext();
	// => getRealPath() 사용하기
	String downloadPath = CTX.getRealPath(savePath);
	
	System.out.println(" @downloadPath : "+downloadPath);
	
	// 다운로드할 파일의 위치
	String filePath = downloadPath+"\\"+fileName;
	System.out.println(" @filePath : "+filePath);
	%>

</body>
</html>