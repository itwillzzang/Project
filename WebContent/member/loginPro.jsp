<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
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
<body style="background:#FFFFE0">
<%
//파라미터 가져오기 "id" "passwd"
String id3=request.getParameter("id");
String passwd=request.getParameter("passwd");

//MemberDAO 객체 생성 mdao
MemberDAO mdao=new MemberDAO();

//결과 int check =메서드호출  checkId(id,passwd)
int check=mdao.checkId(id3, passwd);
// check==1   "아이디있음"  세션생성 "id"  이동main.jsp 
// check==0   "아이디있음 비밀번호틀림"  "비밀번호틀림" 뒤로이동
// check==-1   "아이디없음"  "아이디없음" 뒤로이동
if(check==1){
	//"아이디있음"  세션생성 "id"  이동main.jsp 
	session.setAttribute("id3", id3);
	response.sendRedirect("../index.jsp");
}else if(check==0){
	//"아이디있음 비밀번호틀림"  "비밀번호틀림" 뒤로이동
	%>
	<script type="text/javascript">
		alert("비밀번호틀림");
		history.back();
	</script>
	<%
}else{
	//"아이디없음"  "아이디없음" 뒤로이동
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



