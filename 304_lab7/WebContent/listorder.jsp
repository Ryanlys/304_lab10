<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>This Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_nhendrad;";
String uid = "nhendrad";
String pw = "34089243";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
//System.out.println("Connecting to database.");

try
{
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	
	// Write query to retrieve all order summary records
	ResultSet rst = stmt.executeQuery("select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount from ordersummary,customer where customer.customerId = ordersummary.customerId");
	PreparedStatement pstmt = con.prepareStatement("select productId, quantity from orderproduct where orderId = ?");
	// For each order in the ResultSet
	//System.out.println("before while");
	while(rst.next())
	{
		out.println("<table border=\"1\"><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>CustomerName</th><th>Total Amount</th></tr>");
		out.println("<tr><td>" + rst.getInt(1) + "</td><td>" + rst.getDate(2) + "</td><td>" + rst.getInt(3) + "</td><td>" + rst.getString(4) + " " + rst.getString(5) + "</td><td>" + currFormat.format(rst.getDouble(6))+ "</td></tr><tr align=\"right\"><td colspan=\"5\"><table border=\"1\">");
		pstmt.setInt(1,rst.getInt(1));
		ResultSet rst2 = pstmt.executeQuery();
		out.println("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		while(rst2.next())
		{
			Statement test = con.createStatement();
			ResultSet rst3 = test.executeQuery("select productPrice from product where productId = " + rst2.getInt(1));
			rst3.next();
			out.println("<tr><td>" + rst2.getInt(1)+"</td><td>" + +rst2.getInt(2) + "</td><td>" + currFormat.format(rst3.getDouble(1)) + "</td></tr>");
			
		}
		out.println("</table></td></tr>");
	
	}
	//System.out.println("Stuff should have been done");
	con.close();
}
catch (Exception e)
{
	e.printStackTrace();
}

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

