<!DOCTYPE html>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.sql.*" %>
<html>
<head>

<title>Don't Leaf Me</title>
</head>

<body>
<form method="get" action="orderStatus.jsp">
<input type="text" name="orderId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all orders)
</form>

<h2> Change Order Status</h2>
<h3> Click on the order id to change info</h3>
<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String orderId = request.getParameter("orderId");
String status = request.getParameter("value");
getConnection();
if(status == null)
{
	
	String sql = "";
	if (orderId == null)
	{
		sql = "select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount, status from ordersummary,customer where customer.customerId = ordersummary.customerId";
	}
	else
	{
		sql = "select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount, status from ordersummary,customer where customer.customerId = ordersummary.customerId and ordersummary.orderId = " + orderId;
	}
	try
	{	
		
		Statement stmt = con.createStatement();
	
		ResultSet rst = stmt.executeQuery(sql);
		PreparedStatement pstmt = con.prepareStatement("select productId, quantity from orderproduct where orderId = ?");
		while(rst.next())
		{
			out.println("<table border=\"1\"><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>CustomerName</th><th>Total Amount</th><th>Status</th></tr>");
			out.println("<tr><td>" + "<a href=\"order.jsp?id="+rst.getInt(1) + "\">"+rst.getInt(1)+"</a></td><td>" + rst.getDate(2) + "</td><td>" + rst.getInt(3) + "</td><td>" + rst.getString(4) + " " + rst.getString(5) + "</td><td>" + currFormat.format(rst.getDouble(6))+ "</td><td>"+status+"</td></tr><tr align=\"right\"><td colspan=\"5\"><table border=\"1\">");
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
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		closeConnection();
	}
}
else
{
	String sql = "update ordersummary set status=? where orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,status);
	pstmt.setString(2,orderId);
	pstmt.executeUpdate();
	sql = "select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount, status from ordersummary,customer where customer.customerId = ordersummary.customerId and ordersummary.orderId = " + orderId;
	try
	{	
		
		Statement stmt = con.createStatement();
	
		ResultSet rst = stmt.executeQuery(sql);
		pstmt = con.prepareStatement("select productId, quantity from orderproduct where orderId = ?");
		while(rst.next())
		{
			out.println("<table border=\"1\"><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>CustomerName</th><th>Total Amount</th><th>Status</th></tr>");
			out.println("<tr><td>" + "<a href=\"order.jsp?id="+rst.getInt(1) + "\">"+rst.getInt(1)+"</a></td><td>" + rst.getDate(2) + "</td><td>" + rst.getInt(3) + "</td><td>" + rst.getString(4) + " " + rst.getString(5) + "</td><td>" + currFormat.format(rst.getDouble(6))+ "</td><td>"+status+"</td></tr><tr align=\"right\"><td colspan=\"5\"><table border=\"1\">");
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
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		closeConnection();
	}
}


%>

</body>
</html>