<%@page import="java.text.SimpleDateFormat"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="buy.BuyDAO" %>
<%@ page import="buy.BuyDTO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>중고의류거래: 옺장</title>
   <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../assets/css/font-awesome.css">
    <link rel="stylesheet" href="../assets/css/templatemo-hexashop.css">
    <link rel="stylesheet" href="../assets/css/owl-carousel.css">
    <link rel="stylesheet" href="../assets/css/lightbox.css"> 
   <link href="../assets/css/buyDetails.css" rel="stylesheet" type="text/css">
    <link href="../assets/css/buy.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>중고 의류거래: 옺장</title>
</head>
    <body>
    <!-- ***** 로딩 일단 지금은 비어있음***** -->
    <div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>  
    
    <!-- ***** 헤더 ***** -->
  <jsp:include page="../top.jsp" />
    <!-- ***** 헤더 끝 ***** -->
    
<%
int B_num = Integer.parseInt(request.getParameter("B_num"));
BuyDAO dao = new BuyDAO();
BuyDTO dto = dao.getBuyBoard(B_num);
String M_id = (String)session.getAttribute("M_id");

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd hh:mm");
%>
<div class="container2">
	<div class="row" style="text-align: center; ">
	<!--보내지는 내용 숨겨지도록(post) 작성한 글을 writeAction으로 보냄 -->
	<table class = "table table-striped" style="text-align:center; border:1px solid #dddddd">
		<thead>
			<tr>
				<th colspan="3"  style="background-color: #eeeeee; text-align:center">삽니다</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td style="width:20%;">글제목</td>
				<td colspan="2"><%= dto.getB_title()%></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td colspan="2"> <%= dto.getM_id() %></td>
			</tr>
			<tr>
				<td>작성일자</td>
				<td colspan="2"> <%= dateFormat.format(dto.getB_time())%> </td>
			</tr>
			<tr>
				<td>글내용</td>
				<td colspan="2"  style="min-height: 200px; text-align:left;"> <%= dto.getB_text() %></td>
			<tr><td colspan="2">
</tr>
</tbody>		
</table>
<!-- 댓글시작 -->
<div id="comment"  style="text-align: center;" >
<form method="post" action="commentAction.jsp?B_num=<%=B_num%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeeee; text-align: center;">댓글</th>
						</tr>
					</thead>
					<tbody>
					
						<%
						int pageNumber=1;
						// pageNumber는 URL에서 가져온다.
						if(request.getParameter("pageNumber")!=null){
							pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
						}
							CommentDAO comment=new CommentDAO();
							ArrayList<CommentDTO> List=comment.getList(B_num, pageNumber);
							for(int i=List.size()-1 ; i>=0 ; i--){
						%>

						<tr>
							<td style="text-align: left;"><%=List.get(i).getCo_text() %></td>
							<td style="text-align: right;"><%=List.get(i).getM_id() %></td>
							<td><a href=# onclick = "return coupdate();" class="btn">수정</a>
									<script text="text/javascript">
								function coupdate(Co_num){
									window.name ="buydetails";
									window.open("commentupdateForm.jsp?Co_num="+<%=List.get(i).getCo_num()%>,
											"updateForm", "width=570, height=350, resizable=no, scrollbars=no");
								}
									</script>
							</td>
							<td>
							<a href="commentdeleteAction.jsp?B_num=<%=B_num %>&Co_num=<%=List.get(i).getCo_num() %>"
								onclick="return delchk();" class="btn">삭제</a>
									<script type="text/javascript">
								function delchk(){return confirm("삭제하시겠습니까?");}
									</script>
							</td> 
						</tr>
		
						<%
								}
						%>
			<td>
			<div class="btn-naran">
				<textarea type="text" class="form-control"
				placeholder="댓글을 입력하세요." name="Co_text" 
				maxlength="2048" style="width:800px;height:100px;font-size:15px;"></textarea>
				<input type="submit" class="btn btn-dark" value="댓글입력">
			</div>
			</td>

					
					</tbody>
				</table>
				
			</form>
			</div>
	</div>
<!-- 댓글끝 -->

			<div class="btn-naran">
<%
if(M_id != null){
	// 세션값=id와 글쓴이가 일치해야만 글수정, 글삭제 표시
	if(M_id.equals(dto.getM_id())){
		%>
<input type="button" class="btn btn-dark" value="글수정" onclick="location.href='buyEdit.jsp?num=<%=dto.getB_num() %>'">
<input type="button" class="btn btn-dark" value="글삭제" onclick="location.href='buyDelete.jsp?num=<%=dto.getB_num() %>'"> 
		<%		
	}
}
%>
	<button type="button" class="btn btn-dark" onclick="location.href='buyList.jsp'" ">글목록</button>
</div>
</div>
<!-- ***** 푸터 시작 ***** -->
<jsp:include page="../bottom.jsp" />
    <!-- ***** 푸터 끝 ***** -->

 <!-- jQuery -->
    <script src="../assets/js/jquery-2.1.0.min.js"></script>

 <!--  Bootstrap -->
    <script src="../assets/js/popper.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>

 <!-- Plugins -->
    <script src="../assets/js/owl-carousel.js"></script>
    <script src="../assets/js/accordions.js"></script>
    <script src="../assets/js/datepicker.js"></script>
    <script src="../assets/js/scrollreveal.min.js"></script>
    <script src="../assets/js/waypoints.min.js"></script>
    <script src="../assets/js/jquery.counterup.min.js"></script>
    <script src="../assets/js/imgfix.min.js"></script> 
    <script src="../assets/js/slick.js"></script> 
    <script src="../assets/js/lightbox.js"></script> 
    <script src="../assets/js/isotope.js"></script> 
    
<!-- Global Init -->
    <script src="../assets/js/custom.js"></script>

    <script>

        $(function() {
            var selectedClass = "";
            $("p").click(function(){
            selectedClass = $(this).attr("data-rel");
            $("#portfolio").fadeTo(50, 0.1);
                $("#portfolio div").not("."+selectedClass).fadeOut();
            setTimeout(function() {
              $("."+selectedClass).fadeIn();
              $("#portfolio").fadeTo(50, 1);
            }, 500);
                
            });
        });

    </script> 
   
	
</body>
</html>