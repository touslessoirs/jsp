<%@page import="com.itwillbs.board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>boardList.jsp</h1>
	
	<%
	// DB에 저장된 글 목록 정보 가져오기
	BoardDAO dao = new BoardDAO();
	
	// 저장된 전체 글 개수
	int count = dao.getBoardCount();
	
	// ========================================================
	// 페이징 처리(1) DB에서 원하는 만큼의 글 정보 가져오기

	// pageSize : 한 페이지에 보여줄 글 개수
	int pageSize = 3;
	
	// pageNum : 현재 페이지 번호
	String pageNum = request.getParameter("pageNum");
	
	// 만약 페이지 번호가 없으면 현재 페이지가 첫 페이지가 되도록 설정
	if(pageNum==null){
		pageNum="1";
	}
	
	// ex) 한 페이지당 글 10개 출력, 현재 페이지 2 => 11~20번째 글 출력
	// startRow : 시작행(1, 11, 21, 31, ...)
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;

	// endRow : 끝행(10, 20, 30, ...)
	int endRow = currentPage*pageSize;
	
	// ========================================================
	
	// 가져온 정보 배열에 저장
// 	ArrayList boardList = dao.getBoardList();
	ArrayList boardList = dao.getBoardList(startRow, pageSize);
	
	// 표 형식으로 출력하기
	%>

	<h3><a href="writeForm.jsp">글쓰기</a></h3>
	<h3><a href="fwriteForm.jsp">파일 글쓰기</a></h3>
	<table border="1">
	<tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>작성일</th>
        <th>ip</th>
    </tr>
   		<%
    	for(int i=0;i<boardList.size();i++){
    		// 배열에 담긴 정보 하나씩 꺼내서 dto에 저장
    		BoardDTO dto = (BoardDTO) boardList.get(i);
    	%>

    <tr>
        <td><%=dto.getBno() %></td>
        <td>
        	<%
        	if(dto.getRe_lev()>0){
       		%>
        		<img src="../img/level.gif" width="<%=dto.getRe_lev()*10%>">
				<img src="../img/re.gif">
			<%        	
        	}
        	%>
        	<a href="boardContent.jsp?bno=<%=dto.getBno()%>&pageNum=<%=pageNum %>"><%=dto.getSubject() %></a>
        </td>
        <td><%=dto.getName() %></td>
        <td><%=dto.getReadcount() %></td>
        <td><%=dto.getDate() %></td>
        <td><%=dto.getIp() %></td>
    </tr>
    
		<%
    	}
		%>    
	</table>
	
	<%
	// ========================================================
	// 페이징 처리(2) [이전], 페이지 번호, [다음]
	if(count!=0){

		// pageCount : 총 페이지 수
		// 나머지가 존재하면 페이지 수 +1
		int pageCount = (count/pageSize)+(count%pageSize==0?0:1);
		
		// pageBlock : 한 화면에 보여줄 페이지 수
		int pageBlock = 2;
		
		// startPage : 페이지블럭의 시작번호
	    // 1~10=>1, 11~20=>11, 21~30=>21
	    int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	 
	    // 페이지블럭의 끝번호
	    int endPage = startPage+pageBlock-1;
	    // 만약 글 개수가 한 페이지를 다 채우지 못한다면
	    if(endPage>pageCount){
	        endPage = pageCount;
	    }
	
	    // [이전]
	    if(startPage > pageBlock){	// 이전 페이지가 존재한다면
		%>
			<a href="boardList.jsp?pageNum=<%=startPage-pageBlock %>">[이전]</a>
		<%
	    }
	    // 숫자(페이지 링크) 1, 2, 3,...
	    for(int i=startPage;i<=endPage;i++){
		%>
			<a href="boardList.jsp?pageNum=<%=i%>"><%=i %></a>
		<%
	    }
	    // [다음]
	    if(endPage < pageCount){	// 다음 페이지가 존재한다면
		%>
			<a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
		<%
	    }
	}
	
	// ========================================================
	%>
	
	
	
</body>
</html>