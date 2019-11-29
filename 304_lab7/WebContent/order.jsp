<!DOCTYPE html>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<html>
<head>

<title>Don't Leaf Me</title>
</head>
<body>
<h2> Edit order details</h2>
<%
String orderId = request.getParameter("id");
getConnection();
try
{
	Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	
	// Write query to retrieve all order summary records
	ResultSet rst = stmt.executeQuery("select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount from ordersummary,customer where customer.customerId = ordersummary.customerId and ordersummary.orderId = "+orderId);
	PreparedStatement pstmt = con.prepareStatement("select productId, quantity from orderproduct where orderId = ?");
	// For each order in the ResultSet
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
	
	out.println("<form action=\"orderStatus.jsp?orderId="+orderId+"\" method=\"get\"");
	out.println("<input type = \"text\" list = \"options\" name=\"options\">");
	out.println("<datalist id = \"options\"");
	out.println("<option value = \"Shipped\">");
	out.println("<option value = \"Canceled\">");
	out.println("<option value = \"Recieved\">");
	out.println("</datalist>");
	out.println("<input type = \"submit\" value = \"Confirm\"");
}
catch (SQLException e)
{
	e.printStackTrace();
}
finally
{
	closeConnection();
}


%>
</body>
</html>