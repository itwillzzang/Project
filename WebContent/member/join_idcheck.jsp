<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<script type="text/javascript">
	function result() {
		//join페이지 id = 찾은아이디
		opener.document.fr.id.value=document.wfr.userid.value
		//창닫기
		window.close();
	}

</script>

</head>
<body>


<%
//String id=  파라미터값 가져오기 "userid"
String id=request.getParameter("userid");
// MemberDAO mdao 객체 생성
MemberDAO mdao=new MemberDAO();
// int check = 메서드호출  join_IdCheck(id)
int check=mdao.join_IdCheck(id);
// check==1  아이디있음  아이디중복  "사용중인 ID입니다."
// check==0  아이디없음  아이디중복아님 "사용가능한 ID입니다."
%>
<form action="join_idcheck.jsp" method="post" name="wfr">
<table>
<tr><td><input type="text" name="userid" value="<%=id%>"></td></tr>
<tr><td><input type="submit" value="중복확인"></td></tr>
<tr><td><%
if(check==1){
	%><%="사용중인 ID입니다."%><%
}else{
	%><%="사용가능한 ID입니다."%>
	<input type="button" value="사용" onclick="result()">
	<%
}
%></td></tr>


</table>
</form>





</body>
</html>