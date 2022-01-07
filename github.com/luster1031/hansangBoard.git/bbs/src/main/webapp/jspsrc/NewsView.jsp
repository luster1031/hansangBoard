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
				<td class='<%= vo.getNID() %>'><a href = "/bbs/jspsrc/view.jsp?NID=<%= vo.getNID() %>&name=hanna"><%= vo.getTitle() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getCnt() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getWritedate() %></td>
				<td><a href ='/bbs/main?action=delete&id=<%= vo.getNID() %>'>
				<img src = "/mvc/images/delete.png" width = '30'></a></td>
				<td><img onclick="displayUpdateForm('<%= vo.getNID() %>')" 
				       src="/mvc/images/edit.png" width = '30'></td>
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
	<button onclick="displayDiv(1);">미팅 정보 작성</button>
	<button onclick="displayDiv(2);">미팅 정보 검색</button>
	<script>
		function displayDiv(type) {
			if(type == 1) {
				document.getElementById("search").style.display='none';
				document.getElementById("write").style.display='block';
			} else if(type == 2) {
				document.getElementById("write").style.display='none';
				document.getElementById("search").style.display='block';
			}	
		}
		function displayUpdateForm(cv) {
		    var doms = document.getElementsByClassName(cv)
			document.getElementById("divT").textContent="미팅정보 수정";
			document.querySelector("#write [type=submit]").value="수정";
			document.querySelector("#write [type=hidden]").value=cv;
			document.getElementById("write").style.display='block';	
			document.getElementById("n_name").value = doms[1].textContent;
			document.getElementById("n_content").value = doms[2].textContent;
			document.getElementById("n_title").value = doms[3].textContent;
			//document.getElementById("n_cnt").value = doms[4].textContent;
			var str = doms[5].textContent;
			var ary = str.split(/\D+/g);
			var meeting_dt = ary[0]+"-"+ary[1]+"-"+ary[2]+
			                          "T"+ary[3]+":"+ary[4];
			
			document.getElementById("n_dt").value = meeting_dt;
		}
	</script>
	<div id="write"  style="display:none">
		<hr><h2 id="divT">게시판 작성</h2>
		<form method = "post" action = "/bbs/main">
			<input type="hidden" name="NID" value="insert">
			수정자 : <input id="n_name" type="text"  name="name">
			<br>
			게시판 제목 : <input id="n_title" type="text"  name="title"><br>
			수정할 게시판 내용: <br>
			<textarea id="n_content"  rows="3" cols="30" name = "content" ></textarea>
			<br>
			날짜와 시간 :  <input id="n_dt" type="datetime-local" name="meetingDate">
			<br>
			<input type = "submit" value = "등록">
			<input type = "reset" value = "재작성">
		</form>
	</div>
</body>
</html>