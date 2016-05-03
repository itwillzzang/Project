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

private Connection getConnection() throws Exception{
	Connection con=null;

	Context init=new InitialContext();
	DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/yamyam12");
	con=ds.getConnection();
	return con;
}




//배열객체 생성
JSONArray arr=new JSONArray();
//자바빈 객체 
//JSONObject obj=new JSONObject();

sql="select food_id, food_name, food_price from food";
pstmt=con.prepareStatement(sql);
//4단계 rs 실행 저장
rs=pstmt.executeQuery();
//5단계 rs 데이터 있으면  rs => 자바빈 저장 => 배열한칸 저장
while(rs.next()){
	//자바빈 객체 생성
	JSONObject obj=new JSONObject();
	//rs => 자바빈 저장
	obj.put("food_id", rs.getString("food_id"));
	obj.put("food_name", rs.getString("food_name"));
	obj.put("food_price", rs.getString("food_price"));
	
	
	
	//자바빈 => 배열 저장
	arr.add(obj);
}
}catch(Exception e){
	e.printStackTrace();
}
out.println(arr);
%>

