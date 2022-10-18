package com.itwillbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.db.BoardDAO;
import com.itwillbs.db.BoardDTO;

public class BoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" [M] BoardWriteAction_execute()");
		
		// 한글 처리 생략
		// 전달 정보 (글 정보) 저장 + ip 정보 저장
		BoardDTO dto = new BoardDTO();
		dto.setSubject(request.getParameter("subject"));
		dto.setName(request.getParameter("name"));
		dto.setPass(request.getParameter("pass"));
		dto.setContent(request.getParameter("content"));
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
