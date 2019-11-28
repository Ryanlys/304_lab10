<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Welcome to [insert store name here]</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
	<table style="display:inline">
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
		<td><input type="text" name="username"  size=10 maxlength=10></td>
	</tr>
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
		<td><input type="password" name="password" size=10 maxlength="10"></td>
	</tr>
	</table>
	<br/>
	<h3>First timer? <a href="signup.jsp">Sign up here!</a></h3>
	<h3>Forgot your username or password? <a href="resetAccount.jsp">Reset your password here!</a></h3>
	<input class="submit" type="submit" name="Submit2" value="Log In">
</form>

</div>

</body>
</html>