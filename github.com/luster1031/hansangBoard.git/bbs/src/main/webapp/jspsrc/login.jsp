<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한상-로그인</title>
<style type="text/css">
* {
	box-sizing: border-box;
}
 
*:focus {
	outline: none;
}
body {
	font-family: Arial;
	background-color: #3498DB;
	padding: 50px;
}
.login {
margin: 20px auto;
width: 300px;
}
.login-screen {
background-color: #FFF;
padding: 20px;
border-radius: 5px
}
 
.app-title {
text-align: center;
color: #777;
}
 
.login-form {
text-align: center;
}
.control-group {
margin-bottom: 10px;
}
 
input {
	text-align: center;
	background-color: #ECF0F1;
	border: 2px solid transparent;
	border-radius: 3px;
	font-size: 16px;
	font-weight: 200;
	padding: 10px 0;
	width: 250px;
	transition: border .5s;
}
 
input:focus {
border: 2px solid #3498DB;
box-shadow: none;
}
 
.btn {
  border: 2px solid transparent;
  background: #3498DB;
  color: #ffffff;
  font-size: 16px;
  line-height: 25px;
  padding: 10px 0;
  text-decoration: none;
  text-shadow: none;
  border-radius: 3px;
  box-shadow: none;
  transition: 0.25s;
  display: block;
  width: 250px;
  margin: 0 auto;
}
 
.btn:hover {
  background-color: #2980B9;
}
 
.login-link {
  font-size: 12px;
  color: #444;
  display: block;
	margin-top: 12px;
}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

</head>
<body>
	<form method = "post" action = "/bbs/main">
		<input type="hidden" name="action" value="select">
		<div class="login">
			<div class="login-screen">
				<div class="app-title">
					<h1>한상 - Login</h1>
				</div>
			<div class="login-form">
				<div class="control-group">
					<input type="text" class="login-field" value="" placeholder="아이디" name="id">
					<label class="login-field-icon fui-user" for="login-name"></label>
				</div>
				<div class="control-group">
					<input type="password" class="login-field" value="" placeholder="비밀번호" name="password">
					<label class="login-field-icon fui-lock" for="login-pass"></label>
				</div>
                <input type="submit" value="Log in" class="btn btn-primary btn-large btn-block" >
			    <br>
			</div>
		</div>
	</div>
	<button type="reset"  onclick="location.href='/bbs/main'" class="btn btn-dark">이전페이지로 가기</button>
	<button type="button" class="btn btn-outline-dark">재작성</button>
</form>
</body>
</html>