package com.itwillbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.db.BoardDAO;
import com.itwillbs.db.BoardDTO;

public class BoardContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" [M] BoardContentAction_execute()");
		
		// 한글 처리 생략
		// 전달 정보 (bno, pageNum) 저장
		int bno = Integer.parseInt(request.getParameter("bno"));
		String pageNum = request.getParameter("pageNum");
		
		BoardDAO dao = new BoardDAO();
		// 조회수 1 증가
		dao.updateReadcount(bno);
		System.out.println(" [M] 조회수 1 증가");
		// DB에서 게시글 정보 가져오기 + 가져온 정보 DTO에 저장
		BoardDTO dto = dao.getBoardContent(bno);
		
		// DTO & pageNum -> request 영역에 저장 (-> view 페이지 전달)
		request.setAttribute("dto", dto);
//		request.setAttribute("dto", dao.getBoardContent(bno));
		request.setAttribute("pageNum", pageNum);
		
		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./board/boardContent.jsp?pageNum"+pageNum);
		forward.setRedirect(false);	// request -> 포워딩

		return forward;
		
	}

}
