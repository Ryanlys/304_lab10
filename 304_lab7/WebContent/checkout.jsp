<!DOCTYPE html>
<html>
<head>
<title>This Grocery</title>
</head>
<body align="center">

<h1>Checkout</h1>
<%
	// Print prior error login message if present
	if (session.getAttribute("checkoutMessage") != null)
		out.println("<h2>"+session.getAttribute("checkoutMessage").toString()+"</h2>");
%>
<form method="get" action="order.jsp">

	<h3>Enter your Customer ID and Password to complete the transaction:</h3>
	<table style="display:inline">
		<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
		<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
	</table>

	<h3>And your payment details...</h3>
	<h5>We accept major credit cards such as VISA, MasterCard, and American Express!</h5>
	<table style="display:inline">
		<tr><td>Card Number:</td><td colspan="3"><input type="number" name="cardNumber" size="20"></td></tr>
		<tr><td>Expiry MM/YY:</td>
			<td>
				<select name="expMonth">
				  <option value="1">01</option>
				  <option value="2">02</option>
				  <option value="3">03</option>
				  <option value="4">04</option>
				  <option value="5">05</option>
				  <option value="6">06</option>
				  <option value="7">07</option>
				  <option value="8">08</option>
				  <option value="9">09</option>
				  <option value="10">10</option>
				  <option value="11">11</option>
				  <option value="12">12</option>
				</select>
			</td>
			<td>
			<select name="expYear">
				  <option value="2019">2019</option>
				  <option value="2020">2020</option>
				  <option value="2021">2021</option>
				  <option value="2022">2022</option>
				  <option value="2023">2023</option>
				  <option value="2024">2024</option>
				  <option value="2025">2025</option>
				</select>
			</td>
		</tr>
		<tr><td>CVC:</td><td><input type="number" name="cvc" size="4" maxlength="4"></td></tr
	</table>
	<br>
	<table style="display:inline">
		<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
	</table>
</form>

</body>
</html>

