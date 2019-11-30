<!DOCTYPE html>
<html>
<head>
<title>Add Review</title>

</head>
	<body align="center">
		<%@ page import="java.text.NumberFormat" %>
		<%@ include file="jdbc.jsp" %>

		<%
			session = request.getSession(true);
			getConnection();
			Statement s = con.createStatement();

			String productId = request.getParameter("productId");
			String productName = request.getParameter("productName");

			int reviewCount = 0;
			Double totalRating = new Double(0);

			PreparedStatement pst1 = con.prepareStatement("SELECT * FROM review, customer WHERE productId = ? AND review.customerId = customer.customerId");
			pst1.setString(1, productId);

			ResultSet review = pst1.executeQuery();

			out.println("<h2>Here's what buyers say about:</h2>");
			out.println("<h1>" + productName + "</h1>");
			out.println("<table style=\"display:inline\">");
			out.println("<tr><th>Name</th>");
			out.println("<th>Rating</th>");
			out.println("<th>Review</th></tr>");

			while (review.next()) {
				String customerName = review.getString("firstName") + review.getString("lastName");
				String rating = review.getString("reviewRating");
				String reviewDescription = review.getString("reviewComment");

				out.println("<tr>");
				out.println("<td>" + customerName + "</td>");
				out.println("<td>" + rating + "</td>");
				out.println("<td align=\"left\">" + reviewDescription + "</td>");
				out.println("</tr>");

				reviewCount++;
				totalRating += Double.parseDouble(rating);
			}

			out.println("</table>");
			out.println("<h3>------------------------------------------</h3>");
			out.println("<h3>Total Reviews: " + reviewCount + "</h3>");
			out.println("<h3>Average Rating: " + (totalRating / reviewCount) + " / 5</h3>");
			out.println("<h3>------------------------------------------</h3>");
			out.println("<a href=\"product.jsp?id=" + productId + "\">Back to " + productName + "</a>");
		%> 
	</body>

</html>

