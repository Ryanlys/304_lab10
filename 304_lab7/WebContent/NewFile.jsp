<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%
try
{
	getConnection();
	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("select * from ordersummary where orderId = 1");
	System.out.println(rst.next());

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