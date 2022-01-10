<!-- 
	게시판 수정
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.NewsVO,dao.NewsDAO, java.util.*, java.io.*, java.util.Date" %>
<%@ page import = "java.text.DateFormat, java.text.SimpleDateFormat"%>

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
<body class="bg-light test-center">
<%@  include  file="css.jspf"  %>
	<div class="container d-flex justify-content-center">
		<div class="shadow-lg p-3 mb-2 bg-body rounded">
			<main role="main" class="container">
			<%
			int NID = 0;
			String name = request.getParameter("name");
			String writer = request.getParameter("writer");
			if(request.getParameter("NID")!= null){
				NID = Integer.parseInt(request.getParameter("NID"));
			}
			if(NID == 0){
				out.println("<script>");
				out.println("alert('유효하지 않는 글입니다.'");
				out.println("location.href = 'signUp.jsp'");
				out.println("</script>");
			}
			NewsVO list  = new NewsDAO().listOne(NID);
			if(list != null && writer.equals(name)){
			%>
				<h1 class="py-1 text-center fw-bolder">수정하기</h1>
				<form name="form" method="POST" action="/bbs/main?keyword=list">
					<input type="hidden" name="action" value="update">
					<input type="hidden" name="NID" value=<%=NID%>>
					<input type="hidden" name="name" value=<%=name%>>
					<input type="hidden" name="writer" value=<%=writer%>>
					<div class="pt-1"></div>
					<input type="text" name="title" placeholder="제목을 입력해서 수정해주세요!" value=<%=list.getTitle()%>
							style="border-radius: 5px; width: 100%; padding: 5px;">
					  
					  <%
						String writedate= list.getWritedate();
						writedate = writedate.replace(" ", "T");
						%>
						<input id="n_dt" type="datetime-local" name="meetingDate" value=<%=writedate%>>
						<br>    
						<div class="pt-1">
							<textarea id="summernote" name="content">
								<%=list.getContent() %>
							</textarea>
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
								style="width: 10%; padding: 5px;">수정</button>
						</div>
						<div class="container">
					
      <script type="text/javascript">
         $(function () {
             $('#datetimepicker5').datetimepicker({
                 defaultDate: "11/1/2013",
                 disabledDates: [
                     moment("12/25/2013"),
                     new Date(2013, 11 - 1, 21),
                     "11/22/2013 00:53"
                 ]
             });
         });
      </script>
   </div>

				</form>
			</main>
		</div>
					
		<%}else{
			request.setAttribute("msg","수정이 안됨 ㅠㅠ");
			request.getRequestDispatcher("/main?keyword=list").forward(request, response);
		} %>
	</div>
</body>
</html>