<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, 그리고 Bootstrap 기여자들">
<meta name="generator" content="Hugo 0.88.1">
<title>회원가입</title>

<link rel="canonical"
	href="https://getbootstrap.kr/docs/5.1/examples/checkout/">

<!-- Bootstrap core CSS -->
<link href="/bbs/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<meta name="theme-color" content="#7952b3">
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>


<!-- Custom styles for this template -->
<link href="/bbs/css/form-validation.css" rel="stylesheet">
</head>
</head>
<body class="bg-light test-center">
	<div class="container d-flex justify-content-center">
		<main>
			<div class="py-3 text-center">
				<img class="d-block mx-auto mb-2" src="/bbs/img/hansang.png" alt=""
					width="250" height="150">
			</div>
			<div class="shadow-lg p-3 mb-2 bg-body rounded" style="width: 532px;">
				<h1 class="py-1 text-center fw-bolder">sing Up!</h1>
				
				<div class="py-1">
					<form method="post" action="/bbs/main?keyword=listPage"
						class="needs-validation" novalidate="">
						<input type="hidden" name="action" value="insert"> <input
							type="hidden" name="sign" value="true">
						<div class="row g-3">
							<div>
								<label for="id" class="form-label">아이디</label>
								<div class="input-group has-validation">
									<span class="input-group-text">ID</span> <input type="text"
										class="form-control" name="id" id="username"
										placeholder="ID입력" required>
									<div class="invalid-feedback">!!아이디를 입력해주세요!!</div>
								</div>
							</div>

							<div>
								<label for="pw" class="form-label">비밀번호</label> <input
									type="password" class="form-control" id="name" name="password"
									placeholder="비밀번호를 입력하세요" required="">
								<div class="invalid-feedback">비밀번호를 입력해주세요!</div>
							</div>

							<div>
								<label for="name" class="form-label">이름</label> <input
									type="text" class="form-control" id="name" name="name"
									placeholder="이름을 입력하세요" required="">
								<div class="invalid-feedback">이름을 입력해주세요!</div>
							</div>
							<div>
								<label for="number" class="form-label">전화번호</label> <input
									type="text" class="form-control" id="name" name="phone"
									placeholder="전화번호를 입력하세요" required="">
								<div class="invalid-feedback">전화번호를 입력해주세요!</div>
							</div>

							<hr>
							<button class="w-100 btn btn-primary btn-lg " type="submit">등록</button>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
</body>
</html>