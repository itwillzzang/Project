<%@page import="Buy.BuyDAO"%>
<%@page import="Buy.BuyBean"%>
<%@page import="Customer.CustomerDAO"%>
<%@page import="Cart.CartDAO"%>
<%@page import="Customer.CustomerBean"%>
<%@page import="Cart.CartBean"%>
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
Vector accountLists = null;
CartBean cartList = null;
CustomerBean member= null;
int number = 0;
int total = 0;
String id = (String)session.getAttribute("id3");
if(id==null){
	response.sendRedirect("list.jsp");        
}else{
	CartDAO foodProcess = new CartDAO();
    cartLists = foodProcess.getCart(buyer);
    
    CustomerDAO memberProcess = new CustomerDAO();
    member = memberProcess.getMember(buyer);
    
    BuyDAO buyProcess = new BuyDAO();
    accountLists = buyProcess.getAccount();
%>
    <h3><center><b>구매 목록</b></center></h3>
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
          <td align="center"  width="50"><%=++number %></td> 
          <td  width="300">
             <img src="../fileSave/<%=cartList.getFood_image()%>" border="0" width="50" height="50" align="middle">
             <%=cartList.getFood_name()%>
          </td> 
          <td align="center"  width="100"><%=NumberFormat.getInstance().format(cartList.getBuy_price())%></td>
          <td width="150" align="middle"><%=cartList.getBuy_count()%></td> 
          <td align="center"  width="150" align="middle">
              <%total += cartList.getBuy_count()*cartList.getBuy_price();%>
              \<%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getBuy_price()) %>
          </td>
       </tr>
<%
     }
%>
       <tr>
          <td colspan="5" align="right"><b>총 구매금액 : <%=NumberFormat.getInstance().format(total)%></b></td>
      </tr>
   </table>
   </form>
   </center>
<%} 
 %>
   <br>
   <form method="post" name="buyinput">
   <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
      <tr > 
       <td  colspan="2" align="center"><font size="+1" ><b>주문자 정보</b></font></td>
     </tr>
     <tr> 
       <td  width="200">성명</td>
       <td  width="400"><%=member.getName()%></td>
     </tr>
     <tr> 
       <td  width="200">전화번호</td>
       <td  width="400"><%=member.getTel()%></td>
     </tr>
     <tr> 
       <td  width="200">주소</td>
       <td  width="400"><%=member.getAddress()%></td>
     </tr>
     <tr> 
       <td  width="200">계좌</td>
       <td  width="400">
         <select name="account">
          <%
              for(int i=0;i<accountLists.size();i++){
            	  String accountList = (String)accountLists.elementAt(i);
          %>
                  <option value="<%=accountList %>"><%=accountList %></option>
         <%}%>
         </select>
       </td>
    </tr>
  </table>
  <br>
   
   <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
      <tr > 
       <td  colspan="2" align="center"><font size="+1" ><b>배송지 정보</b></font></td>
     </tr>
     <tr> 
       <td  width="200">성명</td>
       <td  width="400">
          <input type="text" name="deliveryName" value="<%=member.getName()%>">
       </td>
     </tr>
     <tr> 
       <td  width="200">전화번호</td>
       <td  width="400">
         <input type="text" name="deliveryTel" value="<%=member.getTel()%>">
       </td>
     </tr>
     <tr> 
       <td  width="200">주소</td>
       <td  width="400">
         <input type="text" name="deliveryAddess" value="<%=member.getAddress()%>">
       </td>
     </tr>
     <tr> 
       <td colspan="2" align="center">
         <input type="submit" value="확인" >
         <input type="button" value="취소" onclick="javascript:window.location='list.jsp?food_kind=all'">      
       </td>
    </tr>
  </table>
  </form>
</body>
</html>