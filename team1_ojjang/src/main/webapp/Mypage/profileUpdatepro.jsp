<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/updatePro.jsp</title>
</head>
<body>
<h1>member/updatePro.jsp</h1>
<%

request.setCharacterEncoding("utf-8");
String M_id=request.getParameter("M_id");
String M_name=request.getParameter("M_name");
String M_pw=request.getParameter("M_pw");
String M_nick=request.getParameter("M_nick");
String M_phone=request.getParameter("M_phone");
String M_address=request.getParameter("M_address");
String M_address2=request.getParameter("M_address2");
String M_email=request.getParameter("M_email");


MemberDTO updateDto=new MemberDTO();
updateDto.setM_id(M_id);
updateDto.setM_name(M_name);
updateDto.setM_nick(M_nick);
updateDto.setM_phone(M_phone);
updateDto.setM_address(M_address);
updateDto.setM_address2(M_address2);
updateDto.setM_email(M_email);

 
MemberDAO dao=new MemberDAO();

MemberDTO dto=dao.M_userCheck(M_id, M_pw);
 
if(dto!=null){
	dao.updateMember(updateDto);

	response.sendRedirect("../home/main.jsp");
}else{
    %>
    <script type="text/javascript">
		alert("아이디 비밀번호 틀림");
		history.back();
    </script>
    <%
}
%>
</body>
</html>
