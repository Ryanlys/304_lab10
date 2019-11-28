<!DOCTYPE html>
<html>
<head>
<title>Your Info</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	//out.println("<h1>Hi " + session.getAttribute("authenticatedUser") + "!</h1>");

// TODO: Print Customer information

try {

	getConnection();

String sql = "SELECT * FROM customer WHERE userid = ? ";
PreparedStatement P = con.prepareStatement(sql);
P.setString(1, userName);
ResultSet R = P.executeQuery();

R.next();
out.print("<table class=\"table\" border=\"1\">");
out.print("<tr><th>Id</th><td>" + R.getInt(1) + "</td></tr>");
out.print("<tr><th>First Name</th><td>" + R.getString(2) + "</td></tr>");
out.print("<tr><th>Last Name</th><td>" + R.getString(3) + "</td></tr>");
out.print("<tr><th>Email</th><td>" + R.getString(4) + "</td></tr>");
out.print("<tr><th>Phone</th><td>" + R.getString(5) + "</td></tr>");
out.print("<tr><th>Address</th><td>" + R.getString(6) + "</td></tr>");
out.print("<tr><th>City</th><td>" + R.getString(7) + "</td></tr>");
out.print("<tr><th>State</th><td>" + R.getString(8) + "</td></tr>");
out.print("<tr><th>Postal Code</th><td>" + R.getString(9) + "</td></tr>");
out.print("<tr><th>Country</th><td>" + R.getString(10) + "</td></tr>");
out.print("<tr><th>User id</th><td>" + R.getString(11) + "</td></tr>");
out.println("</table>");

} catch (SQLException e){
	out.println(e);
} finally {
	closeConnection();
}

%>

</body>
</html>

