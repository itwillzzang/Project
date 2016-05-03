<%@page import="member.MemberDAO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//파라미터 가져오기
String id3=request.getParameter("id3");
String passwd=request.getParameter("passwd");

//디비객체생성 MemberDAO mdao  
MemberDAO mdao=new MemberDAO();
//int check = 메서드호출 deleteMember(id,passwd)
int check=mdao.deleteMember(id3,passwd);
//check==1
//check==0
//check==-1
if(check==1){
	//세션값 삭제
	session.invalidate();
	%>
	<script type="text/javascript">
		alert("삭제성공");
		location.href="../index.jsp";
	</script>
	<%
}else if(check==0){
	%>
	<script type="text/javascript">
		alert("비밀번호틀림");
		history.back();
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("아이디없음");
		history.back();
	</script>
	<%
}


%>
</body>
</html>



