<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
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



<body>


<jsp:include page="../inc/top2.jsp"/>


<%
//전체 게시판 글수
//디비 객체 생성 BoardDAO  bdao
BoardDAO bdao=new BoardDAO();
//변수  int count = 메서드호출    getBoardCount()
int count=bdao.getBoardCount();
//게시판 한페이지에 글 개수 설정
int pageSize=10;
//게시판 현페이지 번호 가져오기
String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
}
//시작하는 행 구하기 
int currentPage=Integer.parseInt(pageNum);
int startRow=(currentPage-1)*pageSize+1;
//끝행 구하기
int endRow=currentPage*pageSize;

//디비에서  시작하는 행  ~ pageSize 개수 만큼 가져오기
List boardList=null;
if(count!=0){
//sql  select * from board	
//         정렬 order by re_ref 내림,re_seq 오름
//             limit 시작행-1,개수
//boardList =메서드호출 글가져오기 getBoards(startRow,pageSize)
boardList=bdao.getBoards(startRow,pageSize);
}
%>
<div id="main">
<h1>맛있었엉? 맛없어엉? <h1>
<h1> <%=count %>개 글있네...! 잘적어라! 전부 읽어본다!<img src="../images/face4.png"></h1>
<h3><a href="writeForm.jsp">게시판 글쓰기</a></h3>
<table border="1">
<tr><td>글번호</td><td>글제목</td><td>글쓴이</td>
    <td>조회수</td><td>글쓴날짜</td><td>IP</td><td>맛</td></tr>
    <%
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd");
    for(int i=0;i<boardList.size();i++){
    	BoardBean bb=(BoardBean)boardList.get(i);
    	%>
    <tr><td><%=bb.getNum() %></td>
        <td>
        <%
        //답변글이면 이미지 보여주기
        int wid=0; //이미지 너비
    
        if(bb.getRe_lev()>0){//답변글이면
        	wid=10*bb.getRe_lev();
        	%>
        	<img src="level.gif" width="<%=wid%>" height="15">
			
        	
        	<img src="re.gif">
        	<% 
        	
        }
        %>
        <a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>&getMi=<%=bb.getMi()%>"><%=bb.getSubject() %></a></td>
        <td><%=bb.getName() %></td>
    <td><%=bb.getReadcount() %></td>
    <td><%=sdf.format(bb.getDate()) %></td>
     <td><%=bb.getIp() %></td>
    <td><%=bb.getMi() %></td></tr>	
    	<%
    }
    %>
</table>
<%
if(count>0){
	// 전체 페이지수   전체글수/pageSize  50글/10페이지사이즈=>5
	//     55글/10페이지사이즈 => 50/10 => 5 + 나머지5개글  1페이지          
	int pageCount=count/pageSize+(count%pageSize==0?0:1);
	// 한페이지에 보여줄 페이지 수 설정
	int pageBlock=10;
	// 한페이지에서 시작페이지번호 구하기 1(1~10) 11(11~20) 21(21~30) 31(31~40)
	int startPage=(currentPage/pageBlock-(currentPage%pageBlock==0?1:0))*pageBlock+1;
	// 한페이지에서 마지막페이지번호 구하기
	int endPage=startPage+pageBlock-1;
	if(endPage > pageCount){
		endPage=pageCount;
	}
	if(startPage > pageBlock){
		%><a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a><%
	}
	for(int i=startPage;i<=endPage;i++){
		%><a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a><%
	}
	if(endPage < pageCount){
		%><a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a><%
	}
}
%>
<br>
<h2><a href="../index.jsp">메인으로</a></h2>
	
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('h1 img').mouseover(function(){$('h2').html(function(index,html){
			return '뭘봐? 여기계속 있어 돌아가지마!';
		});})

		$('table').css('width','800px').css('margin','auto 0').css('text-alian','center')
	});
</script>





</body>
</html>





