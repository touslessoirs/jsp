package com.itwillbs.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.db.BoardDAO;

public class BoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" [M] BoardListAction_execute()");
		
		// 전체 글 개수 - getBoardCount()
		BoardDAO dao = new BoardDAO();
		int cnt = dao.getBoardCount();
		
		// ===============페이징 처리 1===============
		int pageSize = 5;
		
		String pageNum = request.getParameter("pageNum");
		// 넘어온 페이지 정보 없으면 = 첫 글이면 => pageNum = 1
		if(pageNum==null) {
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		int endRow = currentPage*pageSize;
		
		// 글 목록 조회하기 - getBoardList()
		List boardList = dao.getBoardList(startRow, pageSize);
		
		// ===============페이징 처리 2===============
		// 나머지가 있을 경우 페이지 수+1
		int pageCount = (cnt/pageSize)+(cnt%pageSize==0?0:1);
		
		int pageBlock = 1;
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
		int endPage = startPage+pageBlock-1;
		// 만약 글 갯수가 한 페이지를 다 채우지 못한다면
		if(endPage>pageCount){
			endPage = pageCount;
		}
		
		//==========================================
		// 가져온 데이터 request 영역에 저장 -> view로 전달
		request.setAttribute("boardList", boardList);
		
		// 페이징 처리 정보를 추가로 저장해야하므로 이 방법 사용X
//		request.setAttribute("boardList", dao.getBoardList(startRow, pageSize))
		
		// 페이징 처리 정보 request 영역에 저장
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalCnt", cnt);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		// 페이지 이동 -> boardList.jsp (view)
		ActionForward forward = new ActionForward();
		forward.setPath("./board/boardList.jsp");
		forward.setRedirect(false);	// request -> 포워딩
		
		return forward;
	}

}
