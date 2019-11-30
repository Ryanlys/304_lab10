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

<% // Get product name to search for
	String categoryId = request.getParameter("id");
	String categoryName = request.getParameter("name");
	getConnection();
	
	int id = Integer.parseInt(categoryId);

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
	
	PreparedStatement P = con.prepareStatement("select productId, productName, productPrice from product where categoryId = ?");
	P.setInt(1, id);	
	ResultSet rst = P.executeQuery();
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	out.println("<h3>" + categoryName + "</h3>");
	out.println("<table>");
	out.println("<tr><th></th><th>Product Name</th><th>Price</th></tr>");
		
	while (rst.next()) {
		
		String output = "\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\">";
		out.println("<tr><td><a href=" + output + "Add to cart </a></td><td>" + "<a href=\"product.jsp?id=" + rst.getInt(1)+"\">"+rst.getString(2) + "</a></td><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		
	} out.println("</table>");

	closeConnection();

%>

</body>
</html>