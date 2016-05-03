<%@page import="Buy.BuyDAO"%>
<%@page import="Buy.BuyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.text.NumberFormat" %>

<%
   String buyer = (String)session.getAttribute("id");
%>

<html>
<head>
<title>Book Shopping Mall</title>
</head>

<body>

<%
Vector buyLists = null;
BuyBean buyList = null;
int count = 0;

BuyDAO buyProcess = new BuyDAO();
count = buyProcess.getListCount();

if(count == 0){
%>
      <h3><center><b>주문목록</b></center></h3>
      <center>
      <table border="1" width="650" cellpadding="3" cellspacing="3" align="center"> 
        <tr><td align="center" >구매목록이 없습니다.</td> </tr>
      </table>
      <a href="amain.jsp"> 관리자 메인으로</a> 
    <%
    }else{
    	buyLists = buyProcess.getBuyList();
%>
    <h3><center><b>주문목록</b></center></h3>
    <center><a href="amain.jsp"> 관리자 메인으로</a> 
    <table border="1"  cellpadding="0" cellspacing="0" align="center"> 
      <tr> 
        <td align="center"  >주문번호</td> 
        <td align="center" >주문자</td> 
        <td align="center"  >책이름</td>
        <td align="center"  >주문가격</td> 
        <td align="center"  >주문수량</td>
        <td align="center"  >주문일</td>
        <td align="center"  >결제계좌</td>
        <td align="center"  >배송명</td>
        <td align="center"  >배송지전화</td>
        <td align="center" >배송지주소</td>
        <td align="center"  >배송지상황</td>
       </tr>
 <%
     for(int i=0;i<buyLists.size();i++){
    	 buyList = (BuyBean)buyLists.elementAt(i);
    	     	 
%>
      <tr> 
        <td align="center"  ><%=buyList.getBuy_id() %></td> 
        <td align="center" ><%=buyList.getBuyer() %></td> 
        <td align="center"  ><%=buyList.getFood_name() %></td>
        <td align="center"  ><%=buyList.getBuy_price() %></td> 
        <td align="center"  ><%=buyList.getBuy_count()%></td>
        <td align="center"  ><%=buyList.getBuy_date().toString() %></td>
        <td align="center"  ><%=buyList.getAccount() %></td>
        <td align="center"  ><%=buyList.getDeliveryName() %></td>
        <td align="center"  ><%=buyList.getDeliveryTel() %></td>
        <td align="center" ><%=buyList.getDeliveryAddress() %></td>
        <td align="center" ><%=buyList.getSanction() %></td>
      </tr>
<%
     }
%>
    </table>
<%
  }
%>
   </center>
</body>
</html>