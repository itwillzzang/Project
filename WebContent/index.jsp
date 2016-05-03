<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="j/jquery-1.12.1.js"></script>
<script src="j/jquery.innerfade.js"></script>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/top.css">
<script src="p5.min.js"></script>

<style>
/*추가설명*/
.arrow_box {
	position: relative;
	background: #f0f87c;
	border: 5px solid #f57360;
	width:150px;
	height:40px;
	position: fixed;
	left:1400px;
	margin-top:120px;
}
.arrow_box:after, .arrow_box:before {
	bottom: 100%;
	left: 50%;
	border: solid transparent;
	content: " ";
	height: 0;
	width: 0;
	position: absolute;
	pointer-events: none;
}

.arrow_box:after {
	border-color: rgba(240, 248, 124, 0);
	border-bottom-color: #f0f87c;
	border-width: 20px;
	margin-left: -30px;
}
.arrow_box:before {
	border-color: rgba(245, 115, 96, 0);
	border-bottom-color: #f57360;
	border-width: 24px;
	margin-left: -44px;
}

#notice p{
color: #4E134F;
font-size: 20px;
font-style: oblique;
font-weight:20px;
margin-top:4px;
}
#ga{
	position:fixed;
	left:1400px;
		
}
</style>


</head>
<body>


<!-- 해더시작 -->
<div class="boxA">

<div class="boxA_inner">
<div class="box1">

<div class="site">
<a href="index.jsp"><img src="images/a.png" alt="yamyam"></a>
</div>


</div>
<div id="name">
<img src="">
</div>


<div class="box2">
<nav class="menu">
<ul>

<li><a href="index.jsp">메인</a>
<%

String id3 = (String)session.getAttribute("id3");
if(id3==null){
	%>
	<li><a href="member/login.jsp">로그인</a></li>
	<li><a href="member/join.jsp">회원가입</a></li>
    <%}else{%>
	<li><a href="member/logout.jsp">로그아웃</a></li> 
	<li><a href="member/update.jsp">회원정보수정</a></li>
  
	<%
	}
%>


</ul>
</nav>
</div>

</div>

</div> 

<% if(id3==null){
%>

<% }else{%>
<div id="ga"><a href="shop/cartList.jsp"><img src="images/ga.png"></a></div>
<div id="notice" class="arrow_box "><p>장바구니클릭☆</p></div>
<% 
}
%>

<!-- 해더끝 -->


<div class="box3">

<ul id="car">
	<li><img src="images/car1.png"></li>
	<li><img src="images/car2.png"></li>
	<li><img src="images/car3.png"></li>
	<li><img src="images/car4.png"></li>
	<li><img src="images/car5.png"></li>
	<li><img src="images/car6.png"></li>
	<li><img src="images/car7.png"></li>
	<li><img src="images/car8.png"></li>
    <li><img src="images/car9.png"></li>
</ul>

</div>

<!-- 카 애니메이션 들어갈 곳 -->
<hr size="10" color="#OCOCOC" >


<!-- 불닭 알탕 닭도리탕 사진링크 -->

<div class ="box6">
<div class ="box6-1">
<div class="food">
<img src="images/food1.jpg">
<h1 id="1">불닭</h1>
<a href="shop/list.jsp?food_kind=100"><p>Hot & Spicy Chicken<br>
불닭의 알딸딸한 맛</p></a>

</div>

</div>

<div class ="box6-2">

<div class="food">
<img src="images/food2.jpg">
<h1 id="2">닭도리탕</h1>
<a href="shop/list.jsp?food_kind=200"><p>H Spaicy Braised Chicken w/Potatoes<br>
감자와 함께하는 얼큰한 닭의 맛</p></a>

</div>



</div>

<div class ="box6-3">


<div class="food">
<img src="images/food3.jpg">
<a href="#">
<h1 id="3">알탕</h1>
<a href="shop/list.jsp?food_kind=300"><p>Fish Egg Stew w/ Vegetables<br>
알탕의 꼬소한 맛</p></a>
</a>
</div>
</div>

