<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한상-로그인</title>
</head>
<body>
	<h1>로그인페이지</h1>
	<hr>
	<form method = "post" action = "/bbs/main">
	<input type="hidden" name="action" value="select">
	아이디  : <input  type="text"  name="id">
	<br>
	비밀번호 : <input type="password"  name="password">
	<br>
	<input type = "submit" value = "등록">
	<input type = "reset" value = "재작성">
	<button type="button" onclick="location.href='/bbs/jspsrc/login.jsp' ">이전 페이지 보기</button>
	</form>
</body>
</html>