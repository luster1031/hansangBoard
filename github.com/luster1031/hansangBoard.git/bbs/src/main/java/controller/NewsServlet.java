package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import dao.MemberDAO;
import dao.NewsDAO;
import vo.MemberVO;
import vo.NewsVO;


@WebServlet("/main")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public NewsServlet() {
    	
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String keyword = request.getParameter("keyword");
    	HttpSession session = request.getSession();
		
		System.out.println(session.getAttribute("ID"));
  
		String id = request.getParameter("id");
		String NID = request.getParameter("NID");

		NewsDAO dao = new NewsDAO();
		if(keyword == null) {
			if(NID != null) {
				boolean result = dao.delete(Integer.parseInt(id));
				if (result) {
					request.setAttribute("msg", "글이 성공적으로 삭제되었습니다.");
				} else {
					request.setAttribute("msg", "글이 삭제되지 않았습니다.");
				}				
			} 		
			request.setAttribute("list", dao.listAll());
		} else {
			List<NewsVO> list = dao.search(keyword);
			if (list != null && list.size() == 0) {
				request.setAttribute("msg", keyword + "(이)가 포함된 글이 없습니다.");
			} else {
				request.setAttribute("list", dao.search(keyword));
			}
		}
		request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
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
				HttpSession session = request.getSession();
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String ID = (String) session.getAttribute("ID");
				NewsDAO newsDAO = new NewsDAO();
				NewsVO newsVO = new NewsVO();
				newsVO.setWriter(ID);
				newsVO.setContent(content);
				newsVO.setTitle(title);
				boolean result = newsDAO.insert(newsVO);

				if (result) {			
					request.setAttribute("msg", ID + "님의 글을 작성하였습니다.");			
				} else {
					request.setAttribute("msg", ID + "님의 글이 작성되지 않습니다..");
				}
				
			}else {
				
			}
			request.getRequestDispatcher("/main").forward(request, response);
		
		}else if (action.equals("select")) {
			MemberDAO memberDAO = new MemberDAO();
			String ID = request.getParameter("id");
			String pw = request.getParameter("password");
			MemberVO member = memberDAO.search(ID);
			
			if (member.getID() != null && member.getPw().equals(pw)) {
				HttpSession session = request.getSession();
				session.setAttribute("ID", ID);
				
				doGet(request, response);
//				request.getRequestDispatcher("/main").forward(request, response);
			} else if (member.getID() != null && !(member.getPw()).equals(pw)) {
				System.out.println("비밀번가 틀렸어요..");
				request.setAttribute("msg", "비밀번가 틀렸어요..");
				request.getRequestDispatcher("/jspsrc/login.jsp").forward(request, response);
			} else {
				request.setAttribute("msg","아이디가 없어요..");
				System.out.println("비밀번asd가 틀렸어요..");
				request.getRequestDispatcher("/jspsrc/login.jsp").forward(request, response);
			}
				
			
			
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
