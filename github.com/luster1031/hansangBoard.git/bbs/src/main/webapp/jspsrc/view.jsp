<%@page import="dao.NewsDAO"%>
<%@page import="javax.script.ScriptContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.NewsVO, java.util.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 내용 보기</title>
</head>
<body>
	<%
		int NID = 0;
		String name = "";
		
		if(request.getParameter("NID")!= null && request.getParameter("name")!=null){
			NID = Integer.parseInt(request.getParameter("NID"));
			name = request.getParameter("name");
			
	    }
		if(NID == 0 || name.equals("")){
			request.getRequestDispatcher("/jspsrc/signUp.jsp").forward(request, response);
		}
		NewsVO list  = new NewsDAO().listOne(NID);
		if(list != null){
			%>
			
			<table>
				<tr>
					<th>게시판 글쓰기 양식</th>
				</tr>
			
				<tr>
					<td style = "width : 20%;">글제목</td>
					<td colspan = "2"><%=list.getTitle()%></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td colspan = "2"><%= list.getWritedate() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan = "2" style = "min-height:200px; text-align:left;"><%= list.getContent() %></td>
				</tr>
			</table>			
			<%if(name.equals(list.getWriter())){%>
				<button type = "button" onclick= "location.href = '/bbs/jspsrc/update.jsp?NID=<%=list.getNID()%>'">수정</botton>
				<button type = "button" onclick= "location.href = '/bbs/main'">삭제</botton>
			<%} 
			}%>
</body>
</html>