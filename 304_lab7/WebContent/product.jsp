<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Don't Leaf Me - Product Information</title>
<!--  <link href="css/bootstrap.min.css" rel="stylesheet"> -->
</head>
<body>

<%@ include file="header.jsp" %>

<%
	// Print prior error login message if present
	if (session.getAttribute("productMessage") != null)
		out.println("<p>"+session.getAttribute("productMessage").toString()+"</p>");
%>


<%
getConnection();
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
String productName = "";
boolean hasImage = false;

String sql = "select productId, productName, productPrice, productDesc from product where productId = " + productId;
String imageURL = "";
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery("select productImageURL from product where productId = " + productId);
rst.next();
if (rst.getString(1) != null)
{
	imageURL = rst.getString(1);
	hasImage = true;
}
else
{
	System.out.println("the else works");
	hasImage = false;
}
rst = stmt.executeQuery(sql);
if (rst.next())
{
	productName = rst.getString("productName");
	out.println("<h1>" + rst.getString(2) + "</h1>");
	out.println("<table><tr>");
	out.println("<th>Id</th><td>"+productId+"</td></tr><tr><th>Price</th><td>"+currFormat.format(rst.getDouble(3))+"</td></tr><tr><th>Product Description:   </th><td>" + rst.getString(4) + "</td><tr>");
	if(hasImage)
	{
		
		out.println("<img src=\""+imageURL+"\">");
	}
	sql = "select productImage, productName, productPrice from product where productId = " + productId;
	ResultSet rst2 = stmt.executeQuery(sql);
	rst2.next();
	if(rst2.getString(1) != null)
	{
		out.println("<img src=\"displayImage.jsp?id="+productId+"\">");
	}
	out.println("</table>");
	out.println("<h3><a href=\"addReview.jsp?productId=" + productId + "&productName=" + productName + "\">Leave a Review</a></h3>");
	out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>");
	out.println("<h3><a href=\"addcart.jsp?id=" + productId + "&name=" + rst2.getString(2) + "&price=" + rst2.getDouble(3)+"\">Add to Cart</a>");
	

	
}
// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>


</body>
</html>

