<!-- 
	20222.01.08
	main페이지
		
 -->
<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import = "vo.NewsVO, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>

</head>
<body>
	<%@  include  file="css.jspf"  %>
	<main>
		<section class="py-0 text-center container">
				<div class="row py-lg-0">
					<div class="col-lg-6 col-md-8 mx-auto">
						<img class="d-block mx-auto mb-4" src="/bbs/img/hansang.png" alt="" width="300" height="200">
						<p class="lead text-muted">
							안녕하십니까,
							<br>저희는 포스코ICT JAVA 전문가과정 -기 훈련생 <br>
							박상언, 임한나입니다.<br>
						</p>
						<p>
							<a href="#" class="btn btn-primary my-2">Main call to action</a>
							<a href="#" class="btn btn-secondary my-2">Secondary action</a>
						</p>
					</div>
				</div>
			 </section>
			<div class = "album py-5 bg-light">
				<div class = "container">
					<div class ="row row-cols-1 row-cols-sm-4 g-3">
						<div class = "col"></div>
						
						<div class = "col">
							<div class="card shadow-sm">
								<svg class="bd-placeholder-img card-img-top" width="100%" height="50"  role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
									<title>Placeholder</title>
									<rect width="100%" height="100%" fill="#55595c"></rect>
									<text x="36%" y="50%" fill="#eceeef" dy=".3em">임한나 후기</text>
								</svg>
								<div class="card-body">
									<p class="card-text">임한나 후기---</p>
								</div>
							</div>
						</div>
						  
						<div class = "col">
							<div class="card shadow-sm">
								<svg class="bd-placeholder-img card-img-top" width="100%" height="50" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
									<title>Placeholder</title>
									<rect width="100%" height="100%" fill="#55595c"></rect>
									<text x="36%" y="50%" fill="#eceeef" dy=".3em">박상언 후기</text>
								</svg>
								<div class="card-body">
									<p class="card-text">박상언 후기----</p>
								</div>
							</div>
						</div>
						<div class = "col"></div>
					</div>
				</div>

			</div>
	</main>
	
</body>
</html>