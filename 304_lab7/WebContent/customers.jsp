<!DOCTYPE html>
<html>
<head>
<title>All Customers</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%

try
{
	getConnection();
	
	String sql = "select * from customer";
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
	
	while(rst.next())
	{
		out.println("<table class=\"table\" border=\"1\">");
		out.print("<tr><th>Id</th><td>" + rst.getInt(1) + "</td></tr>");
		out.print("<tr><th>First Name</th><td>" + rst.getString(2) + "</td></tr>");
		out.print("<tr><th>Last Name</th><td>" + rst.getString(3) + "</td></tr>");
		out.print("<tr><th>Email</th><td>" + rst.getString(4) + "</td></tr>");
		out.print("<tr><th>Phone</th><td>" + rst.getString(5) + "</td></tr>");
		out.print("<tr><th>Address</th><td>" + rst.getString(6) + "</td></tr>");
		out.print("<tr><th>City</th><td>" + rst.getString(7) + "</td></tr>");
		out.print("<tr><th>State</th><td>" + rst.getString(8) + "</td></tr>");
		out.print("<tr><th>Postal Code</th><td>" + rst.getString(9) + "</td></tr>");
		out.print("<tr><th>Country</th><td>" +rst.getString(10) + "</td></tr>");
		out.print("<tr><th>User id</th><td>" + rst.getString(11) + "</td></tr>");
		String admin = "";
		if (rst.getInt(13) == 1)
		{
			admin = "Admin";
		}
		else
		{
			admin = "User";
		}
		out.print("<tr><th>Admin Status</th><td>" + admin+ "</td></tr>");
		out.println("</table>");
	}
	
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
</body>
</html>