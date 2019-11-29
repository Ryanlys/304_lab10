<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	</head>
	
	<body>

		<div style="margin:0 auto;text-align:center;display:inline">

		<h3>Reset Password</h3>
		<h4>No worries, we understand that people forget their passwords often. It happens, and we'll just need to verify some information first before we reset your password.</h4>

		<%
		// Print prior error login message if present
		if (session.getAttribute("pwdResetMessage") != null)
			out.println("<p>"+session.getAttribute("pwdResetMessage").toString()+"</p>");
		%>

		<br>
		<form name="ResetPassword" method=post action="resetpassword.jsp">
			<table style="display:inline">
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
				<td><input type="text" name="username"  size=20 maxlength=20 align="center"></td>
			</tr>
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
				<td><input type="text" name="email" size=20 maxlength="40" align="center"></td>
			</tr>
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
				<td><input type="text" name="lastname" size=20 maxlength="20" align="center"></td>
			</tr>
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code (A1B C2D):</font></div></td>
				<td><input type="text" name="postalcode" size=20 maxlength="7" align="center"></td>
			</tr>
			</table>
			<table style="display:inline">
			<tr>
				<h3>Enter your desired password below. Your password will be changed if the given credentials match our records.</h3>
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">New Password:</font></div></td>
				<td><input type="password" name="newPassword" size=20 maxlength="30" align="center"></td>
			</tr>
			<tr>
				<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Repeat Password:</font></div></td>
				<td><input type="password" name="repeatNewPassword" size=20 maxlength="30" align="center"></td>
			</tr>
			<tr>
				<td colspan="2"><input class="submit" type="submit" name="Submit2" value="RESET"></td>
			</tr>
			</table>
		</form>

		</div>

	</body>
</html>