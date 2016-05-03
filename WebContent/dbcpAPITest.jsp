<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
 	Connection conn = null; 
	
	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/yamyam");
  		conn = ds.getConnection();
  		
  		out.println("<h3>연결되었습니다.</h3>");
	}catch(Exception e){
		out.println("<h3>연결에 실패하였습니다.</h3>");
		e.printStackTrace();
 	}
	
	
	
	 
	
	//한글처리
	request.setCharacterEncoding("utf-8");
	//자바빈 파일 패키지 member 파일이름 MemberBean
	//액션태그  MemberBean 객체 생성 mb
	//액션태그 폼 => 자바빈 저장
	%>
	<jsp:useBean id="mb" class="member.MemberBean" />
	<jsp:setProperty property="*" name="mb"/>
	<%

	//디비작업 파일 패키지 member 파일이름 MemberDAO
	//객체 생성 mdao
	MemberDAO mdao=new MemberDAO();
	// 메서드호출 insertMember(mb)
	mdao.insertMember(mb); 
	// "회원가입성공"  login.jsp
	%>

	
%>
