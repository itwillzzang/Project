<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!-- 해더시작 -->
<div class="boxA">

<div class="boxA_inner">
<div class="box1">
<div class="site">
<a href="../index.jsp"><img src="../images/a.png" alt="yamyam"></a>
</div>
</div>



<div class="box2">
<nav class="menu">
<ul>

<li><a href="../index.jsp">메인</a>
<%

String id3 = (String)session.getAttribute("id3");
if(id3==null){
	%>
	<li><a href="../member/login.jsp">로그인</a></li>
    <li><a href="../member/join.jsp">회원가입</a></li>
<%}else{%>
	<li><a href="../member/logout.jsp">로그아웃</a></li> 
	<li><a href="../member/update.jsp">회원정보수정</a></li>
	<%}%>


</ul>
</nav>
</div>

</div>

</div> 

<!-- 해더끝 -->
