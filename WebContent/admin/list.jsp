<%@page import="member.MemberBean"%>
<%@page import="java.util.List"%>
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
<style>  th{
                background-color: #d0d0d0;
                font-weight:bold;
            }
            th,td{
                border:1px solid gray;
                padding:5px;
            }

#main {
	margin: 40px;
}

p>a{

	font-size:20px;
}
h1{

	color: #131A7F;

}
table {
	border: 1px solid gray;
	border-collapse: collapse;
	text-align:center;
}

</style>

<body>
	<%
		//세션값 가져오기
		String id2 = (String) session.getAttribute("id2");
		//세션값 없는 경우  세션값 admin아닌경우 main.jsp이동
		if (id2 == null) {
			response.sendRedirect("amain.jsp");
		}
		//MemberDAO 객체 생성 mdao
		MemberDAO mdao = new MemberDAO();
		//결과 저장 컬렉션배열 변수 List memberList=메서드호출  getMembers()
		List memberList = mdao.getMembers();
	%>
	<div id="main">
		<h1>우리동지들~!</h1>
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>비밀번호</td>
				<td>이름</td>
				<td>가입날짜</td>
				<td>성별</td>
				<td>이메일</td>
			</tr>
			<%
				for (int i = 0; i < memberList.size(); i++) {
					// memberList.size() 배열의크기
					// memberList.get(i) 배열의 한칸의 데이터 가져오기
					MemberBean mb = (MemberBean) memberList.get(i);
			%>
			<tr>
				<td><%=mb.getId()%></td>
				<td><%=mb.getPasswd()%></td>
				<td><%=mb.getName()%></td>
				<td><%=mb.getM_date()%></td>

				<td><%=mb.getGender()%></td>
				<td><%=mb.getEmail()%></td>
			</tr>
			<%
				}
			%>

		</table>
		<p>
			<a href="amain.jsp">관리자메인으로</a>
			<img src="../images/go1.png">
		</p>
	</div>
</body>
</html>

