<!DOCTYPE html>
<html>
<head>
<title>Add Review</title>

</head>
	<body>
		<%@ include file="auth.jsp"%>
		<%@ page import="java.text.NumberFormat" %>
		<%@ include file="jdbc.jsp" %>

		<%
			session = request.getSession(true);
			getConnection();
			Statement s = con.createStatement();

			String username = (String) session.getAttribute("authenticatedUser");
			String productId = request.getParameter("productId");
			String productName = request.getParameter("productName");
			String customerId = "";

			// Get customer ID
			PreparedStatement pst1 = con.prepareStatement("SELECT customerId FROM customer WHERE userid = ?");
			pst1.setString(1, username);
			ResultSet searchCustomer = pst1.executeQuery();

			if (searchCustomer.next())
				customerId = searchCustomer.getString("customerId");

			// Checks if a customer has purchased the item before
			PreparedStatement pst2 = con.prepareStatement("SELECT orderproduct.productId FROM ordersummary, orderproduct, customer WHERE ordersummary.customerId = ? AND orderproduct.orderId = ordersummary.orderId");
			pst2.setString(1, customerId);
			ResultSet productPurchaseHistory = pst2.executeQuery();

			boolean customerHasPurchasedProduct = false;
			while (productPurchaseHistory.next() && !customerHasPurchasedProduct) {
				if ((productPurchaseHistory.getString("productId")).equals(productId))
					customerHasPurchasedProduct = true;
			}

			//
			if (customerHasPurchasedProduct) {
				session.removeAttribute("productMessage");
				out.println("<h3>You're leaving a review for</h3>");
				out.println("<h1>" + productName + "</h1>");
			}
			else {
				session.setAttribute("productMessage", "Sorry, you need to purchase the product in order to leave a review. Why not buy one so you can leave your thoughts to other people?");
				response.sendRedirect("product.jsp?id=" + productId);
			}
		%> 

		<form method="get" action="submitReview.jsp">
			<table style="display:inline">
				<tr>
					<td><h3>How would you rate the product in general? (1 = awful, 5 = my money was well spent)</h3></td>
					<td>
						<select name="rating">
						  <option value="1">1</option>
						  <option value="2">2</option>
						  <option value="3">3</option>
						  <option value="4">4</option>
						  <option value="5">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan='2'><h3>People love detailed review, so tell 'em more! (Optional)</h3></td>
				</tr>
				<tr>
					<td colspan='2'><textarea maxlength="1000" name="reviewDescription"></textarea></td>
				</tr>
			</table>
			
			<table style="display:inline">
				<tr><td colspan="2"><input type="submit" value="SUBMIT REVIEW"></td><td><input type="reset" value="Reset"></td></tr>
			</table>
		</form>
	</body>


</html>

