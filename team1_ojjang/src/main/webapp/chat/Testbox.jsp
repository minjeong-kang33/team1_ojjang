<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
   String M_id = null;
   if(session.getAttribute("M_id") != null) {
	   M_id = (String) session.getAttribute("M_id");
   }
   if(M_id == null) {
	  session.setAttribute("messageType", "오류 메시지");
	  session.setAttribute("messageContent", "현재 로그인이 되어 있지 않습니다.");
	  response.sendRedirect("../login/loginForm.jsp");
	  return;
   }
%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>중고의류거래: 옺장</title>
   <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../assets/css/font-awesome.css">
    <link rel="stylesheet" href="../assets/css/templatemo-hexashop.css">
    <link rel="stylesheet" href="../assets/css/owl-carousel.css">
    <link rel="stylesheet" href="../assets/css/lightbox.css"> 
	<link rel="stylesheet" href="./cs/bootstrap.css">
	<link rel="stylesheet" href="./cs/custom.css">
	<title>중고 의류거래: 옺장</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">

	    function getUnread() {
	    	$.ajax({
	    		type: "POST",
	    		url: "./chatUnread",
	    		data: {
	    			userID: encodeURIComponent('<%= M_id %>'),
	    		},
	    		success: function(result) {
	    			if(result >= 1) {
	    				showUnread(result);
	    			} else {
	    				showUnread('');
	    			}
	    		}
	    	});
	    }
	    function getInfiniteUnread() {
	    	setInterval(function() {
	    		getUnread();
	    	}, 4000);
	    }
	    function showUnread(result) {
	    	$('#unread').html(result);
	    }
	    function chatBoxFunction() {
	    	var M_id = '<%= M_id %>'
	    	$.ajax({
	    		type: "GET",
	    		url: "./chatBox",
	    		data: {
	    			userID: encodeURIComponent(M_id),
	    		},
	    		success: function(data) {
	    			if(data == "") return;
	    			$('#boxTable').html('');
	    			var parsed = JSON.parse(data);
	    			var result = parsed.result;
	    			for(var i=0; i<result.length; i++) {
	    				if(result[i][0].value == userID) {
	    					result[i][0].value = result[i][1].value;
	    				} else {
	    					result[i][1].value = result[i][0].value;
	    				}
	    				addBox(result[i][0].value, result[i][1].value, result[i][2].value, result[i][3].value, result[i][4].value, result[i][5].value);
	    			}
	    		}
	    	});
	    }
	    function addBox(lastID, toID, chatContent, chatTime, unread) {
	    	$('#boxTable').append('<tr onclick="location.href=\'chat.jsp?toID=' + encodeURIComponent(toID) + '\'">' +
	    			'<td style="width: 150px;">' + 
	    			'<img class="media-object img-circle" style="margin: 0 auto; max-width: 40px; max-height: 40px;" src="' +  '">' +                       
	    			'<h5>' + lastID + '</h5></td>' + 
	    			'<td>' +
	    			'<h5>' + chatContent +
	    			'<span class="label label-info">' + unread + '</span></h5>' + 
	    			'<div class="pull-right">' + chatTime + '</div>' + 
	    			'</td>' + 
	    			'</tr>');
	    }
	    function getInfiniteBox() {
	    	setInterval(function() {
	    		chatBoxFunction();
	    	}, 3000);
	    }
	</script>
</head>
<body>
    <div class="container">
        <table class="table" style="margin: 0 auto;">
            <thead>
                <tr>
                    <th><h4>주고받은 메시지 목록</h4></th>
                </tr>
            </thead>
            <div style="overflow-y: auto; width: 100%; max-height: 450px;">
                <table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd; margin: 0 auto;">
                    <tbody id="boxTable">
                    </tbody>
                </table>
            </div>
        </table>
    </div>
    <%
        String messageContent = null;
        if (session.getAttribute("messageContent") != null) {
        	messageContent = (String) session.getAttribute("messageContent");
        }
        String messageType = null;
        if (session.getAttribute("messageType") != null) {
        	messageType = (String) session.getAttribute("messageType");
        }
        if (messageContent != null) {
    %>
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
                    <div class="modal-header panel-heading">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title">
                            <%= messageType %>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <%= messageContent %>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%     	
        session.removeAttribute("messageContent");
        session.removeAttribute("messageType");
        }
    %>
    <script>
        $('#messageModal').modal("show");
    </script>
    <%
        if(M_id != null) {
    %>
        <script type="text/javascript">
            $(document).ready(function() {
            	getUnread();
            	getInfiniteUnread();
            	chatBoxFunction();
            	getInfiniteBox();
            });
        </script>
    <%
        }   
    %>
</body>
</html>