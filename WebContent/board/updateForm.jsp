<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>
#main{
width:800px;
margin:0 auto;
padding-top:50px;

}

</style>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
</head>
<body>
<jsp:include page="../inc/top2.jsp"/>
<script>
function writeSave(){
	if(document.updateForm.passwd.value==''){
		alert("비밀번호 입력");
		document.updateForm.passwd.focus();
		return false;
	}
	
}

</script>



<%

int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");
try{
	request.setCharacterEncoding("utf-8");
BoardDAO bdao=new BoardDAO();
//메서드호출   writeBoard(bb)

BoardBean bb = bdao.updateGetBoard(num);

%>


<div id="main">
<h1>게시판 업데이트</h1>

<form action="updatePro.jsp?pageNum=<%=pageNum %>&num=<%=num%>" method="post" name="updateForm"  onsubmit="return writeSave()">
<table border="1">
<tr><td>글쓴이</td><td><input type="text" name="name" value="<%=bb.getName() %>"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject" value="<%=bb.getSubject()%>"></td></tr>
<tr><td>맛</td><td><select name='mi'><option>매운맛</option><option>보통맛</option><option>순한맛</option></select></td></tr>
<tr><td>내용</td>
    <td><textarea name="content" rows="15" cols="67" ><%=bb.getContent()%></textarea></td></tr>

<tr><td>비밀번호</td><td><input type="password" name="passwd"></td></tr>
<tr><td>글수정</td><td><input type="submit" value="글수정"></td></tr>
<tr><td>다시작성</td><td><input type="reset" value="다시작성"></td></tr>
<tr><td>목록보기</td><td><input type="button" value="목록보기" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>&num=<%=num%>'"></td></tr>

</form>
</table>
</div>
<%
}catch(Exception e){}%>
</body>
</html>