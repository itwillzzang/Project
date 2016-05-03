<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<script src="../j/jquery-1.12.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 태그:odd  태그:even  태그:first  태그:last
		// tr:odd background 
		$('input').css('background','#FFFF80').css('color','green').css('font-size','20px').css('margin','10px');
		$('label').css('color','#717171');
		$('h1').css('color','#FF8000').css('font-size','80px');
		$('body').css('margin','0 auto').css('background','#FFE0C0');
		$('article').css('width','700px').css('margin','0 auto').css('height','700px')
		$('fieldset').css('background','#FFFFFF').css('border','none');
	});
</script>

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/top.css">
<script>

function check() {
		//필수조건 제어
		//if(document.fr.id.value.length<1){	
	
		 if(document.fr.id.value.length<1||document.fr.id.value.length>6){	
				alert("아이디는 1자리에서 6자리까지만");
				document.fr.id.focus();
				return false;
			}
		 if(document.fr.passwd.value.length<1||document.fr.passwd.value.length>6){	
				alert("비밀번호는 1자리에서 6자리까지만");
				document.fr.passwd.focus();
				return false;
			}
		 if(document.fr.passwd2.value.length<1||document.fr.passwd2.value.length>6){	
				alert("뭐여!위에꺼랑똑같이쳐");
				document.fr.passwd2.focus();
				return false;
			}
		
		if(document.fr.passwd.value!==document.fr.passwd2.value){
		alert("비밀번호한번더확인해라")	
		document.fr.passwd2.focus();
		return false;
		
		}
		
		if(document.fr.name.value.length<1){	
			alert("니이름은어따뒀어?");
			document.fr.name.focus();
			return false;
		}
		if(document.name.id.value.length>6){	
			alert("이름이 너무길잔아 6자리까지만써!");
			document.fr.name.focus();
			return false;
		}
		if(document.fr.gender[0].checked==false && document.fr.gender[1].checked==false){
			//체크박스[0] 포커스
			alert("성별을 선택하세요");
			return false;
		}
		if(document.fr.email.value.length<1){	
			alert("이메일을  입력하세요");
			document.fr.email.focus();
			return false;
		}
		if(document.fr.mobile.value.length<1){	
			alert("니폰번호먼데?");
			document.fr.mobile.focus();
			return false;
		}
		//submit() 전송 
// 		document.fr.submit();
	}
</script>

 <script type="text/javascript">
 	function idcheck() {
 		if(document.fr.id.value==""){
 			alert("아이디입력하세요");
 			document.fr.id.focus();
 			return;
 		}
 		fid=document.fr.id.value;
		window.open("join_idcheck.jsp?userid="+fid,"", "width=400,height=200");
	}
 </script>

</head>
<body>


<jsp:include page="../inc/top.jsp"/>

<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>얌얌 먹고 싶나? </br>가입하라!</h1>
<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return check()">
<fieldset>
<label>아이디를쓰시오</label>
<input type="text" name="id" class="id">
<input type="button" value="아이디중복확인" class="dup" onclick="idcheck()"><br>
<label>패스워드를쓰시오</label>
<input type="password" name="passwd"><br>
<label>다시한번패스워드</label>
<input type="password" name="passwd2"><br>
<label>너의이름은무엇?</label>
<input type="text" name="name"><br>
<label>남자야 여자야?</label>
<input type="radio" name="gender" value="남">남
<input type="radio" name="gender" value="여">여<br>


<label>E-Mail</label>
<input type="email" name="email"><br>

<label>폰번호머야?</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit" >
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>


</body>


</html>