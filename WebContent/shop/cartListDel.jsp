<%@page import="Cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String list = request.getParameter("list");
   String buyer = (String)session.getAttribute("id3");
   String food_kind = request.getParameter("food_kind");
   String id = (String)session.getAttribute("id3");
   if(id==null){
	   response.sendRedirect("list.jsp");        
   }else{
	 	CartDAO foodProcess = new CartDAO();
	   if(list.equals("all")){
	       foodProcess.deleteAll(buyer);
	   }else{
	 	   foodProcess.deleteList(Integer.parseInt(list));
	   }
	   
	   response.sendRedirect("cartList.jsp?food_kind="+food_kind);
  }
%>