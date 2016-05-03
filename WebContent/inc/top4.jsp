<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>



<!--

-->
<!-- 해더시작 -->
<div class="boxA">

<div class="boxA_inner">
<div class="box1">
<div class="site">
<a href="../index.jsp"><img src="../images/a.png" alt="yamyam"></a>
</div>
</div>
<%

String id2 = (String)session.getAttribute("id2");
if(id2==null){
	%>
	<li><a href="login.jsp">로그인</a></li>
    <li><a href="join.jsp">회원가입</a></li>
<%}else{%>
	<li><a href="logout.jsp">로그아웃</a></li> 
	<li><a href="update.jsp">회원정보수정</a></li>
	<%}%>



<div class="box2">
<nav class="menu">
<ul>

<li><a href="../index.jsp">메인</a>


</ul>
</nav>
</div>

</div>

</div> 

<!-- 해더끝 -->
