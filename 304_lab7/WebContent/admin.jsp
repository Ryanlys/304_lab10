<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administrator Page</title>
</head>
<body>

<%

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

// TODO: Write SQL query that prints out total order amount by day

try {
	getConnection();
	String sql = "SELECT YEAR(orderDate), MONTH(orderDate), DAY(orderDate), SUM(totalAmount) FROM ordersummary GROUP BY DAY(orderDate), MONTH(orderDate), YEAR(orderDate)";
	Statement s = con.createStatement();
	ResultSet r = s.executeQuery(sql);
	
	out.print("<table>");
	out.println("<tr><th>Order Date</th><th>Total Sales</th></tr>");
	
	while(r.next()){
		out.println("<tr><td>" + r.getString(1) +"-" + r.getString(2) +"-" + r.getString(3) +"</td><td>"+ currFormat.format(r.getDouble(4)) + "</td></tr>");
	} out.println("</table>");

} catch (SQLException ex) {
	out.println(ex);
} finally {
	closeConnection();
}

%>

</body>
</html>