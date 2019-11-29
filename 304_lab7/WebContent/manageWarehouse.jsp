<!DOCTYPE html>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<html>
<head>
<title>Don't Leaf Me</title>
</head>
<body>


<h1>Warehouse Details:</h1>


<%
String id = request.getParameter("id");
session.setAttribute("whid",id);
id = (String)session.getAttribute("whid");

getConnection();
String sql;
String whName = request.getParameter("whName");
PreparedStatement pstmt;

//Note: Forces loading of SQL Server driver
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
sql = "select warehouseName,warehouseId from warehouse where warehouseId =" + id;
pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
System.out.println(rst.next());
out.println("<h2>" + rst.getString(1) + "</h2>");
sql = "select product.productId, quantity, price, productName from productinventory,product where productinventory.productId = product.productId and warehouseId =" + id;
pstmt = con.prepareStatement(sql);
rst = pstmt.executeQuery();
out.println("<table border=\"1\"><tr><th>Product Id</th><th>Product name</th><th>Quantity</th> <th>Price</th></tr>");
while(rst.next())
{
	out.println("<tr><td>" + rst.getInt(1)+"</td><td>" + rst.getString(4) +"</td><td>"+rst.getInt(2) + "</td><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
			
}	
out.println("</table></td></tr>");
out.println("<form name=\"MyForm\" method=post action=\"editWarehouse.jsp\">");
out.println("<table style=\"display:inline\">");
out.println("<tr>");
out.println("<td><div align=\"right\"><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Product id:</font></div></td>");
out.println("<td><input type=\"text\" name=\"pid\"  size=10 maxlength=10></td></tr> ");
out.println("<tr><td><div align=\"right\"><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Product Inventory:</font></div></td>");
out.println("<td><input type=\"text\" name=\"inven\" size=10 maxlength=\"50\"></td></tr>  ");
out.println("</table>");
out.println("<input class=\"submit\" type=\"submit\" name=\"Submit2\" value=\"Edit\"> <input type=\"reset\" value=\"Reset\">");
out.println("</form>");

out.println("<form name=\"MyForm\" method=post action=\"editWarehouse.jsp\">");
out.println("<table style=\"display:inline\">");
out.println("<tr>");
out.println("<td><div align=\"right\"><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Warehouse Name:</font></div></td>");
out.println("<td><input type=\"text\" name=\"whName\"  size=10 maxlength=10></td></tr> ");
out.println("</table>");
out.println("<input class=\"submit\" type=\"submit\" name=\"Submit2\" value=\"Update\"> <input type=\"reset\" value=\"Reset\">");
out.println("</form>");

%>

<h2><a href="warehouse.jsp">Back to warehouse list</a></h2>

</body>
</html>