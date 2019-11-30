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
		hasImage = false;
	}
	
	String sql = "select product.productId, productName, productPrice, productDesc, quantity from product,productinventory where product.productId = productinventory.productId and product.productId = ? ";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,productId);
	rst = pstmt.executeQuery();

	if (rst.next())
	{
		productName = rst.getString("productName");
		out.println("<h1>" + rst.getString(2) + "</h1>");
		out.println("<table><tr>");
		out.println("<th>Id</th><td>"+productId+"</td></tr><tr><th>Price</th><td>"+currFormat.format(rst.getDouble(3))+"</td></tr><tr><th>Product Description:   </th><td>" + rst.getString(4) + "</td><tr>");
		sql = "select reviewRating from review where productId = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,productId);
		ResultSet rst3 = pstmt.executeQuery();
		int totalRating= 0;
		int ratingCount = 0;
		double avgRating;
		while(rst3.next())
		{
			totalRating += rst3.getInt(1);
			ratingCount++;
		}
		if(totalRating!=0)
		{
			avgRating = totalRating/ratingCount;
			out.println("<tr><th>Average Rating: </th><td>"+avgRating+"</td><tr>");
		}
		else
		{
			out.println("<tr><th> No User Reviews Yet!</th><tr>");
		}
		
		if (rst.getInt(5) == 0)
		{
			out.println("<tr><th><font color=\"red\">Out Of Stock! Please Check Back Soon!</font></th></tr>");	
		}
		else
		{
			out.println("<tr><th><font color=\"green\">Item In Stock!</font></th></tr>");	
			System.out.println("this");
		}
		
		if(hasImage)
		{
			
			out.println("<img src=\""+imageURL+"\">");
		}
		out.println("</table>");
		sql = "select productImage, productName, productPrice from product where productId = " + productId;
		ResultSet rst2 = stmt.executeQuery(sql);
		rst2.next();
		if(rst2.getString(1) != null)
		{
			out.println("<img src=\"displayImage.jsp?id="+productId+"\">");
		}

		out.println("<h3><a href=\"addReview.jsp?productId=" + productId + "&productName=" + productName + "\">Leave a Review</a></h3>");
		out.println("<h3><a href=\"readReviews.jsp?productId=" + productId + "&productName=" + productName + "\">Read Buyer's Reviews</a></h3>");
		if(rst.getInt(5) != 0)
			out.println("<h3><a href=\"addcart.jsp?id=" + productId + "&name=" + rst2.getString(2) + "&price=" + rst2.getDouble(3)+"\">Add to Cart</a>");
		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>");
				
	}
%>


</body>
</html>

