package com.itwillbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.db.BoardDAO;
import com.itwillbs.db.BoardDTO;

public class BoardUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" [M] BoardUpdateAction_execute()");
		
		// 전달 정보 (bno, pageNum) 저장
		int bno = Integer.parseInt(request.getParameter("bno"));
		String pageNum = request.getParameter("pageNum");
		
		// 수정할 글 정보 가져오기 - getBoardContent()
		// => DTO에 저장
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.getBoardContent(bno);
		
		// DTO => request 영역에 저장 (=> view 출력)
		request.setAttribute("dto", dto);
		request.setAttribute("pageNum", pageNum);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board/updateForm.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
