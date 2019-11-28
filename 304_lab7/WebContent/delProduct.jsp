<!DOCTYPE html>
<html>
<head>
<title>Delete Product</title>
<%@ include file="jdbc.jsp" %>
</head>
<body>
<%
try
{
	String pid = (String)session.getAttribute("pidToEdit");
	getConnection();
	String sql = "delete from product where productId = "+pid;
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.executeUpdate();
	out.println("<h1> Product has been deleted. </h1>");
	out.println("<h1><a href=\"manageProduct.jsp\">Return to product list</a></h2>");
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

</body>
</html>