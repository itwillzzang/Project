<%@page import="shop.ShopDAO"%>
<%@page import="shop.ShopBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.text.NumberFormat" %>

<%
   String food_kind = request.getParameter("food_kind");
%>
<html>
<head>
<title>food Shopping Mall</title>
</head>
<style>

#main{
width:1000px;
margin:0 auto;
height:800px;
margin-top:50px;

}
</style>
<style>
 table{
                border:0px solid gray;
                border-collapse: collapse;
            }
            th{
                background-color: #d0d0d0;
                font-weight:bold;
            }
            th,td{
                border:0px solid gray;
                padding:5px;
            }

</style>

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
<body>

<jsp:include page="../inc/top2.jsp"/>



<div style="overflow:scroll" id="main">
<table width="850" cellspacing="0">
   <tr>
    <td width="150" valign="top">
     <jsp:include page="../module/left.jsp" flush="false" />
    </td>
    <td width="700" valign="top">

    
<%



     Vector foodLists = null;
     ShopBean foodList = null;
     String food_kindName="";
   
     ShopDAO foodProcess = new ShopDAO();
 
     foodLists = foodProcess.getFoods(food_kind);
     if(food_kind.equals("100")){
	      food_kindName="매운맛";
      }else if(food_kind.equals("200")){
	      food_kindName="보통맛";  
      }else if(food_kind.equals("300")){
	      food_kindName="순한맛";
      }else if(food_kind.equals("all")){
	      food_kindName="전체";
      }
%>
    <h3><center><b><%=food_kindName%> 분류의 목록</b></center></h3>
   
<%
   
     for(int i=0;i<foodLists.size();i++){
    	 foodList = (ShopBean)foodLists.elementAt(i);
%>
     <table border="0" width="300" cellpadding="0" cellspacing="0" align="center"> 
       <tr height="30" > 
         <td rowspan="2"  width="10" align="center" valign="middle">
             <a href="foodContent.jsp?food_id=<%=foodList.getFood_id()%>&food_kind=<%=foodList.getFood_kind()%>">
             <img src="../fileSave/<%=foodList.getFood_image()%>" border="0" width="80" height="80"></a></td> 
         <td width="350"><font size="+1"><b>
             <a href="foodContent.jsp?food_id=<%=foodList.getFood_id()%>&food_kind=<%=foodList.getFood_kind()%>">
              <%=foodList.getFood_name()%></a></b></font></td> 
         <td rowspan="2" width="10"  align="center"  valign="middle">
             <%if(foodList.getFood_count()==0){ %>
                     <b>일시품절</b>
             <%}else{ %>
                     &nbsp;
             <%} %>
             
             <img width="60" src="../images/new.png">  
               
               
               
             
         </td>
       </tr>        
      
  <tr>
        <td>정가 : <%=NumberFormat.getInstance().format(foodList.getFood_price())%><br> 
         </td> 
   </tr>
     </table>
     <br>
<%
     }
  
%>


</table>
</div>
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>