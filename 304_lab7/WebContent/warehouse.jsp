<!DOCTYPE html>
<html>
<head>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<title>Don't Leaf Me</title>
</head>

<body>
<h2> Warehouses</h2>

<form method="get" action="warehouse.jsp">
<input type="text" name="whName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all warehouses)
</form>
<%
try
{
	String name;
	name = request.getParameter("whName");
	getConnection();
	String sql;
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	if (name == null)
	{
		sql = "select warehouseName,warehouseId from warehouse";
	}
	else
	{
		sql = "select warehouseName,warehouseId from warehouse where warehouseName like %" + name + "%";	
	} 
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
	// Print out the ResultSet
	out.println("<h2>All Warehouses</h2>");
	out.println("<table>");
	while(rst.next())
	{
		
		out.println("<tr><td><a href=\"manageWarehouse.jsp?id=" + rst.getInt(2)+"\">"+rst.getString(1) + "</a></td></tr>");
		
	}
	out.println("</table>");
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

<h2><a href="adminIndex.jsp">Back to home page</a></h2>

</body>
</html>