
<!DOCTYPE html>
<html>
<head>
        <title>Don't Leaf Me: Main</title>
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

<h1 align="center">Welcome to Don't Leaf Me</h1>


<h2 align="center"><a href="AboutUs.jsp">About Us</a></h2>
<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>
<%
	if(session.getAttribute("authenticatedUser") != null)
	{
		out.println("<h2 align=\"center\"><a href=\"yourInfo.jsp\">Your Info</a></h2>");
		out.println("<h2 align=\"center\"><a href=\"logout.jsp\">Log out</a></h2>");
	}
	else
	{
		out.println("<h2 align=\"center\"><a href=\"login.jsp\">Login</a></h2>");
	}

%>


</body>
</head>


