
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

<%
//한글처리
request.setCharacterEncoding("utf-8");
//자바빈 파일 패키지 member 파일이름 MemberBean
//액션태그  MemberBean 객체 생성 mb
//액션태그 폼 => 자바빈 저장
%>
<jsp:useBean id="mb" class="member.MemberBean" />
<jsp:setProperty property="*" name="mb"/>
<%
//가입날짜 => 자바빈 저장
mb.setM_date(new Timestamp(System.currentTimeMillis()));
//디비작업 파일 패키지 member 파일이름 MemberDAO
//객체 생성 mdao
MemberDAO mdao = new MemberDAO();
// 메서드호출 insertMember(mb)
mdao.insertMember(mb);
// "회원가입성공"  login.jsp
%>
<script type="text/javascript">
	alert("회원가입성공");
	location.href="login.jsp";
</script> 


</body>
</html>