<!DOCTYPE html>
<html>
<head>
<title>Don't Leaf Me</title>
</head>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<body>
<h2>Change Order Status</h2>
<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String orderId = request.getParameter("orderId");
String status = request.getParameter("status");
getConnection();
PreparedStatement pstmt;
String sql;
if(status != null)
{
	sql = "update ordersummary set status = ? where orderId ="+orderId;
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,status);
	pstmt.executeUpdate();
}

	sql= "select orderId, orderDate, customer.customerId, customer.firstName, customer.lastName, totalAmount, status from ordersummary,customer where customer.customerId = ordersummary.customerId and ordersummary.orderId = " + orderId;
	try
	{	
		
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sql);
		pstmt = con.prepareStatement("select orderproduct.productId, quantity,productName from orderproduct,product where orderproduct.productId = product.productId and orderId = ?");
		while(rst.next())
		{
			out.println("<table border=\"1\"><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>CustomerName</th><th>Total Amount</th><th>Status</th></tr>");
			out.println("<tr><td>"+rst.getInt(1)+"</a></td><td>" + rst.getDate(2) + "</td><td>" + rst.getInt(3) + "</td><td>" + rst.getString(4) + " " + rst.getString(5) + "</td><td>" + currFormat.format(rst.getDouble(6))+ "</td><td>"+rst.getString(7)+"</td></tr><tr align=\"left\"><td colspan=\"5\"><table border=\"1\">");
			pstmt.setInt(1,rst.getInt(1));
			ResultSet rst2 = pstmt.executeQuery();
			out.println("<th>Product Id</th><th>Product Name</th> <th>Quantity</th> <th>Price</th></tr>");
			while(rst2.next())
			{
				Statement test = con.createStatement();
				ResultSet rst3 = test.executeQuery("select productPrice from product where productId = " + rst2.getInt(1));
				rst3.next();
				out.println("<tr><td>" + rst2.getInt(1)+"</td><td>"+rst2.getString(3)+"</td><td>" + +rst2.getInt(2) + "</td><td>" + currFormat.format(rst3.getDouble(1)) + "</td></tr>");
				
			}
			out.println("</table></td></tr>");
			out.println("</table>");
		
		}
		con.close();
		out.println("<form method=\"post\" action=\"editOrder.jsp?orderId="+orderId+"\"");
		out.println("<td><select name=\"status\">");
		out.println("<option value=\"Processing\">Processing</option>");
		out.println("<option value=\"Shipped\">Shipped</option>");
		out.println("<option value=\"Canceled\">Canceled</option>");
		out.println("</td></select>");
		out.println("<td><input type=\"submit\" value=\"Submit\"></td>");
		out.println("</form>");
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
<h2><a href="listorder.jsp">Return to order list</a></h2>
<h2><a href="adminIndex.jsp">Return to home page</a></h2>
</body>
</html>