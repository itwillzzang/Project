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
<body>
<h1>관리자모드 로그인</h1>
<%
//파라미터 가져오기 "id" "passwd"
String id2=request.getParameter("id2");
String passwd2=request.getParameter("passwd");

//MemberDAO 객체 생성 mdao
MemberDAO mdao=new MemberDAO();

//결과 int check =메서드호출  checkId(id,passwd)
int check=mdao.acheckId(id2, passwd2);
// check==1   "아이디있음"  세션생성 "id"  이동main.jsp 
// check==0   "아이디있음 비밀번호틀림"  "비밀번호틀림" 뒤로이동
// check==-1   "아이디없음"  "아이디없음" 뒤로이동
if(check==1){
	//"아이디있음"  세션생성 "id"  이동main.jsp 
	session.setAttribute("id2", id2);
	response.sendRedirect("amain.jsp");
	
}else if(check==0){
	//"아이디있음 비밀번호틀림"  "비밀번호틀림" 뒤로이동
	%>
	<script type="text/javascript">
		alert("비밀번호도모름?");
		history.back();
	</script>
	<%
}else{
	//"아이디없음"  "아이디없음" 뒤로이동
	%>
	<script type="text/javascript">
		alert("당신관리자아니잖아");
		history.back();
	</script>
	<%
}

%>
</body>
</html>



