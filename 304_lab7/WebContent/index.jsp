
<!DOCTYPE html>
<html>
<head>
        <title>This Grocery Main Page</title>
</head>
<body>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	

	if(session.getAttribute("authenticatedUser") != null)
	{
		String name = (String) session.getAttribute("authenticatedUser");
		String name1 = name.substring(0,1);
		String name2 = name1.toUpperCase();
		out.println("<h1>Hi " +  name2 + name.substring(1)+ "!</h1>");
	}

%>

<h1 align="center">Welcome to This Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Your Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>


</body>
</head>


