<%@page import="shop.ShopDAO"%>
<%@page import="shop.ShopBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.NumberFormat"%>
<html>
<script src="../j/jquery-1.12.1.js"></script>
<%
	String food_kind = request.getParameter("food_kind");
	String food_id = request.getParameter("food_id");
	String id3 = "";
	int buy_price = 0;
	try {
		if (session.getAttribute("id3") == null) {
			id3 = "not";
		} else {
			id3 = (String) session.getAttribute("id3");
		}
	} catch (Exception e) {

	}
%>



<head>
<title>food Shopping Mall</title>
</head>

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
<style>
#main{
margin-top:50px;
}

 table{
                border:0px solid gray;
                border-collapse: collapse;
            }
            th{
                background-color: #d0d0d0;
        
            }
            th,td{
                border:0px solid gray;
                padding:5px;
            }



</style>

<body>

	<jsp:include page="../inc/top2.jsp" />
	<%
		ShopBean foodList = null;
		String food_kindName = "";

		ShopDAO foodProcess = new ShopDAO();

		foodList = foodProcess.getFood(Integer.parseInt(food_id));

		if (food_kind.equals("100")) {
			food_kindName = "매운맛";
		} else if (food_kind.equals("200")) {
			food_kindName = "보통맛";
		} else if (food_kind.equals("300")) {
			food_kindName = "순한맛";
		}
	%>



<div id="main">
	<center>
		<form name="inform" method="post" action="cartInsert.jsp">
			<table calss="table" border="0" width="700" cellpadding="5" cellspacing="5"
				align="center">
				<tr height="30">
					<td rowspan="6" width="150" align="center" valign="middle"><img
						src="../fileSave/<%=foodList.getFood_image()%>" border="0"
						width="150" height="200"></td>
					<td width="500"><font size="+1"><b><%=foodList.getFood_name()%></b></font></td>
				</tr>
				<tr>
					<td width="500">정가 : <%=NumberFormat.getInstance().format(foodList.getFood_price())%>원<br>
				<tr>
					<td width="500">수량 : <input type="text" size="5"
						name="buy_count" value="1"> 개 <%
						if (id3.equals("not")) {
							if (foodList.getFood_count() == 0) {
					%> <b>물건없다</b> <%
 	}
 %> <%
 	} else {

 		if (foodList.getFood_count() == 0) {
 %> <b>일시품절</b> <%
 	} else {
 %> <input type="hidden"
						name="food_id" value="<%=food_id%>"> <input type="hidden"
						name="food_image" value="<%=foodList.getFood_image()%>"> <input
						type="hidden" name="food_name"
						value="<%=foodList.getFood_name()%>"> <input
						type="hidden" name="buy_price" value="<%=foodList.getFood_price()%>"> <input
						type="hidden" name="food_kind" value="<%=food_kind%>"> <input
						type="submit" value="장바구니에 담기"> <%
 	}
 	}
 %> <input type="button"
						value="목록으로"
						onclick="javascript:window.location='list.jsp?food_kind=<%=food_kind%>'">
						<input type="button" value="메인으로"
						onclick="javascript:window.location='../index.jsp'">
					</td>
				</tr>
				<tr>
					<td colspan="2"><br><%=foodList.getFood_content()%></td>
				</tr>

			</table>
		</form>
	</center>
	<div id="name" style="width:600px"></div>
	</div>
	<script type="text/javascript">
  
 $(document).ready(function(){   
	 
	 
	 
	 
	 
	 $('table img').mouseover(function(){
	 $('#name').html(function(index,html){
	 <%=id3%>
		 if(<%=id3%>=="not"){
		
			 return html +"먹고싶지?얼릉 로그인해서 사~!"
		 }else{
			 return html +" <%=id3%>님 얼릉 구매하쎄열~ <br> 장바구니 GOGO!"
		 }
		 
	 
	 }).css('font-size','50px').css('color','#AC98E4').css('text-alian','center').css('margin','0 auto').css('margin-top','300px')
	 }).mouseout(function(){
			$('#name').empty();
	})
 
 
	
	
	
	
	
	
	});
 
 </script>

</body>
</html>
