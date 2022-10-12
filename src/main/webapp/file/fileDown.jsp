<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
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
	// =======1. 파일명, 다운로드 폴더 위치 설정하기=======
	
	// 파일명 정보 저장
	String fileName = request.getParameter("file_name");
	
	// 서버에 업로드된 폴더명 (가상 경로)
	String savePath = "upload";
	
	// 서버에 업로드된 폴더의 실제 위치
// 	String Path = request.getRealPath("/upload");	// (X)
	// 서블릿(jsp) 프로젝트 객체를 생성한 다음 getRealPath() 사용하기
	ServletContext CTX = getServletContext();
	// = 다운로드할 폴더의 위치
	String downloadPath = CTX.getRealPath(savePath);
	
	System.out.println(" @downloadPath : "+downloadPath);
	
	// 다운로드할 파일의 위치
	String filePath = downloadPath+"\\"+fileName;
	System.out.println(" @filePath : "+filePath);
	
	// ===========2. 파일 다운로드 준비===========
	
	// 다운로드할 파일의 MIME 타입 확인
	String MIMEType = CTX.getMimeType(filePath);
	System.out.println(" @MIMEType : "+MIMEType);
	 
	// MIME 타입값이 없을 경우 기본값으로 설정
	if (MIMEType == null){
		MIMEType = "application/octet-stream";
	}
	
	// 응답할 페이지의 기존 contextType : html
	// => 다운로드할 파일의 MIME 타입으로 변경
	// 다운로드할 파일이 이미지면 이미지 뷰어, pdf면 pdf 뷰어로 응답하기 위함
	response.setContentType(MIMEType);
	
	// IE 브라우저에서 파일명 한글 인코딩처리하기
	// 사용자	브라우저 정보 확인
	String agent = request.getHeader("User-Agent");
	
	// MSIF 또는 Trident가 포함되어있으면 IE
	// indexOf() : 일치하는 값이 없으면 -1 반환
	boolean ieBrowser = 
		(agent.indexOf("MSIF") > -1) || (agent.indexOf("Trident") > -1);
			
	// IE에서 파일 다운로드 시 한글 및 문자 깨짐 오류 해결
	if(ieBrowser){
	    // IE일 때
	    fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
	} else {
	    // IE가 아닐 때
	    fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
	}

	response.setHeader("Content-Disposition", "attachment; filename="+fileName);
	
	// ==============3. 파일 다운로드==============
	
	// 파일을 byte 단위로 나눠서 읽고 쓰기
	byte[] b = new byte[4096];	// 4KB씩 끊어서 가져오기

	// FileInputStream
	FileInputStream fis = new FileInputStream(filePath);
			
	// JSP 자체의 OutputStream 제거
	out.clear();
	out = pageContext.pushBody();
	
	// ServletOutputStream -> 다운로드 통로 생성
	ServletOutputStream out2 = response.getOutputStream();
	
	// 데이터 4KB씩 읽어와서 출력하기
	int data = 0;
	while((data = fis.read(b, 0, b.length)) != -1){
		out2.write(b, 0, data);
	}
		
	out2.flush();	// 데이터 전송(버퍼 비우기)
	out2.close();
	fis.close();
	
	%>

</body>
</html>