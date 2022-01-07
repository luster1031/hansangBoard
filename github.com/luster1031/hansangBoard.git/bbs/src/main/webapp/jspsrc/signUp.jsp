<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한상-회원가입</title>
</head>
<body>
	<h1>회원가입페이지</h1>
	<hr>
	<form method = "post" action = "/bbs/main">
	<table>
	<tr id="hidden" style="display:none;">
	<th><input type="hidden" name="action" value="insert"></th>
	<th><input type="hidden" name="sign" value="true"></th>
	</tr>
	<tr>
	<td>아이디  : <input  type="text" width="10" name="id"></td>
	</tr>
	<tr>
	<td>비밀번호 : <input type="password" width="10"  name="password"></td>
	</tr>
	<tr>
	<td>이름 : <input type="text" width="10"  name="name"></td>
	</tr>
	<tr>
	<td>전화번호 : <input type="text" width="10" name="phone"></td>
	</tr>
	<tr>
	<td><input type = "submit" value = "등록"></td>
	<td><input type = "reset" value = "재작성"></td>
	</tr>
	</table>
	</form>
</body>
</html>