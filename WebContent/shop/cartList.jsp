
<%@page import="Cart.CartBean"%>
<%@page import="Cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.text.NumberFormat" %>

<%
   String food_kind = request.getParameter("food_kind");
   String buyer = (String)session.getAttribute("id3");
%>

<html>
<head>
<title>food Shopping Mall</title>

</head>

<body>

<%

Vector cartLists = null;
CartBean cartList = null;
int count = 0;
int number = 0;
int total = 0;
String id3 = (String)session.getAttribute("id3");
if(id3==null){
	   response.sendRedirect("list.jsp");  
	   %>
	   <script>
	   alert("로그인먼저하고왕!")
	   </script>
	   <% 
}else{
     CartDAO a = new CartDAO();
     count = a.getListCount(buyer);

     if(count == 0){
    %>
         <h3><center><p>장바구니</p></center></h3>
         <center>
         <table border="1" width="650" cellpadding="3" cellspacing="3" align="center"> 
           <tr><td align="center" >장바구니에 담긴 물품이 없습니다.</td> </tr>
         </table>
         <input type="button" value="쇼핑계속" onclick="javascript:window.location='list.jsp?food_kind=all'">
   <%
   }else{
        cartLists = a.getCart(buyer);
   %>
       <h3><center>장바구니</h3><div id="abc"></center>
       <center>
       <form name="inform" method="post" action="updateCart.jsp">
       <table border="1" width="750" cellpadding="0" cellspacing="0" align="center"> 
         <tr> 
           <td align="center"  width="50">번호</td> 
           <td align="center"  width="300">음식이름</td> 
           <td align="center"  width="100">판매가격</td>
           <td align="center"  width="150">수량</td> 
             <td align="center"  width="150">금액</td>
        </tr>
      
<%
     for(int i=0;i<cartLists.size();i++){
    	 cartList = (CartBean)cartLists.elementAt(i);
%>
     
       <tr> 
       <form method="post" action="updateCart.jsp">
          <td align="center"  width="50"><%=++number %></td> 
          <td  width="300">
             <img src="../fileSave/<%=cartList.getFood_image()%>" border="0" width="100" height="100" align="middle">
             <%=cartList.getFood_name()%>
          </td> 
          <td align="center"  width="100"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%>원</td>
          <td width="150" align="middle">
                <input type="text" name="buy_count" size="5" value="<%=cartList.getBuy_count()%>">
                <input type="hidden" name="cart_id" value="<%=cartList.getCart_id()%>">
                <input type="hidden" name="food_kind" value="<%="food_kind"%>">
                <input type="submit" value="수정" >
          </td> 
          <td align="center"  width="150" align="middle">
              <%total += cartList.getBuy_count()*cartList.getBuy_price();%>
              <%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %>원
             <input type="button" value="삭제" onclick="javascript:window.location='cartListDel.jsp?list=<%=cartList.getCart_id() %>&food_kind=<%=food_kind%>'">
          </td>
          </form>
       </tr>
<%
     }
%>
       <tr>
          <td colspan="5" align="right"><b>총 금액 : <%=NumberFormat.getInstance().format(total)%>원</b></td>
      </tr>
       <tr>
          <td colspan="5" align="center">
            <input type="button" value="구매하기" onclick="javascript:window.location='buyForm.jsp'">
            <input type="button" value="쇼핑계속" onclick="javascript:window.location='list.jsp?food_kind=all'">
            <input type="button" value="장바구니비우기" onclick="javascript:window.location='cartListDel.jsp?list=all&food_kind=all'">
          </td>

   </table>
   </form>
   </center>
<%
   } 
 }
 %>
</body>
</html>