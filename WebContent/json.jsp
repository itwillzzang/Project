<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//배열객체 생성
JSONArray arr=new JSONArray();
//자바빈 객체 
//JSONObject obj=new JSONObject();
		String url="jdbc:mysql://yamyam12.cafe24.com:3306/yamyam12";
		String dbuser="yamyam12";
		String dbpass="yam1212^^";
		Connection con=null;
		PreparedStatement pstmt=null;
		String sql="";
		ResultSet rs=null;
try{
		//1단계 드라이버로더
		Class.forName("com.mysql.jdbc.Driver");
		//2단계 디비연결
		con=DriverManager.getConnection(url,dbuser,dbpass);
//3단계 sql member테이블  id  passwd  name
sql="select food_name,food_price,food_content from food";
pstmt=con.prepareStatement(sql);
//4단계 rs 실행 저장
rs=pstmt.executeQuery();
//5단계 rs 데이터 있으면  rs => 자바빈 저장 => 배열한칸 저장
while(rs.next()){
	//자바빈 객체 생성
	JSONObject obj=new JSONObject();
	//rs => 자바빈 저장
	obj.put("id", rs.getString("food_name"));
	obj.put("passwd", rs.getString("food_price"));
	obj.put("name", rs.getString("food_content"));
	//자바빈 => 배열 저장
	arr.add(obj);
}
}catch(Exception e){
	e.printStackTrace();
}
out.println(arr);
%>

