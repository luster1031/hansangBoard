<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>	
	
	<div id="writer"  style="display:block">
			<hr><h2 id="divT">게시판 수정</h2>
			<form method = "post" action = "/bbs/main">
				<input type="hidden" name="action" value="update">
				수정자 : <input id="n_name" type="text"  name="name">
				<br>
				게시판 제목 : <input id="n_title" type="text"  name="title"><br>
				수정할 게시판 내용: <br>
				<textarea id="n_content"  rows="3" cols="30" name = "content" ></textarea>
				<br>
				날짜와 시간 :  <input id="m_dt" type="datetime-local" name="meetingDate">
				<br>
				<input type = "submit" value = "수정">
				<input type = "reset" value = "재작성">
			</form>
	</div>
</body>
</html>