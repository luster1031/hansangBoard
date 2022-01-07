<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import = "vo.NewsVO, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록 보기</title>
<style type="text/css">
a, a:hover {
	color:#000000;
	text-decoration:none;
}
</style>
</head>
<body>
	<%
	List<NewsVO> list = (List<NewsVO>)request.getAttribute("list");
	HttpSession session1 = request.getSession(true);
	String ID = (String) session1.getAttribute("ID");
	if(list !=null){
	%>
	<h2>미팅 스케쥴</h2><hr>
	<table>
		<th>번호</th>
		<th>작성자</th>
		<th>내용</th>
		<th>제목</th>
		<th>조회수</th>
		<th>작성일자</th>
		<tr>	
		<%
		for(NewsVO vo : list){	
		%>
			<tr>
				<td class='<%= vo.getNID() %>'><%= vo.getNID() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getWriter() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getContent() %></td>
				<td class='<%= vo.getNID() %>'>
				<%if(ID != null){ %>
					<a href = "/bbs/jspsrc/view.jsp?NID=<%= vo.getNID()%>&name=<%=ID%>">
				<%} %><%= vo.getTitle() %></td>
				
				<td class='<%= vo.getNID() %>'><%= vo.getCnt() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getWritedate() %></td>
				<td>
					<a href ="/bbs/main?action=delete&NID=<%= vo.getNID() %>&writer=<%=vo.getWriter()%>&name=<%=ID%>">
					<img src = "/mvc/images/delete.png" width = '30'></a></td>
				<td>
					<a href = '/bbs/jspsrc/update.jsp?NID=<%=vo.getNID()%>&writer=<%=vo.getWriter()%>&name=<%=ID%>'>
					<img src = "/mvc/images/edit.png" width = '30'></a>
				</td>
			</tr>
		<%}%>
	</table>
	<%}
	
	if (request.getAttribute("msg") != null) {
	%>
		<script>
			alert('${ msg }');
		</script>
	<%}%>
	
	<hr>
	<button type = "button" onclick= "location.href = '/bbs/jspsrc/write.jsp'">게시글 작성</button>
	<hr>
	<form method = "get" action ="/bbs/main">
			검색어 : <input type = "search" name = "keyword" >
			<input type = "submit" value = "검색">
	</form>
	<hr>
	
	<% 
	if (session1.getAttribute("ID") == null){%>
		<button  type = "button" onclick= "location.href = '/bbs/jspsrc/login.jsp'" >로그인</button>
		
	<%}else {%>
		<button  type = "button" onclick= "location.href = '/bbs/main?logout=0'" >로그아웃</button>
	<%}%>
	
	<a href = '/bbs/jspsrc/signUp.jsp'>회원가입</a>
	<script>
		function displayDiv(type) {
			if(type == 1) {
				document.getElementById("search").style.display='none';	
			} else if(type == 2) {
				document.getElementById("search").style.display='block';
			}	
		}
	</script>
	
</body>
</html>