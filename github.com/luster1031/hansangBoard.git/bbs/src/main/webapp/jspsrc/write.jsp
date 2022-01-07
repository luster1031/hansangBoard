<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한상-글 작성</title>
</head>
<body>
<h1>글 작성 페이지</h1>
	
	<form method = "post" action = "/bbs/main">
	<input type="hidden" name="sign" value="false">
	>
	<input type="hidden" name="action" value="insert">
	제목  : <input  type="text"  name="title">
	<br>
	<textarea rows=10 cols=35 name="content"></textarea>
	<br>
	<input type="submit" value="작성">
	<input type="reset" value="재작성">
</form>
</body>
</html>