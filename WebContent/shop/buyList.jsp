<%@page import="Buy.BuyDAO"%>
<%@page import="Buy.BuyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.text.NumberFormat" %>

<%
   String buyer = (String)session.getAttribute("id3");
%>

<html>
<head>
<title>food Shopping Mall</title>
</head>

<body>

<%
Vector buyLists = null;
BuyBean buyList = null;
int count = 0;
int number = 0;
int total = 0;
long compareId=0;
long preId=0;
String id = (String)session.getAttribute("id3");
if(id==null){
	   response.sendRedirect("list.jsp");        
}else{
	  BuyDAO buyProcess = new BuyDAO();
      count = buyProcess.getListCount(buyer);

     if(count == 0){
    %>
      <h3><center><b>구매목록</b></center></h3>
      <center>
      <table border="1" width="650" cellpadding="3" cellspacing="3" align="center"> 
        <tr><td align="center" >구매목록이 없습니다.</td> </tr>
      </table>
      <input type="button" value="메인으로" onclick="javascript:window.location='list.jsp'">
    <%
    }else{
    	buyLists = buyProcess.getBuyList(buyer);
%>
    <h3><center><b>구매목록</b></center></h3>
    <center>
 <%
     for(int i=0;i<buyLists.size();i++){
    	 buyList = (BuyBean)buyLists.elementAt(i);
    	 
    	 if(i<buyLists.size()-1){
    		 BuyBean compare = (BuyBean)buyLists.elementAt(i+1);
    		 compareId = compare.getBuy_id();
    		 
    		 BuyBean pre = (BuyBean)buyLists.elementAt(buyLists.size()-2);
    		 preId = pre.getBuy_id();
    	 }
    	 
    	 
%>
    <table border="1" width="750" cellpadding="0" cellspacing="0" align="center"> 
      <tr> 
        <td align="center"  width="150">번호</td> 
        <td align="center"  width="300">책이름</td> 
        <td align="center"  width="100">판매가격</td>
        <td align="center"  width="50">수량</td> 
        <td align="center"  width="150">금액</td>
       </tr>
       <tr> 
          <td align="center"  width="150"><%=buyList.getBuy_id()%></td> 
          <td  width="300">
             <img src="/fileSave/<%=buyList.getFood_image()%>" border="0" width="30" height="50" align="middle">
             <%=buyList.getFood_name()%>
          </td> 
          <td align="center"  width="100">\<%=NumberFormat.getInstance().format(buyList.getBuy_price())%></td>
          <td width="50" align="middle"><%=buyList.getBuy_count()%></td> 
          <td align="center"  width="150" >
              <%total += buyList.getBuy_count()*buyList.getBuy_price();%>
              \<%=NumberFormat.getInstance().format(buyList.getBuy_count()*buyList.getBuy_price()) %>
          </td>
       </tr>
<%
        if( buyList.getBuy_id() != compareId || (i == buyLists.size()-1) && preId != buyList.getBuy_id() ) {
%> 
       <tr>
          <td colspan="5" align="right"><b>총 금액 : \<%=NumberFormat.getInstance().format(total)%></b></td>
      </tr></table><br>
<% 
           compareId = buyList.getBuy_id();
           total = 0;
        }else{
%>
    </table>
<%
        }
     }
%>
    <input type="button" value="메인으로" onclick="javascript:window.location='list.jsp'">
   </center>
<%
    }
 }
%>
</body>
</html>