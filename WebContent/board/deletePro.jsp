<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

<body>
<h1>board/writePro.jsp</h1>
<%
//�ѱ�ó��
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");

%>

<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>

<%

//��� ���ϸ���� ��Ű�� board �����̸� BoardDAO
//��ü ���� bdao
BoardDAO bdao=new BoardDAO();
//�޼���ȣ��   writeBoard(bb)
int check = bdao.deleteBoard(num, passwd);


if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">

<%	
}else{
	%>
	<script type="text/javascript">
	
	alert("��й�ȣ�� ���� ����")
	history.go(-1);
	
	
	</script>
	
	<%
}


%>
</body>

</html>