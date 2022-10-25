<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
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
		// 1) 파일명, 다운로드 폴더 설정하기
		// 파일명
		String fileName = request.getParameter("file_name");
		// 업로드 폴더 = 다운로드 폴더
		String savePath = "upload";

		ServletContext CTX = getServletContext();
		String uploadPath = CTX.getRealPath(savePath);
		
		// D:\woakspace_jsp\...upload\파일명
		String filePath = uploadPath+"\\"+fileName;
		System.out.println(" @@ filePath : "+filePath);
	
		// ======================================
		// 2) 다운로드 파일의 MIME 타입 설정하기
		String MIMEType = CTX.getMimeType(filePath);
		// MIMEType 기본값 설정
		if(MIMEType == null){
		    MIMEType = "application/octet-stream";
		}
		response.setContentType(MIMEType);		
		
		// 3) IE 브라우저 파일명 한글 인코딩처리
		// 사용자의 브라우저 정보 확인
		String agent = request.getHeader("User-Agent");
		
		// MSIF 또는 Trident가 포함되어있으면 IE
		boolean ieBrowser
			= (agent.indexOf("MSIF") > -1) || (agent.indexOf("Trident") > -1);
		
		// IE에서 파일 다운로드 시 한글 및 문자 깨짐 오류 해결
		if(ieBrowser){
		    // IE일 때
		    fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		} else {
		    // IE가 아닐 때
		    fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
		}
		
		// 모든 파일을 다운로드형태로 처리하겠다고 설정하기
		response.setHeader("Content-Disposition", "attachment; filename="+fileName);	
				
		// ======================================
		// 4) 파일 다운로드
		byte[] b = new byte[4096];	//  4KB씩 끊어서 가져오기
		FileInputStream fis = new FileInputStream(filePath);
		
		// JSP에는 out 내장 객체 존재 -> out2까지 하면 통로가 2개가 됨
		// 기존 통로를 먼저 정리하기
		out.clear();
		out = pageContext.pushBody();
		ServletOutputStream out2 = response.getOutputStream();
		 
		// 데이터 읽어오기
		int data=0;
		// 4KB씩 끊어서 filePath read->date에 저장->배열에 write
		while((data = fis.read(b,0,b.length)) != -1 ){
		  out2.write(b,0,data);
		}
		 
		// 배열으로 정보 전달 -> 버퍼 사용 -> flush로 버퍼의 빈 공간을 채워서 전달
		out2.flush();
		out2.close();
		fis.close();
	
		System.out.println(" @@ 파일 다운로드 완료");
	%>


</body>
</html>