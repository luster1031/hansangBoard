package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NewsDAO;
import vo.NewsVO;


@WebServlet("/main")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public NewsServlet() {
    	
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//삭제
    	String keyword = request.getParameter("keyword");
		String id = request.getParameter("id");
		String action = request.getParameter("action");

		NewsDAO dao = new NewsDAO();
		if(keyword == null) {
			if(action != null) {
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
		String action = request.getParameter("action");
		String name = request.getParameter("name");
		String title = request.getParameter("title");
		String meetingDate = request.getParameter("meetingDate");
		NewsDAO dao = new NewsDAO();
		NewsVO vo = new NewsVO();
		vo.setWriter(name);
		vo.setTitle(title);
		vo.setWritedate(meetingDate);
		if(action.equals("insert")) {
			boolean result = dao.insert(vo);
			if (result) {			
				request.setAttribute("msg", name + "님의 글이 성공적으로 입력되었습니다.");			
			} else {
				request.setAttribute("msg", name + "님의 글이 입력되지 않았습니다.");
			}
		} else {
			vo.setNID(Integer.parseInt(action));
			boolean result = dao.update(vo);
			if (result) {			
				request.setAttribute("msg", name + "님의 글이 성공적으로 수정되었습니다.");			
			} else {
				request.setAttribute("msg", name + "님의 글이 수정되지 않았습니다.");
			}
		}
		request.setAttribute("list", dao.listAll());
		request.getRequestDispatcher("/jspsrc/NewsView.jsp").forward(request, response);
		//글작성,수정,로그인,회원가입 액션 변수?파라미터?에 담아서
	}

}
