<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	</head>
	
	<body>

		<div style="margin:0 auto;text-align:center;display:inline">

		<h2>Sign Up</h2>
		<h4>Knock knock, who's there? Welcome to <i>Don't Leaf Me</i>! We're glad to see new members coming by so please fill in the personal stuffs below and we'll get you on board (rest assured, we've got your information safe and secure).</h4>

		<%
		// Print prior error login message if present
		if (session.getAttribute("signupMessage") != null)
			out.println("<p>"+session.getAttribute("signupMessage").toString()+"</p>");
		%>

		<br>
		<form name="SignUp" method=post action="validateSignup.jsp">
			<h5>Step 1: Tell us who you are!</h5>
			<table style="display:inline">
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
					<td><input type="text" name="firstName"  size=20 maxlength=40 align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
					<td><input type="text" name="lastName" size=20 maxlength="40" align="center"></td>
				</tr>
			</table>

			<h5>Step 2: How shall we reach out to you?</h5>
			<table style="display:inline">
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
					<td><input type="text" name="email" size=20 maxlength="50" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone #:</font></div></td>
					<td><input type="text" name="phoneNumber" size=20 maxlength="20" align="center"></td>
				</tr>
			</table>

			<h5>Step 3: Where do you live?</h5>
			<table style="display:inline">
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address</font></div></td>
					<td><input type="text" name="address" size=20 maxlength="50" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City</font></div></td>
					<td><input type="text" name="city" size=20 maxlength="40" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State</font></div></td>
					<td><input type="text" name="state" size=20 maxlength="20" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code (A1B 2CD):</font></div></td>
					<td><input type="text" name="postalCode" size=20 maxlength="7" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
					<td><input type="text" name="country" size=20 maxlength="40" align="center"></td>
				</tr>
			</table>

			<h5>Step 4: Now your login credentials...</h5>
			<table style="display:inline">
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
					<td><input type="text" name="username" size=20 maxlength="20" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
					<td><input type="password" name="password" size=20 maxlength="30" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Re-enter Password:</font></div></td>
					<td><input type="password" name="reenterPassword" size=20 maxlength="30" align="center"></td>
				</tr>
			</table>
			
			<h5>Step 5: Should we make you an admin?</h5>
			<h6>(Leave blank for regular members, or ask an admin to provide their login information to you so you become an admin)</h6>
			<table style="display:inline">
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Admin ID:</font></div></td>
					<td><input type="text" name="adminID" size=20 maxlength="20" align="center"></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Admin Password:</font></div></td>
					<td><input type="password" name="adminPassword" size=20 maxlength="30" align="center"></td>
				</tr>
			</table>
			<br>
			<table style="display:inline">
				<tr>
					<td colspan="2"><input class="submit" type="submit" name="Submit2" value="SIGN UP"></td>
				</tr>
			</table>
		</form>

		</div>

	</body>
</html>