<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String id2 ="";
   try{
	   id2 = (String)session.getAttribute("id2");
	   if(id2==null || id2.equals("")){
          response.sendRedirect("amain.jsp");
	   }else{
%>
<%
int food_id = Integer.parseInt(request.getParameter("food_id"));
String food_kind = request.getParameter("food_kind");

%>
<html>
<head>
<title>음식삭제</title>

<style>

a{
padding:10px;
text-decoration:none;
color:#2E2F33;
}
#main{

margin-top:200px;

}
body{
background:#F4DDDE;

}

h1{
color:#ED262E
}
</style>
</head>

<body>
<div id="main">
<center><h1>음식삭제</h1>
<br>
<form method="POST" name="delForm"  action="foodDeletePro.jsp?food_id=<%=food_id%>&food_kind=<%=food_kind%>" > 
 <table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
 <tr>
     <td align="right">
	    <a href="amain.jsp"> 관리자 메인으로</a>
	    <a href="foodList1.jsp?food_kind=<%=food_kind%>">목록으로</a>  
	     <a href="foodList1.jsp?food_kind=all">푸드목록으로</a>
     </td>
  </tr>
  
 <tr height="30">
    <td align=center>
      <input type="submit" value="삭제" >  
   </td>
 </tr>  
</table> 
</form>
</div>
</body>
</html>
<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>