<%@page import="member.MemberDAO"%>
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

<jsp:useBean id="m" class="member.MemberBean" />
<jsp:setProperty property="*" name="m"/>

<%

//디비작업 파일 패키지 member 파일이름 MemberDAO
//객체 생성 mdao
 MemberDAO c = new MemberDAO();
// 메서드호출 insertMember(mb)
// "회원가입성공"  login.jsp


//c.deleteMember(m.getId(),m.getPasswd());
%>

<%=m.getGender() %>


<script type="text/javascript">


	
	

</script>


</body>
</html>