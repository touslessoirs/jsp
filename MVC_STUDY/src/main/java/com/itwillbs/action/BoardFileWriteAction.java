package com.itwillbs.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.db.BoardDAO;
import com.itwillbs.db.BoardDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardFileWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" [M] BoardfWriteAction_execute()");
		
		// 1) 파일 업로드
		// 업로드 경로
//		String realPath = request.getRealPath("/upload");
		// 서블릿context(프로젝트) 객체 생성
		ServletContext CTX = request.getServletContext();
		String realPath = CTX.getRealPath("/upload");
		System.out.println(" [M] realPath : "+realPath);
		// 첨부파일 크기 제한 : 10mb
		int maxSize = 10 * 1024 * 1024;
		
		// MultipartRequest 객체
		MultipartRequest multi = new MultipartRequest(
			request,
			realPath,
			maxSize,
			"UTF-8",
			new DefaultFileRenamePolicy()
		);
		
		System.out.println(" [M] 첨부파일 업로드 완료");
		
		// 2) DB에 정보 저장
		// 한글 처리 생략
		// 전달 정보 (글 정보) 저장 + ip 정보 저장
		BoardDTO dto = new BoardDTO();
		dto.setSubject(multi.getParameter("subject"));
		dto.setName(multi.getParameter("name"));
		dto.setPass(multi.getParameter("pass"));
		dto.setContent(multi.getParameter("content"));
		dto.setFile(multi.getFilesystemName("file"));
		dto.setIp(request.getRemoteAddr());
		
		// DB에 반영하기
		BoardDAO dao = new BoardDAO();
		dao.insertBoard(dto);

		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./BoardList.bo");
		forward.setRedirect(true);
		
		return forward;
	}

}
