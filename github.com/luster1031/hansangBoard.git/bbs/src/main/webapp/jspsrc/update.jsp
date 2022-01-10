<!-- 
	게시판 수정
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.NewsVO,dao.NewsDAO, java.util.*, java.io.*, java.util.Date" %>
<%@ page import = "java.text.DateFormat, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		int NID = 0;
		String name = request.getParameter("name");
		String writer = request.getParameter("writer");
		if(request.getParameter("NID")!= null){
			NID = Integer.parseInt(request.getParameter("NID"));
		}
		if(NID == 0){
			out.println("<script>");
			out.println("alert('유효하지 않는 글입니다.'");
			out.println("location.href = 'signUp.jsp'");
			out.println("</script>");
		}
		NewsVO list  = new NewsDAO().listOne(NID);
		if(list != null && writer.equals(name)){
		%>
			<h2 id="divT">게시판 수정</h2>
			<hr>
			<form method = "post" action = "/bbs/main?keyword=listPage">
				<input type="hidden" name="action" value="update">>
				<input type="hidden" name="NID" value=<%=NID%>>
				수정자 : <input id="n_name" type="text"  name="name" value = <%=list.getWriter() %>>
				<br>
				게시판 제목 : <input id="n_title" type="text"  name="title" value=<%=list.getTitle()%>><br>
				수정할 게시판 내용: <br>
				<textarea id="n_content"  rows="3" cols="30" name = "content"><%= list.getContent() %></textarea>
				<br>
				<%
				String writedate= list.getWritedate();
				writedate = writedate.replace(" ", "T");
				%>
				날짜와 시간 :  <input id="n_dt" type="datetime-local" name="meetingDate" value=<%=writedate%>>
				<br>
				<input type="hidden" name="cnt" value=<%=list.getCnt()%>>
				<input type="hidden" name="NID" value=<%=list.getNID()%>>
				<input type = "submit" value = "수정">
			</form>
	
			
	<%}else{
		request.setAttribute("msg","수정이 안됨 ㅠㅠ");
		request.getRequestDispatcher("/main?keyword=listPage").forward(request, response);
	} %>
</body>
</html>