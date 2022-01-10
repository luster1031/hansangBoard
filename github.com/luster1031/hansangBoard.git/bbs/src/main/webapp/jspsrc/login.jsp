<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>로그인</title>

    <!-- Bootstrap core CSS -->
	<link href="/bbs/css/bootstrap.min.css" rel="stylesheet">

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
 
    <!-- Custom styles for this template -->
    <link href="/bbs/css/signin.css" rel="stylesheet">
</head>
<body class="text-center">
	<main class="form-signin">
		<form method = "post" action = "/bbs/main?keyword=listPage" >
			<input type="hidden" name="action" value="select">
			<img src="/bbs/img/hansang.png" alt="" width="300" height="200">
			
			<div class="shadow-lg p-3 mb-2 bg-body rounded">	
			    <h1 class="h3 fw-bolder">로그인하세요</h1>
				<div class="form-floating mb-1">
		      		<input type="text" class="form-control" id="floatingInput" name="id" placeholder="아이디를 입력하세요">
		      		<label for="floatingInput">input your id</label>
		    	</div>
		    	<div class="form-floating">
		      		<input type="password" class="form-control" id="floatingPassword" name="password" placeholder="비밀번호를 입력하세요">
		      		<label for="floatingPassword">Password</label>
		   		 </div>
		   		 <button class="w-100 p-2 btn btn-lg btn-secondary" type="submit">Sign in</button>
	   		 </div>
	   		<div class="d-grid gap-1">
	    		<div class="d-grid gap-1 d-md-block">
	    			<button class="w-30 p-2 btn btn-dark" type="reset"  onclick="location.href='/bbs/main?keyword=listPage'" >게시글보기</button>
					<button class="w-30 p-2 btn btn-outline-dark"type="button" >재작성</button>
				</div>
			</div>
		</form>		
	</main>
</body>
</html>
  