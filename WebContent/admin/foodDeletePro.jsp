<%@page import="shop.ShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8");%>

<%
  int food_id = Integer.parseInt(request.getParameter("food_id"));
  String food_kind = request.getParameter("food_kind");
 
  ShopDAO foodProcess = new ShopDAO();
  foodProcess.deleteFood(food_id);

  response.sendRedirect("foodList1.jsp?food_kind="+food_kind);
  %>
  