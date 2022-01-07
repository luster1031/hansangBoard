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
		if(list != null){
		%>
			<h2 id="divT">게시판 수정</h2>
			<hr>
			<form method = "post" action = "/bbs/main">
				<input type="hidden" name="NID" value=<%=NID%>>
				수정자 : <input id="n_name" type="text"  name="name" value = <%=list.getWriter() %>>
				<br>
				게시판 제목 : <input id="n_title" type="text"  name="title" value=<%=list.getTitle()%>><br>
				수정할 게시판 내용: <br>
				<textarea id="n_content"  rows="3" cols="30" name = "content"><%= list.getContent() %></textarea>
				<br>
				<%
				String writedate= list.getWritedate();
				writedate = writedate.replace("년 ", "-");
				writedate = writedate.replace("월 ", "-");
				writedate = writedate.replace("일 ", "T");
				writedate = writedate.replace("시 ", ":");
				writedate = writedate.replace("분", "");
				%>
				날짜와 시간 :  <input id="n_dt" type="datetime-local" name="meetingDate" value=<%=writedate%>>
				<br>
				<input type="hidden" name="cnt" value=<%=list.getCnt()%>>
				<input type="hidden" name="NID" value=<%=list.getNID()%>>
				<input type = "submit" value = "수정">
			</form>
	
			
	<%} %>

</body>
</html>