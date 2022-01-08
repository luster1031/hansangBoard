<%@page import="dao.NewsDAO"%>
<%@page import="javax.script.ScriptContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.NewsVO, java.util.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 내용 보기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
	<%
	int NID = 0;
	String name = "";
	HttpSession session1 = request.getSession(true);
	String ID = (String) session1.getAttribute("ID");

	if (request.getParameter("NID") != null || request.getParameter("name") != null) {
		NID = Integer.parseInt(request.getParameter("NID"));
		name = request.getParameter("name");

	}

	if (NID == 0 || name.equals("")) {
		request.getRequestDispatcher("/jspsrc/signUp.jsp").forward(request, response);
	}
	NewsDAO dao = new NewsDAO();
	NewsVO list = new NewsDAO().listOne(NID);
	if (list != null) {
		list.setCnt(1);
		System.out.println("[글쓰기]cnt : " + list.getCnt());
		dao.update(list);
	%>
	
	<table>
		<tr>
			<th>게시글 보기</th>
		</tr>

		<tr>
			<td style="width: 20%;">글제목</td>
			<td colspan="2"><%=list.getTitle()%></td>
		</tr>
		<tr>
			<td>작성일자</td>
			<td colspan="2"><%=list.getWritedate()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="2" style="min-height: 200px; text-align: left;"><%=list.getContent()%></td>
		</tr>
	</table>
	<%
	if (name.equals(list.getWriter())) {
	%>
	<a href="/bbs/jspsrc/update.jsp?NID=<%=list.getNID()%>&writer=<%=list.getWriter()%>&name=<%=ID%>" class="btn btn-warning" >수정</a>
	<a href="/bbs/main?action=delete&NID=<%=list.getNID()%>&writer=<%=list.getWriter()%>&name=<%=ID%>" class="btn btn-danger" onclick="return confirm('Are you sure, you want to delete it?')">Delete Quote</a>
	<%
	}
}
%>
		
</body>
</html>