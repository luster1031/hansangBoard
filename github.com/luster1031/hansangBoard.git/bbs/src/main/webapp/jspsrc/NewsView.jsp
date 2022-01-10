<!-- 
	20222.01.08
	임한나 - 로그인 여부로 write.jsp로 가기
			- 로그인 창으로 넘기기
			- 아니면, 목록 다시 보여주기
		- 로그인 했으면 회원가입 안 보여주기
		- 페이징
		- 게시글 수 출력 : 전체, 검색시 나오는 수
 -->
<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import = "vo.NewsVO, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록 보기</title>

</head>
<body>
	<script type="text/javascript">
	window.onpageshow =  function(event) {
	    //back 이벤트 일 경우
	    if (event.persisted) {
	    	document.location.reload();
	    }
	}
	</script>
	<%@  include  file="css.jspf"  %>

	<%
	List<NewsVO> list = (List<NewsVO>)request.getAttribute("list");
	String keyword = "listPage";

	if(request.getAttribute("keyword")!=null)
		keyword = (String)request.getAttribute("keyword");
	String option = (String)request.getAttribute("option");
	//페이징
	int now_page = 1;		//	현재 페이지 번호
	int displayPage = 5;	//	한페이지에 게시글 5개  
	int button_num = 5;		//	한페이지에 버튼 5개
	int next_page = button_num+1;		//	>>버튼 누르면 가야하는 페이지번호
	int befor_page = 1;				//	<<버튼 누르면 가야하는 번호
	int end_page_num = button_num;	//	페이징 마지막 숫자
	int start_page = 1;			//	페이징 시작 숫자
	int list_num = 0;	// 전체 테이블의 게시글 개수
	int total_page = 0;	//	최대 페이징 번호
	if(request.getAttribute("list_num")!=null){
		list_num = Integer.parseInt((String)request.getAttribute("list_num"));
		total_page = (int)Math.ceil(list_num/(double)displayPage);
	}
	if(request.getAttribute("now_page")!=null){
		now_page = Integer.parseInt((String)request.getAttribute("now_page"));
		end_page_num = ((int)Math.ceil(now_page/(double)button_num))*button_num;		
		start_page = end_page_num - (button_num) +1;
		next_page = end_page_num+1;	
		befor_page =start_page-button_num;	
	}
//	마지막 페이징 버튼만 보이게
	if(end_page_num > total_page){
		end_page_num = total_page;
		next_page = end_page_num;
    }
	if(list !=null){
	%>
	<div class="container">
	<h2>게시판</h2>
	
	<table class ="table table-hover">
		<%if(request.getParameter("selectOption")!=null){ %>
			<caption class="left_coption">검색 게시글 수 : <%=list.size()%></caption>
		<%}else{ %>
			<caption class="left_coption">전체 게시글 수 : <%=list_num%></caption>
		<%} %>
		<thead class="table-dark table-responsive">
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">조회수</th>
				<th scope="col">작성일자</th>
				<th scope="col"> </th>
			</tr>
		</thead>
		<%
		for(NewsVO vo : list){	
		%>	
		<tbody>	
			<tr>
				<th scope="row" class='<%= vo.getNID() %>'><%= vo.getNID() %></th>
				<td>
					<%if(ID != null){ %>
						<a href = "/bbs/main?keyword=list&action=comment&NID=<%= vo.getNID()%>&name=<%=ID%>">
					<%}%><%= vo.getTitle() %>
				</td>
				<td><%= vo.getWriter() %></td>
				<td><%= vo.getCnt() %></td>
				<td><%= vo.getWritedate() %></td>
				<%if(ID!=null&&(ID.equals(vo.getWriter()) || ID.equals("admin"))){ %>
					<td>
						<button  type = "button" class="btn btn-dark" onclick= "location.href =  '/bbs/main?keyword=listPage&action=delete&NID=<%= vo.getNID() %>&writer=<%=vo.getWriter()%>&name=<%=ID%>'" >삭제</button> 
						<button type="button" class="btn btn-outline-dark"onclick= "location.href = '/mvc/images/delete.png'">수정</button>
					</td>
				<%}else{ %>
				<td></td>
				<%} %>
			</tr>
		</tbody>
		
		<%}%>	
		
		</table>

	</div>		
	<%}

	
	if (request.getAttribute("msg") != null) {
	%>
		<script>
			alert('${ msg }');
		</script>
	<%}
	%>
	
	<div class="container">		
		<footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-2 border-top">
			<div class="col-md-1 d-flex align-items-center">
				<a href="/" class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1"></a>
			</div>
			<form method = "get" action ="/bbs/main">
					<div class="input-group mb-3">
						<select class="form-select" aria-label="Default select example" name= 'selectOption'>
							<option value="title">제목 검색</option>
							<option value="content">내용 검색</option>
							<option value="writer">작성자 검색</option>
						</select>
						<input name = "keyword" type="search" class="form-control" placeholder="Search" aria-label="Recipient's username" aria-describedby="button-addon2">
						<input class="btn btn-outline-secondary" type="submit" id="button-addon2" value = "검색">
					</div>
			</form>
			<ul>
				<input type = "button" class="btn btn-outline-dark text-end" value="게시글 작성 " onclick= "agecheck()">
			</ul>
		</footer>
	</div>
	<!-- 페이징 -->
	<div class="page_wrap">
		<div class="page_nation">
			<%
			if(now_page > button_num){
			%>
				<a href="/bbs/main?keyword=<%=keyword%>" class="first">처음</a>
				<a href="/bbs/main?keyword=<%=keyword%>&page=<%=befor_page%>" class="arrow left">←</a>
		   		
		   	<%
			}
		   	String class_str = "num";
		   	System.out.println(start_page);
		   	System.out.println(end_page_num);
		   	
			for(int i = start_page; i<=end_page_num; i++){
				if(now_page == i){
		   			class_str = "active num";
		   		}else
		   			class_str = "num";%>
			   	
			   	<a href="/bbs/main?keyword=<%=keyword%>&page=<%=i%>&option=<%=option%>" class=<%=class_str%>><%=i%></a>
		 <%}
		    if(now_page != total_page && now_page >= 0 && next_page!=total_page){
		    %>	
		    	<a href="/bbs/main?keyword=<%=keyword%>&page=<%=next_page%>&option=<%=option%>" class="arrow right">>></a>
		    	<a href="/bbs/main?keyword=<%=keyword%>&page=<%=total_page%>&option=<%=option%>" class="last">끝</a>
			<%}%>
		</div>
	</div>

	<!-- 로그인 안 하고 게시글 작성할 때 -->
	<script>
	function agecheck() {
	
		<%if(ID == null){%>
			var flag = confirm("게시글을 보려면 로그인 해야합니다. 로그인하시겠습니까?");// 확인 취소 구조로 창띄움
	      	if(flag ==true) {
	       		location.href="/bbs/jspsrc/login.jsp";  //로그인 페이지로
	      	}else{
	      		location.href="/bbs/main?keyword=listPage";
	      	}
		<%}else{%>
	      	location.href="/bbs/jspsrc/write.jsp";
	    <%}%>
	}
	</script>
	
</body>
</html>