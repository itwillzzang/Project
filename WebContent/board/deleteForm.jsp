<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ۻ�������</title>
<style>
#main{
width:800px;
margin:0 auto;
padding-top:50px;
}

</style>
</head>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
<body>
<jsp:include page="../inc/top2.jsp"/>
<script type="text/javascript">
function deleteSave(){
	if(document.delForm.passwd.value==''){
		alert("��й�ȣ �Է�");
		document.delForm.passwd.focus();
		return false;
	}
	
}
</script>
<div id="main">
<h1>�ۻ���</h1>
<% request.setCharacterEncoding("utf-8"); %>


<%

int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");

%>

<form method="post" name="delForm" action="deletePro.jsp?pageNum=<%=pageNum %>" onsubmit="return deleteSave()">

��й�ȣ:<input type="password" name="passwd" >
<input type ="hidden" name="num" value="<%=num %>">
<input type="submit" value="�ۻ���">
<input type="button" value="�۸��"  onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">


</form>

</div>

</body>
</html>