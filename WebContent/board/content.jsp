<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
<style>
#main{
width:800px;
margin:0 auto;
padding-top:50px;

}

</style>
<body>

<jsp:include page="../inc/top2.jsp"/>
<%
//int num , String pageNum 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");
//디비객체 생성 BoardDAO bdao
BoardDAO bdao=new BoardDAO();
//조회수 1증가 메서드호출()  updateReadCount(num);
//set readcount=readcount+1  where num=
bdao.updateReadCount(num);
//BoardBean bb = 메서드호출() getBoard(num)
BoardBean bb=bdao.getBoard(num);
%>
<div id="main">
<h1>뭐라썼나볼까?</h1>
<table border="1" width="600">
<tr><td>글쓴이</td><td><%=bb.getName() %></td></tr>
<tr><td>제목</td><td><%=bb.getSubject() %></td></tr>
<tr><td>내용</td><td><%=bb.getContent() %></td></tr>
<tr><td colspan="2">
<input type="button" value="글목록" 
    onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">
<input type="button" value="답글쓰기" 
    onclick="location.href='reWriteForm.jsp?num=<%=num%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'">
<input type="button" value="글수정" 
    onclick="location.href='updateForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
<input type="button" value="글삭제" 
    onclick="location.href='deleteForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
</td></tr>
</table>


<div>
</div>

</div>
</body>
</html>
