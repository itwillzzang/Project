<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
<style>
p{

text-align:center;

}
ul li{
list-style:none;
margin:20px;
text-decoration:none;

}

a{
color: white;

}
header{
background:#062C8E;
padding:20px;
height:80px;

}
header img{
height:80px;
}
#main{
margin-left:350px;

}
body{
background:#DCF1F7

}
#content{
width:1500px;
height:750px;
margin:0 auto;
margin-left:300px;

}

#div1{

float:left;
display:block;
background:#164CC5;
height:260px;
padding-top:20px;
}

#div2{
float:left;
display:block;
background:#CED8F1;
height:700px;
width:800px;
}
#div3{
float:left;
display:block;

}

#div3 img{
width:200px;
hight:200px;
}
#div3 img{ 
animation:aaa 1s; 

}
@keyframes aaa{
from{height:10px; }
20%{height:20px; }
25%{height:50px; }
80%{height:100px;}
100%{height:200px;}
}

h3{
text-align:center;
}
ul p{
color:#BAC8EA;
padding-right:30px;
font-size:20px;
}

.a{animation-name:a;
animation-duration:2s;
float:left;
display:block;}

@keyframes a{
from{left:0; transform:rotate(0deg);}
50%{left:500px}
to{left:500px; transform:rotate(360deg);}

}
.b{
display:block;
float:;
margin-left:100px;
}
</style>



</head>


<body>


<header>

<div id="main">

<img src="../images/a.png" alt="yamyam">
<div class="a"><img src="../images/face3.png" alt="yamyam"></div>

</div>
<div class="b"><h2 style="color:white">고객은 왕~</h2></div>

</header>


<div id="content">

<div id="div1">
<jsp:include page="left.jsp"/>

</div>


<div style="overflow:scroll" id="div2">

<jsp:include page="list.jsp"/>

</div>
<div id="div3">
<a href="../index.jsp"><img src="../images/c2.png" alt="yamyam"></a>

</div>
</div>

<jsp:include page="../inc/bottom.jsp"/>




</body>
</html>