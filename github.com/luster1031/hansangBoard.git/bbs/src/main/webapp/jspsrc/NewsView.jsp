<!-- 
	20222.01.08
	임한나 - 로그인 여부로 write.jsp로 가기
			- 로그인 창으로 넘기기
			- 아니면, 목록 다시 보여주기
		- 로그인 했으면 회원가입 안 보여주기
		- 페이징
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
<!--  <link href="https://fonts.googleapis.com/css?family=Poor+Story:400" rel="stylesheet">-->
<style type="text/css">
    * {
    	font-family: "Poor Story"   
    }
	td{
		border-bottom : 2px dotted black;
		padding-left : 20px;
	}
	tr:hover{ 
		background-color : gray;	
		font-weight : bold;
	}
	td:nth-child(2){
		width : 300px;
	}
	a, a:hover {
		color:#000000;
		text-decoration:none;
	}
	.page{
	  text-align: center;  // div 사이즈 영역 안에서의 center
	  width: 50%;
	 }

.page_wrap {
	text-align:center;
	font-size:0;
 }
.page_nation {
	display:inline-block;
}
.page_nation .none {
	display:none;
}
.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:#999999;
	text-decoration:none;
}
.page_nation .arrow {
	border:1px solid #ccc;
}
.page_nation a.active {
	background-color:#42454c;
	color:#fff;
	border:1px solid #42454c;
}
.first:hover, .last:hover, .left:hover, .right:hover{
  color: #2e9cdf;}
.page_nation .num:hover {
  background-color: #2e9cdf;
  color: #ffffff;
  }
</style>
</head>
<body>
	<%
	List<NewsVO> list = (List<NewsVO>)request.getAttribute("list");
	
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
	
	if(request.getAttribute("now_page")!=null){
		now_page = Integer.parseInt((String)request.getAttribute("now_page"));
		end_page_num = ((int)Math.ceil(now_page/(double)button_num))*button_num;		
		start_page = end_page_num - (button_num) +1;
		next_page = end_page_num+1;	
		befor_page =start_page-button_num;
		if(request.getAttribute("list_num")!=null){
			list_num = Integer.parseInt((String)request.getAttribute("list_num"));
			total_page = (int)Math.ceil(list_num/(double)displayPage);
		//		마지막 페이징 버튼만 보이게
			if(end_page_num > total_page){
				end_page_num = total_page;
		    }
		}
		
	}
	
	HttpSession session1 = request.getSession(true);
	String ID = (String) session1.getAttribute("ID");
	if(list !=null){
	%>
	<h2>게시판</h2><hr>
	<table>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일자</th>
		<tr>	
		<%
		for(NewsVO vo : list){	
		%>
			<tr>
				<td class='<%= vo.getNID() %>'><%= vo.getNID() %></td>
				<td class='<%= vo.getNID() %>'>
				<%if(ID != null){ %>
					<a href = "/bbs/jspsrc/view.jsp?NID=<%= vo.getNID()%>&name=<%=ID%>">
				<%} %><%= vo.getTitle() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getWriter() %></td>
				
				
				<td class='<%= vo.getNID() %>'><%= vo.getCnt() %></td>
				<td class='<%= vo.getNID() %>'><%= vo.getWritedate() %></td>
				<td>
					<a href ="/bbs/main?action=delete&NID=<%= vo.getNID() %>&writer=<%=vo.getWriter()%>&name=<%=ID%>">
					<img src = "/mvc/images/delete.png" width = '30'></a></td>
				<td>
					<a href = '/bbs/jspsrc/update.jsp?NID=<%=vo.getNID()%>&writer=<%=vo.getWriter()%>&name=<%=ID%>'>
					<img src = "/mvc/images/edit.png" width = '30'></a>
				</td>
			</tr>
		<%}%>
	</table>
	<%}
	
	
	if (request.getAttribute("msg") != null) {
	%>
		<script>
			alert('${ msg }');
		</script>
	<%}
	%>
	
	<hr>
	
	<!-- 페이징 -->
	<div class="page_wrap">
		<div class="page_nation">
			<%
			if(now_page > button_num){
			%>
				<a href="/bbs/main" class="first">처음</a>
				<a href="/bbs/main?page=<%=befor_page%>" class="arrow left">←</a>
		   		
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
			   	
			   	<a href="/bbs/main?page=<%=i%>" class=<%=class_str%>><%=i%></a>
		 <%}
			    if(now_page != total_page && now_page >= 0){
			    %>	
			    	<a href="/bbs/main?page=<%=next_page%>" class="arrow right">>></a>
			    	<a href="/bbs/main?page=<%=total_page%>" class="last">끝</a>
				<%}%>
		</div>
	</div>
  
	<hr>
	<input type = "button" value="게시글 작성 " onclick= "agecheck()">
	<hr>
	<form method = "get" action ="/bbs/main">
			검색어 : 
			<select name= 'selectOption'>
				<option value="title">제목 검색</option>
				<option value="content">내용 검색</option>
				<option value="writer">작성자 검색</option>
			</select>
			<input type = "search" name = "keyword" >
			<input type = "submit" value = "검색">
	</form>
	<hr>
	
	
	<% 
	if (session1.getAttribute("ID") == null){%>
		<button  type = "button" onclick= "location.href = '/bbs/jspsrc/login.jsp'" >로그인</button>
		<button  type = "button" onclick= "location.href = '/bbs/jspsrc/signUp.jsp'">회원가입</button>
	<%}else {%>
		<button  type = "button" onclick= "location.href = '/bbs/main?logout=0'" >로그아웃</button>
	<%}%>

	<!-- 로그인 안 하고 게시글 작성할 때 -->
	<script>
	function agecheck() {
	
		<%if(ID == null){%>
			var flag = confirm("게시글을 보려면 로그인 해야합니다. 로그인하시겠습니까?");// 확인 취소 구조로 창띄움
	      	if(flag ==true) {
	       		location.href="/bbs/jspsrc/login.jsp";  //로그인 페이지로
	      	}else{
	      		location.href="/bbs/main";
	      	}
		<%}else{%>
	      	location.href="/bbs/jspsrc/write.jsp";
	    <%}%>
	}
	</script>
	
</body>
</html>