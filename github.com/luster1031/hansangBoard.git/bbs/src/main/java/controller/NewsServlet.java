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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String keyword = request.getParameter("keyword");
    	
		var writer = request.getParameter("writer");
		String name = request.getParameter("name");
		NewsDAO dao = new NewsDAO();
		
		if(keyword == null) {
			if(request.getParameter("NID")!= null) {
				int NID = Integer.parseInt(request.getParameter("NID"));
				System.out.println("[doGet] name : "  +name + " writer : "+ writer + " NID : " + NID );
				if(writer.equals(name)) {
					if(NID != 0) {
						boolean result = dao.delete(NID);
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
		//글작성,수정,로그인,회원가입 액션 변수?파라미터?에 담아서
		request.setCharacterEncoding("UTF-8");
		String NID = request.getParameter("NID");
		String name = request.getParameter("name");
		NewsDAO dao = new NewsDAO();
		NewsVO vo = new NewsVO();
		
		vo.setNID(Integer.parseInt(NID));
		vo.setWriter(name);
		vo.setTitle( request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		vo.setWritedate(request.getParameter("meetingDate"));
		vo.setCnt(Integer.parseInt(request.getParameter("cnt")));
		
		System.out.println("[post]:" + vo.getWriter() + " "+ vo.getTitle() + " "+ vo.getContent() + " "+ vo.getCnt()+ " "+vo.getNID()+ " "+ vo.getWritedate());
		if(NID.equals("insert")) {
			
		}else {
			System.out.println("[servlet_update]:" + vo.getWriter() + " | "+ vo.getTitle() + " | "+ vo.getContent() + " | "+ vo.getCnt()+ " | "+vo.getNID()+ " | "+ vo.getWritedate());
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
