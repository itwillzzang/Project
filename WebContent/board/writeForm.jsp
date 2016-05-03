<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#main{
width:800px;
margin:0 auto;
padding-top:50px;

}

</style>
</head>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">

<script src="../j/jquery-1.12.1.js"></script>
<script type="text/javascript">




function check() {
		//필수조건 제어
		//if(document.fr.id.value.length<1){	
	    if(document.fr.name.value.length<1||document.fr.name.value.length>6){	
			alert("1자리에서 6자리까지만");
			document.fr.name.focus();
			return false;
		}
	
		if(document.fr.passwd.value.length<1||document.fr.passwd.value.length>6){	
			alert("1자리에서 6자리까지만");
			document.fr.passwd.focus();
			return false;
		}
		
		
		
	
		//submit() 전송 
// 		document.fr.submit();
	}





</script>


<body>

<jsp:include page="../inc/top2.jsp"/>
<div id="main">
<h1>맛없어도 맛있다고 적어~!</h1>
<form action="writePro.jsp" method="post" name="fr" onsubmit="return check()">
<table border="1">
<tr><td>글쓴이</td><td><input type="text" name="name"></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="passwd"></td></tr>
<tr><td>맛</td><td><select name="mi"><option value="매운맛">매운맛</option><option>보통맛</option><option>순한맛</option></select>
<tr><td>제목</td><td><input type="text" name="subject"></td></tr>
<tr><td>내용</td>
    <td><textarea name="content" rows="15" cols="67"></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
</table>
</form>

</div>


<script>

$(document).ready(function(){

});
</script>

	
	</body>

</html>


