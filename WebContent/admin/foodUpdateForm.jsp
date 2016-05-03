<%@page import="shop.ShopDAO"%>
<%@page import="shop.ShopBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>


<%
   String id2 ="";
   try{
	   id2 = (String)session.getAttribute("id2");
	   if(id2==null || id2.equals("")){
          response.sendRedirect("alogin.jsp");
	   }else{
%>
<%
   int food_id = Integer.parseInt(request.getParameter("food_id"));
  String food_kind = request.getParameter("food_kind");
try{
	ShopDAO foodProcess = new ShopDAO();
    ShopBean food =  foodProcess.getFood(food_id); 
%>

<html>
<head>
<title>상품수정</title>
</head>

<body>  
<center><h1>상품 수정</h1></center>

<br>

<form method="post" name="writeform" action="foodUpdatePro.jsp?food_id=<%=food_id%>"  enctype="multipart/form-data">
<table width="500" border="1"  align="center">
   
   <tr>
    <td  width="100"  align="center">분류 선택</td>
    <td  width="400">
       <select name="food_kind">
           <option value="100" <%if (food.getFood_kind().equals("100")) {%>selected<%} %>>매운맛</option>
           <option value="200" <%if (food.getFood_kind().equals("200")) {%>selected<%} %>>보통맛</option>
           <option value="300" <%if (food.getFood_kind().equals("300")) {%>selected<%} %>>순한맛</option>
       </select>
    </td>
  </tr>
  <tr>
    <td  width="100"   align="center" >음식이름</td>
    <td  width="400">
        <input type="text" size="50" maxlength="50" name="food_name" value="<%=food.getFood_name() %>">
        <input type="hidden" name="food_id" value="<%=food_id%>"></td>
  </tr>
  <tr>
    <td  width="100"   align="center" >가 격</td>
    <td  width="400">
        <input type="text" size="10" maxlength="9" name="food_price" value="<%=food.getFood_price() %>">원</td>
  </tr>
  <tr>
    <td  width="100"   align="center" >수량</td>
    <td  width="400">
        <input type="text" size="10" maxlength="5" name="food_count" value="<%=food.getFood_count() %>">개</td>
  </tr>
  <tr>
    <td  width="100"  align="center" >이미지</td>
    <td  width="400">
        <input type="file" name="food_image"><%=food.getFood_image() %></td>
  </tr>
  <tr>
    <td  width="100"   align="center" >내 용</td>
    <td  width="400" >
     <textarea name="food_content" rows="13" cols="40"><%=food.getFood_content() %></textarea> </td>
  </tr>
 <tr>
 
<tr>      
 <td colspan=2 align="center"> 
  <input type="submit" value="수정" >  
  <input type="reset" value="다시작성">
</td>
</tr>
</table>         
</form> 

  
<%
}catch(Exception e){
	e.printStackTrace();
}%>         
</body>

</html>
<% 
	   }  
    }catch(Exception e){
		e.printStackTrace();
	}
%>

