package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.MemberDAO;

import vo.MemberVO;

@WebServlet("/main")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public NewsServlet() {
    	
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//삭제
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String sign = request.getParameter("sign");
		String action = request.getParameter("action");
		if (action.equals("insert")) {
			if (sign.equals("true")) {
				String name = request.getParameter("name");
				String id = request.getParameter("id");
				String password = request.getParameter("password");
				String phone = request.getParameter("phone");
				MemberVO member = new MemberVO();
				MemberDAO memberDAO = new MemberDAO();
				member.setID(id);
				member.setName(name);
				member.setPw(password);
				member.setPhone(phone);
				boolean result = memberDAO.insert(member);
				if (result) {			
					request.setAttribute("msg", name + "님이 성공적으로 가입되었습니다.");			
				} else {
					request.setAttribute("msg", name + "님이 성공적으로 가입되지 않았습니다.");
				}
			}else if (sign.equals("false")){
				System.out.println("b");
			}else {
				
			}
		
		}
//		String name = request.getParameter("name");
//		String title = request.getParameter("title");
//		String meetingDate = request.getParameter("meetingDate");
//		MemberDAO dao = new MemberDAO();
//		MemberVO vo = new MemberVO();
//		vo.setName(name);
//		vo.setTitle(title);
//		vo.setMeetingDate(meetingDate);
//		if(action.equals("insert")) {
//			boolean result = dao.insert(vo);
//			if (result) {			
//				request.setAttribute("msg", name + "님의 글이 성공적으로 입력되었습니다.");			
//			} else {
//				request.setAttribute("msg", name + "님의 글이 입력되지 않았습니다.");
//			}
//		} else {
//			vo.setId(Integer.parseInt(action));
//			boolean result = dao.update(vo);
//			if (result) {			
//				request.setAttribute("msg", name + "님의 글이 성공적으로 수정되었습니다.");			
//			} else {
//				request.setAttribute("msg", name + "님의 글이 수정되지 않았습니다.");
//			}
//		}
//		request.setAttribute("list", dao.listAll());
//		request.getRequestDispatcher("/jspsrc/meetingView.jsp").forward(request, response);
		
	}

}
