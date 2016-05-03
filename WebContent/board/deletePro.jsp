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
//한글처리
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");

%>

<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>

<%

//디비 파일만들기 패키지 board 파일이름 BoardDAO
//객체 생성 bdao
BoardDAO bdao=new BoardDAO();
//메서드호출   writeBoard(bb)
int check = bdao.deleteBoard(num, passwd);


if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">

<%	
}else{
	%>
	<script type="text/javascript">
	
	alert("비밀번호가 맞지 않음")
	history.go(-1);
	
	
	</script>
	
	<%
}


%>
</body>

</html>