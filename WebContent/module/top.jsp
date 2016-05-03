<%@ page contentType = "text/html; charset=euc-kr" %>

<html>
<head>
   <link href="style.css" rel="stylesheet" type="text/css">
   
<%
 try{
   if(session.getAttribute("id")==null){%>
   
</head>
<body onLoad="focusIt();"">
      <center>
         <a href="../shop/list.jsp?book_kind=all">전체목록보기</a>&nbsp;
     <br>
      
     <form name="inform" method="post" action="../member/loginPro.jsp"  onSubmit="return checkIt();">
         아이디:  <input type="text" name="id" size="15" maxlength="12">
         패스워드:  <input type="password" name="passwd" size="15" maxlength="12">
         <input type="submit" name="Submit" value="로그인">
     </form>
     <font color="red">* 반드시 로그인을 하셔야 쇼핑을 하실 수 있습니다.*</font>
     </center>
 <%}else{%>
       <center>
          <a href="shop/list.jsp?book_kind=all">전체목록보기</a>&nbsp;
          <a href="shop/cartList.jsp?book_kind=all">장바구니보기</a>&nbsp;
          <a href="shop/buyList.jsp">구매목록보기</a>&nbsp;
      
      <br><br> 
      <b><%=session.getAttribute("id")%></b> 님 , 즐거운 쇼핑시간이 되세요.
       
        <input type="button"  value="로그아웃" onclick="javascript:window.location='../member/logout.jsp'">
     
     </center>
    <%}
 }catch(NullPointerException e){
	 e.printStackTrace();
 }
 %>
      
  </body>
</html>