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
         <a href="../shop/list.jsp?book_kind=all">��ü��Ϻ���</a>&nbsp;
     <br>
      
     <form name="inform" method="post" action="../member/loginPro.jsp"  onSubmit="return checkIt();">
         ���̵�:  <input type="text" name="id" size="15" maxlength="12">
         �н�����:  <input type="password" name="passwd" size="15" maxlength="12">
         <input type="submit" name="Submit" value="�α���">
     </form>
     <font color="red">* �ݵ�� �α����� �ϼž� ������ �Ͻ� �� �ֽ��ϴ�.*</font>
     </center>
 <%}else{%>
       <center>
          <a href="shop/list.jsp?book_kind=all">��ü��Ϻ���</a>&nbsp;
          <a href="shop/cartList.jsp?book_kind=all">��ٱ��Ϻ���</a>&nbsp;
          <a href="shop/buyList.jsp">���Ÿ�Ϻ���</a>&nbsp;
      
      <br><br> 
      <b><%=session.getAttribute("id")%></b> �� , ��ſ� ���νð��� �Ǽ���.
       
        <input type="button"  value="�α׾ƿ�" onclick="javascript:window.location='../member/logout.jsp'">
     
     </center>
    <%}
 }catch(NullPointerException e){
	 e.printStackTrace();
 }
 %>
      
  </body>
</html>