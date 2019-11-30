<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Don't Leaf Me</title>
</head>
<body>

<h1>Browse Products by Category: </h1>

<% 
	getConnection();

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
	

	Statement getCat = con.createStatement();
	ResultSet cats = getCat.executeQuery("select * from category");
	
	out.println("<table>");
	while (cats.next()){
		String output = "\"InCategory.jsp?id=" + cats.getInt(1) + "&name=" + cats.getString(2);
		out.println("<tr><td><a href=" + output + "\">" + cats.getString(2) + " </a></td></tr>");
	
	} out.println("</table>");

	closeConnection();
	
	if(session.getAttribute("authenticatedUser") != null && session.getAttribute("admin") == "1")
		out.println("<h2><a href=\"adminIndex.jsp\">Back To Main</a></h2>");
	else 
		out.println("<h2><a href=\"index.jsp\">Back To Main</a></h2>");

%>

</body>
</html>