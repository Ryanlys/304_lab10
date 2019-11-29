<!DOCTYPE html>
<html>
<head>
<%@ include file="jdbc.jsp" %>

<title>Don't Leaf Me</title>
</head>
<body>
<h2> Edit Product</h2>
<%
try
{
	session = request.getSession(true);
	String pid = (String)session.getAttribute("pidToEdit");
	System.out.println("pid = "+pid);
	String pname = request.getParameter("pname");
	String price = request.getParameter("price");
	String desc = request.getParameter("desc");
	String sql2;
	double price2 = 0;
	getConnection();
	String sql = "select productName,productPrice,productDesc from product where productId =" + pid;
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
	sql = "update product set productName = ?,productPrice = ?,productDesc = ? where productId = "+pid;
	pstmt = con.prepareStatement(sql);
	while(rst.next())
	{
		if(pname.isEmpty())
		{
			pstmt.setString(1,rst.getString(1));
		}
		else
		{
			pstmt.setString(1,pname);
		}
		
		if(price.isEmpty())
		{
			pstmt.setDouble(2,rst.getDouble(2));
		}
		else
		{
			pstmt.setDouble(2,Double.parseDouble(price));
		}
		
		if(desc.isEmpty())
		{
			pstmt.setString(3,rst.getString(3));
		}
		else
		{
			pstmt.setString(3,desc);
		}

	}
	pstmt.executeUpdate();
	out.println("<h2> Product has been updated. </h1>");
	out.println("<h2><a href=\"manageProduct.jsp?id="+pid+"\">"+"Go to product</a></h2>");
}
catch(SQLException e)
{
	e.printStackTrace();
}
finally
{
	closeConnection();
}

%>
<h2><a href="manageProduct.jsp">Back to product list</a></h2>
</body>
</html>