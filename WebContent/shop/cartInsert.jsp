<%@page import="Cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8");%>

<%
	
   String food_kind = request.getParameter("food_kind");
   String buy_count = request.getParameter("buy_count");
   String Food_id = request.getParameter("food_id");
   String Food_name = request.getParameter("food_name");
   String Food_image = request.getParameter("food_image");
   String buy_price = request.getParameter("buy_price");
   String buyer = (String)session.getAttribute("id3");
%>

<jsp:useBean id="cart" scope="page" class="Cart.CartBean">
</jsp:useBean>

<%
  cart.setFood_id(Integer.parseInt(Food_id));
  cart.setFood_image(Food_image);
  cart.setFood_name(Food_name);
  cart.setBuy_count(Integer.parseInt(buy_count));
  cart.setBuy_price(Integer.parseInt(buy_price));
  cart.setBuyer(buyer);
  
  CartDAO  a = new CartDAO();
  a.insertCart(cart);
  
  
 response.sendRedirect("cartList.jsp");
%>
