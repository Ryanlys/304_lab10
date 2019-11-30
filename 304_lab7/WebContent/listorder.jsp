<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Order List</title>
</head>
<body>
<h1>Order List</h1>
<form method="get" action="listorder.jsp">
<input type="text" name="orderId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all orders)
</form>
<%
getConnection();
String orderId = request.getParameter("orderId");
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String sql;
		if (orderId == null || orderId.isEmpty())
		{
			sql = "select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount, status from ordersummary,customer where customer.customerId = ordersummary.customerId";
		}
		else
		{
			sql = "select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount, status from ordersummary,customer where customer.customerId = ordersummary.customerId and ordersummary.orderId = " + orderId;
		}
		PreparedStatement pstmt;
		try
		{	
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(sql);
			while(rst.next())
			{
				out.println("<table border=\"1\"><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>CustomerName</th><th>Total Amount</th><th>Status</th></tr>");
				out.println("<tr><td>"+"<a href=\"editOrder.jsp?orderId="+rst.getInt(1)+"\">" +rst.getInt(1)+"</a></td><td>" + rst.getDate(2) + "</td><td>" + rst.getInt(3) + "</td><td>" + rst.getString(4) + " " + rst.getString(5) + "</td><td>" + currFormat.format(rst.getDouble(6))+ "</td><td>"+rst.getString(7)+"</td></tr><tr align=\"left\"><td colspan=\"5\"><table border=\"1\">");
				pstmt = con.prepareStatement("select orderproduct.productId, quantity,productName from orderproduct,product where orderproduct.productId = product.productId and orderId = ?");
				pstmt.setInt(1,rst.getInt(1));
				ResultSet rst2 = pstmt.executeQuery();
				out.println("<th>Product Id</th><th>Product Name</th> <th>Quantity</th> <th>Price</th></tr>");
				while(rst2.next())
				{
					Statement test = con.createStatement();
					ResultSet rst3 = test.executeQuery("select productPrice from product where productId = " + rst2.getInt(1));
					rst3.next();
					out.println("<tr><td>" + rst2.getInt(1)+"</td><td>" +rst2.getString(3)+"</td><td>"+ +rst2.getInt(2) + "</td><td>" + currFormat.format(rst3.getDouble(1)) + "</td></tr>");
					
				}
				out.println("</table></td></tr>");
				out.println("</table>");
			
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
%>
<h2><a href="adminIndex.jsp">Back to Homepage</a></h2>
</body>
</html>

