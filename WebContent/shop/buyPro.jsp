<%@page import="Buy.BuyDAO"%>
<%@page import="Cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>
<%
   String account = request.getParameter("account");
   String deliveryName = request.getParameter("deliveryName");
   String deliveryTel = request.getParameter("deliveryTel");
   String deliveryAddess = request.getParameter("deliveryAddess");
   String buyer = (String)session.getAttribute("id3");
   
   CartDAO cartProcess = new CartDAO();
   Vector cartLists = cartProcess.getCart(buyer);
   
   BuyDAO buyProcess = new BuyDAO();
   
   buyProcess.insertBuy(cartLists,buyer,account, deliveryName, deliveryTel, deliveryAddess);
   
   response.sendRedirect("buyList.jsp");
%>