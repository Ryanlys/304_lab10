
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>

<html>
<head>

<title>Don't Leaf Me</title>
</head>
<body align="center">

<%
	session = request.getSession(true);

	String customerId = (String) session.getAttribute("customerId");
	String rating = request.getParameter("rating");
	String productId = (String) session.getAttribute("productId");
	String reviewDescription = request.getParameter("reviewDescription");

	// Get current date/time
	DateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
	Date date = new Date();
	String datetime = dateFormat.format(date);

	try {
		getConnection();
		Statement s = con.createStatement();

		PreparedStatement pst1 = con.prepareStatement("INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, ?, ?, ?, ?)");
		pst1.setString(1, rating);
		pst1.setString(2, datetime);
		pst1.setString(3, customerId);
		pst1.setString(4, productId);
		pst1.setString(5, reviewDescription);

		pst1.executeUpdate();
		out.println("<h2>Your review has been submitted successfully! Thank you for helping other buyers with your insights!</h2>");

		session.removeAttribute("customerId");
		session.removeAttribute("productId");

		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace();
		out.println(e);
	}
%>

</BODY>
</HTML>
