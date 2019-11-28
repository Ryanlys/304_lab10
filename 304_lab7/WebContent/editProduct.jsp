<!DOCTYPE html>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<html>
<head>
<title>Edit Product</title>
</head>
<body>


<h1>Search for the products you want to edit:</h1>

<form method="get" action="editProduct.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<%
String name;
name = request.getParameter("productName");
String pid = request.getParameter("id");
//Note: Forces loading of SQL Server driver
if (pid == null)
{
	try
	{
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_rlam;";
		String uid = "rlam";
		String pw = "54122072";
		Connection con = DriverManager.getConnection(url, uid, pw);
		String name2 = "";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		if (name == null)
		{
			name2 = "%%";
		}
		else
		{
			name2 = "%" + name + "%";	
		} 
		PreparedStatement pstmt = con.prepareStatement("select productId, productName, productPrice from product where productName like ?");
		pstmt.setString(1,name2);
		ResultSet rst = pstmt.executeQuery();
		// Print out the ResultSet
		out.println("<h2>All Products</h2>");
		out.println("<table><tr><th>Product Name</th><th>Price</th></tr>");
		while(rst.next())
		{
			
			out.println("<tr><td><a href=\"editProduct.jsp?id=" + rst.getInt(1)+"\">"+rst.getString(2) + "</a></td><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
			
		}
		out.println("</table>");
	
	//For each product create a link of the form
	//addcart.jsp?id=productId&name=productName&price=productPrice
	//Close connection
		System.out.println("Stuff should have been done");
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	
}
else
{
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_rlam;";
	String uid = "rlam";
	String pw = "54122072";
	Connection con = DriverManager.getConnection(url, uid, pw);
	String imageURL = "";
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("select productImageURL from product where productId = " + pid);
	rst.next();
	boolean hasImage = false;
	if (rst.getString(1) != null)
	{
		imageURL = rst.getString(1);
		hasImage = true;
	}
	else
	{
		hasImage = false;
	}
	String sql = "select productName from product where productId = " + pid;
	rst = stmt.executeQuery(sql);
	if (rst.next())
	{
		
		out.println("<h1>" + rst.getString(1) + "</h1>");
		if(hasImage)
		{
			
			out.println("<img src=\""+imageURL+"\">");
		}
		sql = "select productImage from product where productId = " + pid;
		ResultSet rst2 = stmt.executeQuery(sql);
		rst2.next();
		if(rst2.getString(1) != null)
		{
			out.println("<img src=\"displayImage.jsp?id="+pid+"\">");
		}
	}
	
	out.println("<input type=\"submit\" value=\"Delete\" name=\"button\" formaction=\"delProduct.jsp?id=\""+pid+">");
	
}
%>



</body>
</html>