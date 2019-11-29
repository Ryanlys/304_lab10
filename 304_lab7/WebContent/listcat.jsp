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

<form method="get" action="listcat.jsp">
<input type="text" name="categoryName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all categories)
</form>


<% // Get product name to search for
	String categoryName = request.getParameter("categoryName");
	getConnection();

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

	PreparedStatement pstmt = con.prepareStatement("select * from category where categoryName like ?");
	if (categoryName == null){
		Statement s = con.createStatement();
		ResultSet r = s.executeQuery("select categoryName from category");
		out.println("<table>");
		out.println("<tr><th>Categories</th></tr>");
		
		while (r.next()){
			out.println("<tr><td>" + r.getString(1) + "</td></tr>");
		} out.println("</table>");
	} else {
		categoryName = "%" + categoryName + "%";
		out.println("<h2>Search Result</h2>");
	}
	
	pstmt.setString(1,categoryName);
	ResultSet R = pstmt.executeQuery();
	
	// Print out the ResultSet
	
	out.println("<table>");
	
	PreparedStatement P = con.prepareStatement("select productId, productName, productPrice from product where categoryId = ?");
	ResultSet rst = null;
	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	out.println("<table>");
	
	while(R.next()) {
		
		out.print("<tr><th>Category: </th>");
		out.println("<th>" + R.getString(2) + "<th></tr>");
		
		P.setInt(1, R.getInt(1));
		rst = P.executeQuery();
		
		out.println("<table>");
		out.println("<tr><th></th><th>Product Name</th><th>Price</th></tr>");
		
		while (rst.next()) {
		
			String output = "\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\">";
			out.println("<tr><td><a href=" + output + "Add to cart </a></td><td>" + "<a href=\"product.jsp?id=" + rst.getInt(1)+"\">"+rst.getString(2) + "</a></td><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		
		} out.println("</table>");
		
	} out.println("</table>");

	closeConnection();

%>

</body>
</html>