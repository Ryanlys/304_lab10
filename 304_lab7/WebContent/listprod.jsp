<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>MY NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
try
{
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_rlam;";
	String uid = "rlam";
	String pw = "54122072";
	String name2 = "";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	// Make the connection
	Connection con = DriverManager.getConnection(url, uid, pw);
	System.out.println("Connecting to database...");
	
	PreparedStatement pstmt = con.prepareStatement("select productId, productName, productPrice from product where productName like ?");
	if (name == null)
	{
		name2 = "%%";
	}
	else
	{
		name2 = "%" + name + "%";	
	} 
	System.out.println("stuff here");
	pstmt.setString(1,name2);
	ResultSet rst = pstmt.executeQuery();
	// Print out the ResultSet
	out.println("<h2>All Products</h2>");
	out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
	while(rst.next())
	{
		String output = "\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\">";
		out.println("<tr><td><a href=" + output + "AddToCart</a></td><td>" + "<a href=\"product.jsp?id=" + rst.getInt(1)+"\">"+rst.getString(2) + "</a></td><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		
	}
	out.println("</table>");

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection
	System.out.println("Stuff should have been done");
	con.close();
}
catch (Exception e)
{
	
}
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>