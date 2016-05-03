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
//한글처리
request.setCharacterEncoding("utf-8");
//파라미터 가져오기
// String id=request.getParameter("id");
// String passwd=request.getParameter("passwd");
// String name=request.getParameter("name");
// int age=Integer.parseInt(request.getParameter("age"));
// String gender=request.getParameter("gender");
// String email=request.getParameter("email");

//액션태그 useBean 객체 생성 MemberBean mb
//액션태그 setProperty 폼 => 자바빈 저장
%>
<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<%
//디비작업 MemberDAO 객체 생성 mdao
MemberDAO mdao=new MemberDAO();
//결과 int check = 메서드호출  updateMember(mb)
int check=mdao.updateMember(mb);
//check==1  "수정성공" main.jsp이동
//check==0  "비밀번호틀림" 뒤로이동
//check==-1 "아이디없음" 뒤로이동

if(check==1){
	%>
	<script type="text/javascript">
		alert("수정성공");
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
		alert("비밀번호없는데?");
		history.back();
	</script>
	<%
}
%>
</body>
</html>



