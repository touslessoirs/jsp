package com.itwillbs.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.bo")
public class BoardFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(" BoradFrontController - doProcess() 호출");
	
		//================1. 가상주소 계산================
		
		System.out.println("\n [C] 1단계 : 가상주소 계산 시작");
		
		String requestURI = request.getRequestURI();
		System.out.println(" [C] requestURI : "+requestURI);
		
		String ctxPath = request.getContextPath();
		System.out.println(" [C] ctxPath : "+ctxPath);
		
		String command = requestURI.substring(ctxPath.length());
		System.out.println(" [C] command : "+command);
		
		System.out.println(" [C] 1단계 : 가상주소 계산 완료");
		
		//================1. 가상주소 계산================
		
		
		//================2. 가상주소 매핑================
		
		System.out.println("\n [C] 2단계 : 가상주소 매핑 시작");
		
		Action action = null;
		ActionForward forward = null;

		if(command.equals("/BoardWrite.bo")) {
			System.out.println(" [C] /BoardWrite.bo 호출");
			System.out.println(" [C] [패턴 1] DB사용 X, view 페이지 출력");	// writeForm.jsp
			
			forward = new ActionForward();
			forward.setPath("./board/writeForm.jsp");
			forward.setRedirect(false);
			
		}	// BoardWrite.bo
		
		else if(command.equals("/BoardWriteAction.bo")) {
			System.out.println(" [C] /BoardWriteAction.bo 호출");
			System.out.println(" [C] [패턴 2] DB사용 O, 페이지 이동");	// BoardList로 이동
			
			action = new BoardWriteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}	// BoardWriteAction.bo
		
		else if(command.equals("/BoardList.bo")) {
		    System.out.println(" C : /BoardList.bo 호출");
		    System.out.println(" C : [패턴3] DB사용 O, view페이지 출력");	// boardList.jsp
		    
		    action = new BoardListAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}	// BoardList.bo
		
		else if(command.equals("/BoardContent.bo")) {
		    System.out.println(" C : /BoardContent.bo 호출");
		    System.out.println(" C : [패턴3] DB사용 O, view페이지 출력");	// boardContent.jsp

		    action = new BoardContentAction();

			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}	// BoardContent.bo
		
		else if(command.equals("./BoardUpdate.bo")) {
			
		}
		
		else if(command.equals("./BoardDelete.bo")) {
			
		}
		
		else if(command.equals("./ReWrite.bo")) {
			
		}
		
		
		
		
		System.out.println(" [C] 2단계 : 가상주소 매핑 완료");
		
		//================2. 가상주소 매핑================
		
		
		
		//================3. 페이지 이동================
		
		System.out.println("\n [C] 3단계 : 페이지 이동 시작");
		
		if(forward!=null) {
			if(forward.isRedirect()) {	// true -> redirect
				System.out.println(" [C] 이동방식 : "+forward.isRedirect()+", 주소 : "+forward.getPath());
				response.sendRedirect(forward.getPath());
			} else {	// false -> 포워딩
				System.out.println(" [C] 이동방식 : "+forward.isRedirect()+", 주소 : "+forward.getPath());
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
		
		System.out.println(" [C] 3단계 : 페이지 이동 완료");
		
		//================3. 페이지 이동================
		
	
	
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(" \n\n BoardFrontController - doGet() 호출");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(" \n\n BoardFrontController - doPost() 호출");
		doProcess(request, response);
	}

	
}
