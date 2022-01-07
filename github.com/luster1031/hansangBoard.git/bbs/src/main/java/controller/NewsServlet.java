package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.MemberDAO;
import dao.NewsDAO;
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
		String log = request.getParameter("logout");
		if (log != null) {
			request.getSession().invalidate();
		}
		var writer = request.getParameter("writer");
		String name = request.getParameter("name");
		NewsDAO dao = new NewsDAO();

		if (keyword == null) {
			if (request.getParameter("NID") != null) {
				int NID = Integer.parseInt(request.getParameter("NID"));
				System.out.println("[doGet] name : " + name + " writer : " + writer + " NID : " + NID);
				if (writer.equals(name)) {
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
			request.setAttribute("list", dao.listAll());

		} else {
			String option = request.getParameter("selectOption");
			List<NewsVO> list = dao.search(keyword,option);
			if (list != null && list.size() == 0) {
				request.setAttribute("msg", keyword + "(이)가 포함된 글이 없습니다.");
			} else {
				request.setAttribute("list",dao.search(keyword,option));
			}
		}
		request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
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
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				request.setCharacterEncoding("utf-8");
				String path = "c:/Temp/uploadtest";
				File isDir = new File(path);
				if (!isDir.isDirectory()) {
					isDir.mkdirs();
				}
				Collection<Part> parts = request.getParts(); // 전달된 파트 컬렉션 개체에 담아주기
				for (Part part : parts) {
					String fileName = part.getSubmittedFileName();
					if (fileName != null && fileName.equals("")) {
						part.write(System.currentTimeMillis()+"_"+fileName); 
						out.print("업로드한 파일 이름: " + fileName + "<br>");
						out.print("크기: " + part.getSize() + "<br>");
					} else if (fileName == null){
						String partName = part.getName();
						String fieldValue = request.getParameter(partName);
						out.print(partName + " : " + fieldValue + "<br>");
					}
				}
				out.close();
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

				if (result) {
					request.setAttribute("msg", ID + "----");
				} else {
					request.setAttribute("msg", ID + "----");
				}

			} else {

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
			vo.setCnt(Integer.parseInt(request.getParameter("cnt")));

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
			request.setAttribute("list", dao.listAll());
			request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
		}
	}

}