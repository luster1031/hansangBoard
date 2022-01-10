<%@page import="dao.NewsDAO"%>
<%@page import="javax.script.ScriptContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.NewsVO, java.util.*, java.io.*, vo.CommentVO, dao.CommentDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 내용 보기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
	<%@  include  file="css.jspf"  %>
	<%
	int NID = 0;
	String name = "";
	NID = Integer.parseInt(request.getParameter("NID"));
	name = request.getParameter("name");


	if (NID == 0 || name.equals("")) {
		request.getRequestDispatcher("/jspsrc/signUp.jsp").forward(request, response);
	}
	NewsDAO dao = new NewsDAO();
	NewsVO list = new NewsDAO().listOne(NID);
	if (list != null) {	
		list.setCnt(1);
		System.out.println("[글쓰기]cnt : " + list.getCnt());
		dao.update(list);
	%>
	<div class="container">	
	<table class="table table-bordered">
		
		<h2>게시글 보기</h2>
		<tbody>
			<tr>
				<th scope="row" style="width: 20%;">글제목</th>
				<td colspan="2"><%=list.getTitle()%></td>
			</tr>
			<tr>
				<th scope="row">작성일자</th>
				<td colspan="2"><%=list.getWritedate()%></td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td colspan="2" style="min-height: 200px; text-align: left;">
					<%
					// 줄 바꿈
					String content = list.getContent();
					if(content.length()>max_size){
						for(int i = 0; i<content.length()-max_size;i+=max_size){%>
							<%=content.substring(i, i+max_size)%><br>
						<%}
					}else{%>
					<%=content %>
				<% }%>
			</tr>
		</tbody>
	</table>
	
	<%
	if (name.equals(list.getWriter()) || name.equals("admin")) {
		%>
		<div class="row flex-nowrap justify-content-between align-items-center py-3">
			<div class="col-4 pt-1">
				<a class="btn btn-outline-dark" role="button" onclick="myComment()" style="width: 40%; padding: 5px;">댓글</button></a>
			</div>
			<div class="col-4 text-center">
				<a class="blog-header-logo text-dark" href="#"></a>
			</div>
			<div class="col-4 text-center">
				<a class="btn btn-success" href="/bbs/jspsrc/update.jsp?NID=<%=list.getNID()%>&writer=<%=list.getWriter()%>&name=<%=ID%>"
					role="button"style="width: 40%; padding: 5px;">수정</a>
				
				<a class="btn btn-danger" href="/bbs/main?keyword=listPage&action=delete&NID=<%=list.getNID()%>&writer=<%=list.getWriter()%>&name=<%=ID%>" 
				role="button" onclick="return confirm('Are you sure, you want to delete it?')" style="width: 40%; padding: 5px;">삭제</a>
				
			</div>
		</div>
		
	<%}
	System.out.println("[ID] : "+ list.getNID());
	if(ID != null){%>
	
		<script type="text/javascript">
			//새로 고침 시 재 등록 방지
			function notReload(){
			    if((event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) ){
			         event.keyCode = 0;
			         event.cancelBubble = true;
			         event.returnValue = false;
			         var frm = document.addForm;
			         frm.action = "/bbs/main?keyword=listPage";
			         frm.submit();
			    }
			}
			window.onpageshow =  function(event) {
			    //back 이벤트 일 경우
			    if (event.persisted) {
			    	document.location.reload();
			    }
			}
			document.onkeydown = notReload;
		</script>
		<form method="post" onsubmit="return jbSubmit();" action = "/bbs/main?keyword=listPage">
			<input type="hidden" name="action" value="comment">
			<input type="hidden" name="name" value="<%=ID%>">
			<input type="hidden" name="NID" value="<%=list.getNID()%>">
		
		
			<div class="card mb-5">
				<div class="card-header bg-light">
				        <i class="fa fa-comment fa"></i>댓글
				</div>
				<div class="card-body">	
					<ul class="list-group list-group-flush">
					    <li class="list-group-item">
					    <%=ID %>님 댓글을 입력하세요!
						<textarea class="form-control" name = "content" id="exampleFormControlTextarea1" rows="3" placeholder="댓글을 입력하세요"></textarea>
						<input type="text" style="display:none;"/>	<!-- 의미없는 텍스트 박스 -->
						<button type="submit" class="btn btn-dark mt-3" ​>작성</button>
						<button type="reset" class="btn btn-white mt-3">재작성</button>
					    </li>
					</ul>
				</div>
			</div>
			
		</form>	
	
	<script>
		function myComment() {
			document.getElementById("com").style.display = 'block';
		}
	</script>
	<%}
	CommentDAO com_dao = new CommentDAO();
	List<CommentVO> comment_list = new CommentDAO().listAll(list.getNID());
	if(comment_list != null && comment_list.size()!=0){%>
		댓글 수 : <%=comment_list.size() %>
		<section id = "com"class="mb-5 "style="display: none">
			<div class="card bg-light">
				<div class="card-body">
				<%for(CommentVO vo : comment_list){ %>
					<div class="d-flex mb-4">
						<div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
						<div class="ms-3">
							<div class="fw-bold"> <%=vo.getWriter() %></div>
							<%
								content = vo.getContent();
								if(content.length()>max_size){
									for(int i = 0; i<content.length()-max_size;i+=max_size){%>
										<%=content.substring(i, i+max_size)%><br>
									<%}
								}else{%>
									<%=content %>
								<% }%>
						</div>
					</div>
					<%}%>
				</div>
			</div>
		</section>
	
	<%}
}%>

</div>
</body>
</html>