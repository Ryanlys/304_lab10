<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator Home Page</title>
</head>
<body>
<%

if(session.getAttribute("authenticatedUser") != null)
{
	String name = (String) session.getAttribute("authenticatedUser");
	String name1 = name.substring(0,1);
	String name2 = name1.toUpperCase();
	out.println("<h1>Hi " +  name2 + name.substring(1)+ "!</h1>");
}
	
%>

<h1 align="center">Welcome to Don't Leaf Me</h1>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customers.jsp">List All Customers</a></h2>

<h2 align="center"><a href="yourInfo.jsp">Your Info</a></h2>

<h2 align="center"><a href="admin.jsp">Financial Report</a></h2>

<h2 align="center"><a href="orderStatus.jsp">Change Order Status</a></h2>

<h2 align="center"><a href="addProduct.jsp">Add Product</a></h2>

<h2 align="center"><a href="manageProduct.jsp">Manage Products</a></h2>

<h2 align="center"><a href="warehouse.jsp">Warehouses</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

</body>
</html>