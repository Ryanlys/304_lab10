<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
</head>
<body>
<%@ include file="jdbc.jsp" %>

<% 
if (request.getParameter("pname") == null)
{
	
}
else
{
	try
	{
		getConnection();
		String pname = request.getParameter("pname");
		double price = Double.parseDouble(request.getParameter("price"));
		String desc = request.getParameter("desc");
		String whid = request.getParameter("whid");
		String inven = request.getParameter("inven");
		
		String sql = "insert into product(productPrice,productName,productDesc) values (?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setDouble(1,price);
		pstmt.setString(2,pname);
		pstmt.setString(3,desc);
		pstmt.executeUpdate();
		sql = "select productId from product order by productId desc";
		pstmt = con.prepareStatement(sql);
		ResultSet rst = pstmt.executeQuery();
		rst.next();
		int pid = rst.getInt(1);
		sql = "insert into productinventory(warehouseId, productId,quantity,price) values (?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,whid);
		pstmt.setInt(2,pid);
		pstmt.setString(3,inven);
		pstmt.setDouble(4,price);
		
		
		pstmt.executeUpdate();
		
		out.println("<h2> Product Added! </h2>");

	}
	catch (SQLException e)
	{
		e.printStackTrace();
	}
	finally
	{
		closeConnection();
	}
}
%>

<form name="MyForm" method=post action="addProduct.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></div></td>
		<td><input type="text" name="pname"  size=10 maxlength=10></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Price:</font></div></td>
		<td><input type="text" name="price" size=10 maxlength="10"></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Description:</font></div></td>
		<td><input type="text" name="desc" size=10 maxlength="50"></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Warehouse ID:</font></div></td>
		<td><input type="text" name="whid" size=10 maxlength="50"></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Inventory:</font></div></td>
		<td><input type="text" name="inven" size=10 maxlength="50"></td>
	</tr>
	</table>
	<br/>
	<input class="submit" type="submit" name="Submit2" value="Add">
</form>
<h2><a href="manageProduct.jsp">Back to product list</a></h2>
<h2><a href="adminIndex.jsp">Back to Homepage</a></h2>

</body>
</html>