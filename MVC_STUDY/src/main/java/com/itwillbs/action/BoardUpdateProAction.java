package com.itwillbs.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.db.BoardDAO;
import com.itwillbs.db.BoardDTO;

public class BoardUpdateProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" [M] BoardUpdateProAction_execute()");
		
		// 전달 정보 (수정할 내용 + pageNum) 저장
		String pageNum = request.getParameter("pageNum");
		BoardDTO dto = new BoardDTO();
		dto.setBno(Integer.parseInt(request.getParameter("bno")));
		dto.setSubject(request.getParameter("subject"));
		dto.setName(request.getParameter("name"));
		dto.setPass(request.getParameter("pass"));
		dto.setContent(request.getParameter("content"));
		
		// DB에 반영하기
		BoardDAO dao = new BoardDAO();
		int result = dao.updateBoard(dto);

		// 페이지 이동 - js
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(result == 1){
			ActionForward forward = new ActionForward();
			forward.setPath("./BoardList.bo?pageNum="+pageNum);
			forward.setRedirect(true);
			return forward;
//			out.print("<script>");
//			out.print("alert('수정 완료!'");
//			out.print("location.href='./BoardList.bo?pageNum="+pageNum+"';");	// 이동완료
//			out.print("</script>");
//			out.close();
//			return null;
		} else if(result == 0) {
			out.print("<script>");
			out.print("alert('비밀번호 오류');");
			out.print("history.back();");	// 이동완료
			out.print("</script>");
			out.close();
			return null;
		} else {
			out.print("<script>");
			out.print("alret('게시판 글 없음');");
			out.print("history.back();");	// 이동완료
			out.print("</script>");
			out.close();
			return null;
		}
		
		
	}

}
