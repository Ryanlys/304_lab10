<!DOCTYPE html>
<html>
<head>
<%@ include file="jdbc.jsp" %>

<title>Don't Leaf Me</title>
</head>
<body>
<h2> Edit Inventory</h2>
<%
try
{
	session = request.getSession(true);
	String whid = (String)session.getAttribute("whid");
	//String pid = (String)session.getAttribute("pidToEdit");
	//System.out.println("pid = "+pid);
	String pid = request.getParameter("pid");
	String inven = request.getParameter("inven");
	getConnection();
	String sql = "update productinventory set quantity = ? where productId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,inven);
	pstmt.setString(2,pid);
	pstmt.executeUpdate();
	out.println("<h2> Product has been updated. </h1>");
	out.println("<h2><a href=\"manageWarehouse.jsp?id="+whid+"\">"+"Go to warehouse</a></h2>");
	out.println("<h2><a href=\"warehouse.jsp\">Return to warehouse list</a></h2>");
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