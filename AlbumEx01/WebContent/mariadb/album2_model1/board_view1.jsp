﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="model1.BoardDAO"%>
<%@ page import="model1.BoardTO"%>
<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding("utf-8");
	
	String cpage = request.getParameter("cpage");
	String seq = request.getParameter("seq");
	
	BoardTO to = new BoardTO();
	to.setSeq(seq);
	
	BoardDAO dao = new BoardDAO();
	to = dao.boardView(to);
	
	String subject = to.getSubject();
	String writer = to.getWriter();
	String mail = to.getMail();
	String wip = to.getWip();
	String wdate = to.getWdate();
	String hit = to.getHit();
	String content = to.getContent();
	String filename = to.getFilename();
	long filesize = to.getFilesize();

	ArrayList<ArrayList> prevNext = dao.findPrevNext(seq);
	String prevSeq = (String)prevNext.get(0).get(0);
	String prevSubject = (String)prevNext.get(0).get(1);
	
	String nextSeq = (String)prevNext.get(1).get(0);
	String nextSubject = (String)prevNext.get(1).get(1);
%>		
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/board_view.css">
</head>

<body>
<!-- 상단 디자인 -->
<div class="contents1"> 
	<div class="con_title"> 
		<p style="margin: 0px; text-align: right">
			<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 커뮤니티 &gt; <strong>여행지리뷰</strong>
		</p>
	</div>

	<div class="contents_sub">	
	<!--게시판-->
		<div class="board_view">
			<table>
			<tr>
				<th width="10%">제목</th>
				<td width="60%"><%= subject %>(<%= wip %>)</td>
				<th width="10%">등록일</th>
				<td width="20%"><%= wdate %></td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><%= writer %></td>
				<th>조회</th>
				<td><%= hit %></td>
			</tr>
			<tr>
				<td colspan="4" height="200" valign="top" style="padding:20px; line-height:160%">
					<div id="bbs_file_wrap">
						<div>
							<img src="../../upload/<%= filename %>" width="900" onerror="" /><br />
						</div>
					</div>
					<%= content %>
				</td>
			</tr>			
			</table>
		</div>
		<div class="btn_area">
			<div class="align_left">			
				<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_list1.jsp?cpage=<%= cpage %>'" />
			</div>
			<div class="align_right">
				<input type="button" value="수정" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_modify1.jsp?cpage=<%= cpage %>&seq=<%= seq %>'" />
				<input type="button" value="삭제" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_delete1.jsp?cpage=<%= cpage %>&seq=<%= seq %>'" />
				<input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='board_write1.jsp?cpage=<%= cpage %>'" />
			</div>	
		</div>
		<!--//게시판-->
		
				<!-- 이전글 / 다음글 -->
		<div class="next_data_area">
			<% 
				if(nextSeq.equals("-1")){
					out.println("<span class='b'>다음글 | </span> 다음글이 없습니다.");
				} else {
					out.println("<span class='b'>다음글 | </span> <a href='board_view1.jsp?cpage="+cpage+"&seq="+nextSeq+"'>"+nextSubject+"</a>");
				}
			%>
		</div>
		<div class="prev_data_area">
			<% 
				if(prevSeq.equals("-1")){
					out.println("<span class='b'>이전글 | </span> 이전글이 없습니다.");
				} else {
					out.println("<span class='b'>이전글 | </span> <a href='board_view1.jsp?cpage="+cpage+"&seq="+prevSeq+"'>"+prevSubject+"</a>");
				}
			%>
		</div>
		<!-- //이전글 / 다음글 -->
	</div>
<!-- 하단 디자인 -->
</div>

</body>
</html>
