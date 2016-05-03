<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.Timestamp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>


</style>

<script>




function check() {
		 


	

	
	if(document.writeform.food_name.value.length<1){	
				alert("음식이름을 입력하시오~");
				document.writeform.food_name.focus();
				return false;
			}
		 if(document.writeform.food_price.value.length<1){	
				alert("공짜로 팔꺼나? 부자네~");
				document.writeform.food_price.focus();
				return false;
			}
		 
		if(!/[0-9]/.test(document.writeform.food_count.value)||/[a-z]/.test(document.writeform.food_count.value)){
				
				alert("숫자만을 입력해라!")
				document.writeform.food_price.value="";
				document.writeform.food_price.focus();
				return false;
		}
		
		 if(document.writeform.food_count.value.length<1){	
				alert("하나도 안팔껴?");
				document.writeform.food_count.focus();
				return false;
			}
		 
	if(!/[0-9]/.test(document.writeform.food_count.value)||/[a-z]/.test(document.writeform.food_count.value)){
				
				alert("숫자만을 입력해라!")
				document.writeform.food_count.value="";
				document.writeform.food_count.focus();
				return false;
	}
		 
		 if(document.writeform.food_image.value.length<1){	
				alert("먹음직스러운 사진올려");
				document.writeform.food_image.focus();
				return false;
			}
		 if(document.writeform.food_content.value.length<1){	
				alert("맛있다고 써나야지!!!");
				document.writeform.food_content.focus();
				return false;
			}
}
		</script>


<%
   String id2 ="";
   try{
	 id2 = (String)session.getAttribute("id2");
	   if(id2==null || id2.equals("")){
          response.sendRedirect("alogin.jsp");
	   }else{
%>


<html>
<head>
<title>상품등록</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="checkScript.js"></script>
</head>

<body >  
<center><h1>음식 등록</h1>
<br>

<form method="post" name="writeform" action="foodResisterPro.jsp"  enctype="multipart/form-data" onsubmit="return check()">
<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">
  
   <tr>
    <td  width="100"align="center">맛 선택</td>
    <td  width="400">
       <select name="food_kind">
           <option value="100">매운맛</option>
           <option value="200">보통맛</option>
           <option value="300">순한맛</option>
       </select>
    </td>
  </tr>
  <tr>
    <td  width="100" align="center" >음식이름</td>
    <td  width="400">
        <input type="text" size="50" maxlength="50" name="food_name"></td>
  </tr>
  <tr>
    <td  width="100"   align="center" >가 격</td>
    <td  width="400">
        <input type="text" size="10" maxlength="9" name="food_price">원</td>
  </tr>
  <tr>
    <td  width="100"  align="center" >수량</td>
    <td  width="400">
        <input type="text" size="10" maxlength="3" name="food_count">개</td>
  </tr>

 
  <tr>
    <td  width="100" align="center" >이미지</td>
    <td  width="400">
        <input type="file" name="food_image"></td>
  </tr>
  <tr>
    <td  width="100"   align="center" >내 용</td>
    <td  width="400" >
     <textarea name="food_content" rows="13" cols="40"></textarea> </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" value="음식등록" >  
  <input type="reset" value="다시작성">
</td></tr></table>         
</form>      
</body>
</html>
<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>