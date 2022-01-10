package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.CommentDAO;
import dao.MemberDAO;
import dao.NewsDAO;
import vo.CommentVO;
import vo.MemberVO;
import vo.NewsVO;

@WebServlet("/main")
@MultipartConfig(location = "c:/Temp/uploadtest")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String keyword = request.getParameter("keyword");
		String log = request.getParameter("logout");	// 로그인 체크
		if (log != null) {
			request.getSession().invalidate();
		}

		int page_strat = 0;	//	뽑아올 리스트의 row번호
		String now_page = request.getParameter("page");	//	현재 페이지
		if(now_page !=null) {
			page_strat = (Integer.parseInt(now_page)-1)*5;
			System.out.println("[곱하기 ] : " + page_strat);
		}
		
		var writer = request.getParameter("writer");
		String name = request.getParameter("name");
		NewsDAO dao = new NewsDAO();
		
		
		if (keyword == null) {
			request.getRequestDispatcher("/jspsrc/mainPage.jsp").forward(request, response);
		}
		else if(keyword.equals("listPage")) {
			if (request.getParameter("NID") != null) {
				int NID = Integer.parseInt(request.getParameter("NID"));
				System.out.println("[doGet] name : " + name + " writer : " + writer + " NID : " + NID);
				if (writer.equals(name) || name.equals("admin")) {
					if (NID != 0) {
						/*
						 * out.println("<script>" +
						 * "if (!confirm(\"확인(예) 또는 취소(아니오)를 선택해주세요.\")) {\r\n");
						 * System.out.println("아ㅏ니요"); out.println("       } else {\r\n");
						 */
						boolean result = dao.delete(NID);
						/*
						 * out.println("        }</script>"); out.close();
						 */
						if (result) {
							request.setAttribute("msg", "글이 성공적으로 삭제되었습니다.");
						} else {
							request.setAttribute("msg", "글이 삭제되지 않았습니다.");
						}
					}
				}
			}
			request.setAttribute("list", dao.listSelect(page_strat, 5));
			request.setAttribute("now_page", now_page);
			request.setAttribute("list_num",dao.count());
			request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
		}else if(keyword.equals("list")){
			if (request.getParameter("NID") != null && name!=null) {
				request.setAttribute("list", request.getParameter("NID"));
				request.setAttribute("list", name);
				request.getRequestDispatcher("/jspsrc/view.jsp").forward(request, response);
			}
		}else{
			String option = request.getParameter("selectOption");
			List<NewsVO> list = dao.search(keyword,option,page_strat, 5);
			if (list != null && list.size() == 0) {
				request.setAttribute("msg", keyword + "(이)가 포함된 글이 없습니다.");
			} else {
				request.setAttribute("list",list);
				request.setAttribute("option", option);
				request.setAttribute("keyword", keyword);
				request.setAttribute("now_page", now_page);
				request.setAttribute("list_num",dao.count());
			}
			request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 글작성,수정,로그인,회원가입 액션 변수?파라미터?에 담아서
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
			} else if (sign.equals("false")) {
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

				if (!result) {
					request.setAttribute("msg", ID + "님 글쓰기를 완료하지 못하였어요 ㅠㅜㅠㅜ");
				}

			}
			doGet(request, response);
			// request.getRequestDispatcher("/jspsrc/main").forward(request, response);

		} else if (action.equals("select")) {
			MemberDAO memberDAO = new MemberDAO();
			String ID = request.getParameter("id");
			String pw = request.getParameter("password");
			MemberVO member = memberDAO.search(ID);

			if (member.getID() != null && member.getPw().equals(pw) && !member.getID().isEmpty()) {
				HttpSession session = request.getSession();
				session.setAttribute("ID", ID);
				System.out.println("zcxvadsfzc" + session.getAttribute("ID"));
				doGet(request, response);
//				request.getRequestDispatcher("/main").forward(request, response);
			} else if (member.getID() != null && !(member.getPw()).equals(pw) && !member.getID().isEmpty()) {
				System.out.println("비밀번가 틀렸어요..");
				request.setAttribute("msg", "비밀번가 틀렸어요..");
				request.getRequestDispatcher("/jspsrc/login.jsp").forward(request, response);
			} else {
				request.setAttribute("msg", "아이디가 없어요..");
				System.out.println("비밀번asd가 틀렸어요..");
				request.getRequestDispatcher("/jspsrc/login.jsp").forward(request, response);
			}

		} else if (action.equals("update")) {

			String NID = request.getParameter("NID");
			String name = request.getParameter("name");
			NewsDAO dao = new NewsDAO();
			NewsVO vo = new NewsVO();

			vo.setNID(Integer.parseInt(NID));
			vo.setWriter(name);
			vo.setTitle(request.getParameter("title"));
			vo.setContent(request.getParameter("content"));
			vo.setWritedate(request.getParameter("meetingDate"));
			vo.setCnt(1);

			System.out.println("[post]:" + vo.getWriter() + " " + vo.getTitle() + " " + vo.getContent() + " "
					+ vo.getCnt() + " " + vo.getNID() + " " + vo.getWritedate());
			if (Integer.parseInt(NID) > 0) {
				System.out.println("[servlet_update]:" + vo.getWriter() + " | " + vo.getTitle() + " | "
						+ vo.getContent() + " | " + vo.getCnt() + " | " + vo.getNID() + " | " + vo.getWritedate());
				boolean result = dao.update(vo);
				if (result) {
					request.setAttribute("msg", name + "님의 글이 성공적으로 입력되었습니다.");
				} else {
					request.setAttribute("msg", name + "님의 글이 입력되지 않았습니다.");
				}
			}
			request.setAttribute("list",  dao.listSelect(1, 5));
			
			request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
		}
		else if(action.equals("comment")) {
			String content = request.getParameter("content");
			String name = request.getParameter("name");
			String NID = request.getParameter("NID");
			CommentVO vo = new CommentVO();
			CommentDAO dao = new CommentDAO();
			
			vo.setCommnet_num(1);
			vo.setContent(content);
			vo.setDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss")));
			vo.setNID(Integer.parseInt(NID));
			vo.setWriter(name);
			if (Integer.parseInt(NID) > 0) {
				boolean result = dao.insert(vo);
				if (result) {
					request.setAttribute("msg", name + "님의 글이 성공적으로 입력되었습니다.");
				} else {
					request.setAttribute("msg", name + "님의 글이 입력되지 않았습니다.");
				}
			}
			request.setAttribute("list", dao.listAll(Integer.parseInt(NID)));
			request.getRequestDispatcher("/jspsrc/view.jsp").forward(request, response);
		}
	}

}