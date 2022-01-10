
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- include libraries(jQuery, bootstrap) -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>글쓰기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<style>
input[name="customFile"] {
  width: 40px;
}
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

<body class="bg-light test-center">
<%@  include  file="css.jspf"  %>
	<div class="container d-flex justify-content-center">
		<div class="shadow-lg p-3 mb-2 bg-body rounded">
			<main role="main" class="container">
				<h1 class="py-1 text-center fw-bolder">글쓰기</h1>
				<form name="form" method="POST" action="/bbs/main?keyword=listPage">
					<input type="hidden" name="sign" value="false"> <input
						type="hidden" name="action" value="insert">

					<div class="pt-1"></div>
					<input type="text" name="title" placeholder="제목을 입력하세요"
						style="border-radius: 5px; width: 100%; padding: 5px;">

					<div class="pt-1">
						<textarea id="summernote" name="content"></textarea>
					</div>
					<script>
						$('#summernote').summernote({
							placeholder : '내용을 입력해주세요',
							tabsize : 2,
							height : 300
						});
					</script>
					
					<div class="py-2">
					    <div class="custom-file">
					        <input type="file" class="custom-file-input" id="customFile" multiple lang="ar" dir="rtl">
					        <label class="custom-file-label text-left" for="customFile">파일을 선택하세요</label>
					    </div>
					</div>
					<script type="text/javascript">
					$('.custom-file input').change(function (e) {
					    var files = [];
					    for (var i = 0; i < $(this)[0].files.length; i++) {
					        files.push($(this)[0].files[i].name);
					    }
					    $(this).next('.custom-file-label').html(files.join(', '));
					});
					</script>
					
					<div class="pt-1 text-right">
						<button class="btn btn btn-success" type="submit"
							style="width: 10%; padding: 5px;">제출</button>
					</div>
				</form>
			</main>
		</div>
	</div>

</body>
</html>