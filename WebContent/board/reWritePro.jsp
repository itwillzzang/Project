<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>board/reWritePro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//자바빈 파일 만들기  패키지 board  파일이름 BoardBean
//액션태그  객체생성 bb
//액션태그 폼 => 자바빈 저장
%>
<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%
//날짜 Timestamp 현시스템날짜 => 자바빈 저장
bb.setDate(new Timestamp(System.currentTimeMillis()));
// ip  request.getRemoteAddr() => 자바빈 저장
bb.setIp(request.getRemoteAddr());

//디비 파일만들기 패키지 board 파일이름 BoardDAO
//객체 생성 bdao
BoardDAO bdao=new BoardDAO();
//메서드호출   reWriteBoard(bb)
bdao.reWriteBoard(bb);
// 이동    list.jsp
response.sendRedirect("list.jsp");
%>
</body>
</html>





