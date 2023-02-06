<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
	<title>중고의류거래: 옺장</title>
</head>
<body>
<h3>회원목록조회</h3>
<%
request.setCharacterEncoding("utf-8");
MemberDTO dto=new MemberDTO();
MemberDAO dao=new MemberDAO();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
int pageSize=10;
String pageNum=request.getParameter("pageNum");
if(pageNum==null){pageNum="1";}
int currentPage=Integer.valueOf(pageNum);
int startRow=(currentPage-1)*pageSize+1;
int endRow=startRow+pageSize-1;
ArrayList<MemberDTO> adUserList=dao.adUserList(startRow,pageSize);
String info = request.getParameter("info");
String search = request.getParameter("search");
ArrayList<MemberDTO> searchMemberList=dao.adUserListPro(info, search);
%>
<section>
<div class="container">
	<div>
	<form action="adUserListPro.jsp" method="post">
		<ul>
		<li><label>검색어</label>
		<select name="info">
		<option value="null">선택</option>
		<option value="M_id">아이디</option>
		<option value="M_name">이름</option>
		<option value="M_nick">닉네임</option>
		</select>
		<input type="text" name="search"></li>
		<li><input type="submit" value="검색"></li>
		</ul><br>
	</form>
		<div>
		검색결과 : <%=searchMemberList.size() %>명 / 총 <%=adUserList.size() %>명
		</div>
	</div>
<form action="#.jsp" method="post">
<table border="1">
<tr><td><input type="checkbox" id="ckAll" name="ckAll"></td><td>번호</td><td>아이디</td><td>이름</td><td>닉네임</td><td>가입날짜</td><td>상태</td><td>관리</td></tr>
<%
for(int i=0;i<searchMemberList.size();i++){
	dto=searchMemberList.get(i);
%>
	<tr><td><input type="checkbox" id="ck" name="id" value="<%=dto.getM_id() %>"></td>
		<td><%=i+1 %></td>
		<td><%=dto.getM_id() %></td>
		<td><%=dto.getM_name() %></td>
		<td><%=dto.getM_nick() %></td>
		<td><%=dateFormat.format(dto.getM_createdate()) %></td>
		<td><%=dto.getM_play() %></td>
		<td><a href="#">관리</a></td></tr>
<%
}
%>
</table>
<%
int pageBlock=10;
int startPage=(currentPage-1)/pageBlock*pageBlock+1;
int endPage=startPage+pageBlock-1;
int count=dao.adUserCount();
int pageCount=count/pageSize+(count%pageSize==0?0:1);
if(endPage>pageCount){endPage=pageCount;}
for(int i=startPage;i<=endPage;i++){
if(startPage > pageBlock){
%>
<a href="adUserListPro.jsp?pageNum=<%=startPage-pageBlock%>">[10페이지 이전]</a>
<%
}
%>
<a href="adUserListPro.jsp?pageNum=<%=i %>"><%=i %></a>
<%
}
if(endPage < pageCount){
%>
<a href="adUserListPro.jsp?pageNum=<%=startPage+pageBlock%>">[10페이지 다음]</a>
<%
}
%>
<div>
회원 처리 <input type="submit" value="탈퇴">
</div>
</form>
</div>
</section>
</body>
</html>