</div>
<!-- 불닭 알탕 닭도리탕 사진링크 -->




<!-- 뉴스게시판 -->
<div class="box4">
<div class="box4-1">


<div class="news">
<h1>얌얌을 맛본 다른이들의 평가는?</h1>

<ul>
<%

BoardDAO bdao = new BoardDAO();
List boardList=null;
int count = bdao.getBoardCount();
SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd");

if(count==0){
	%>
	
	<li>
	<div class="text" style="color:#4040FF "><a href="board/list.jsp">게시판글없음</a></div></li>
	<%
}else{
	boardList = bdao.getBoards(1, 5);
	for(int i=0; i<boardList.size(); i++){
		BoardBean bb = (BoardBean)boardList.get(i);
	%>
	<li><a href="board/list.jsp">
	<div class="text">
	<time><%=sdf.format(bb.getDate()) %></time>
	<%
	int wid = 0;
	if(bb.getRe_lev()>0){
		wid = 15*bb.getRe_lev();
	%>
	<img src="board/level.gif" width="<%=wid%>" height="16">
    <img src="images/go1.png" width="10" height="15">
	<%
	}
	%>
   
	<%=bb.getSubject() %>  <label></label></div></a></li>
<%
}
}
%>


</ul>
</div>
</div> 


<!-- 뉴스 게시판 -->


<div class="box4-2">

<div class="follow-info"><p>당신이 원하는 그맛! 골라보세요!</p></div>
<div class="follow">

<ul>
<li><a href="shop/list.jsp?food_kind=100" class="sns1"><p class="face" id='4'>매운맛</p></a></li>
<li><a href="shop/list.jsp?food_kind=200" class="sns2"><p class="face" id="5">보통맛</p></a></li>
<li><a href="shop/list.jsp?food_kind=300" class="sns3"><p class="face" id="6">순한맛</p></a></li>
</ul>
</div>
</div>
</div>


    
<!-- 바텀시작 -->
<div class="box5">
<div class="box5-inner">
<div class="copyright">


<p>YAMYAM, Inc. All rights reserved.</p>

</div>
<div class="admin">
<a href="admin/alogin.jsp">관리자 모드</a>

</div>
</div>

</div>
<!-- 바텀끝 -->





</body>


<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>


<script>
$(document).ready(function(){
	$(".news h1").css('text-align','center')
	
	$('#1').mouseover(function(){
		$('#4').css('font-size','20px')
	
	});
    
    $('#1').mouseout(function(){
	$('#4').css('font-size','10px')
	});


$('#2').mouseover(function(){
	$('#5').css('font-size','20px')

});

$('#2').mouseout(function(){
$('#5').css('font-size','10px')

});

$('#3').mouseover(function(){
	$('#6').css('font-size','20px')

});

$('#3').mouseout(function(){
$('#6').css('font-size','10px')

});

//.mouseover()  .mouseout() 이미지 롤오버
$('.site img').mouseover(function(){

	$('#name').html(function(index,html){
		
		if(<%=id3%>!==null){
		return html +"<%=id3%> 님 오셨어열?ㅋ~"
				}else{
					return html + "얌얌 먹고싶어? 그럼 로그인해!"
				}
		
	}).css('font-size','20px').css('color','#FF00FF').css('float','left').css('margin','15px').css('margin-left','300px')})
	.mouseout(function(){
		$('#name').empty();
		
	})
	

	$('.follow-info').click(function(){
		$(this).next().toggle('slow',function(){
			
		});
	});

$('#notice').click(function(){
	$(this).before().toggle('slow',function(){
		
	});
});

	
//$('.box4-2').css("backgroundImage","url(images/face1.png), width=200px, height=300px;");

   $('#car').innerfade({
	animationtype:'fade',
	speed:100,
	timeout:900,
	

});
   
$('#ga').css('float','right').css('margin-right','350px')
   
 
});

</script>
</html>