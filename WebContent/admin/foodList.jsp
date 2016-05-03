<%@page import="shop.ShopBean"%>
<%@page import="shop.ShopDAO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.text.SimpleDateFormat" %>

<%
   String id2 ="";
   try{
	   id2 = (String)session.getAttribute("id2");
	   if(id2==null ||id2.equals("")){
          response.sendRedirect("alogin.jsp");
	   }else{
%>

<%
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd");
%>

<%
    Vector foodList = null;
    int number =0;
    String food_kind="";
    
    food_kind = request.getParameter("food_kind");
 
    ShopDAO foodProcess = new ShopDAO();
    int count = foodProcess.getFoodCount();
    
    if (count > 0) {
    	foodList = foodProcess.getFoods(food_kind);
    }
%>

<html>
<head>
<title>음식등록사항</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
   String food_kindName="";
   if(food_kind.equals("100")){
	   food_kindName="매운맛";
   }else if(food_kind.equals("200")){
	   food_kindName="순한맛";  
   }else if(food_kind.equals("300")){
	   food_kindName="보통맛";
   }else if(food_kind.equals("all")){
	   food_kindName="전체";
   }
%>

<a  style="color:green" href="foodList1.jsp?food_kind=all">전체목록</a>
<a  style="color:red" href="foodList1.jsp?food_kind=100">매운맛</a>
<a  style="color:orange" href="foodList1.jsp?food_kind=200">순한맛</a>
<a  style="color:yellow" href="foodList1.jsp?food_kind=300">보통맛</a>
<center><b><%=food_kindName%>분류의 목록: 


<%if(food_kind.equals("all")){%> 
    <%=count%>개
<%}else{%>
    <%=foodList.size() %>개
<%} %>
</b>
<table width="700">
<tr>
    <td align="right" >
       <a href="foodResisterForm1.jsp">음식 등록</a>
    </td>
</table>

<%
    if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    등록된 음식이 없습니다.
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" > 
      <td align="center"  width="30">번호</td> 
      <td align="center"  width="30">음식분류</td> 
      <td align="center"  width="100">이름</td>
      <td align="center"  width="50">가격</td> 
      <td align="center"  width="50">수량</td> 
      <td align="center"  width="50">음식이미지</td>
      <td align="center"  width="70">등록일</td>
      <td align="center"  width="50">수정</td>
      <td align="center"  width="50">삭제</td>         
    </tr>
<%  
        for (int i = 0 ; i <foodList.size() ; i++) {
        	ShopBean food = (ShopBean)foodList.elementAt(i);
%>
   <tr height="30">
      <td width="30"><%=++number%></td> 
      <td width="30"><%=food.getFood_kind()%></td> 
      <td width="100"><%=food.getFood_name()%></td>
      <td width="50"><%=food.getFood_price()%></td> 
      <td width="50">
         <% if(food.getFood_count()==0) {%>
         <font color="red"><%="일시품절"%></font>
         <% }else{ %>
         <%=food.getFood_count()%>
         <%} %>
      </td> 
      <td width="50"><%=food.getFood_image()%></td>
      <td width="50"><%=sdf.format(food.getReg_date())%></td>
      <td width="50">
         <a href="foodUpdateForm1.jsp?food_id=<%=food.getFood_id()%>&food_kind=<%=food.getFood_kind()%>">수정</a></td>
      <td width="50">
         <a href="foodDeleteForm.jsp?food_id=<%=food.getFood_id()%>&food_kind=<%=food.getFood_kind()%>">삭제</a></td>    
  </tr>
     <%}%>
</table>
<%}%>
</body>

</html>
<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	
    }
%>


