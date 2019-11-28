<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>This Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("password");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection
if (productList.isEmpty())
{
	//System.out.println("cart is empty");
	out.println("<th>Shopping cart is empty!</th>");
	
}
else
{
	//System.out.println("cart is not empty");
	try
	{
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_nhendrad;";
		String uid = "nhendrad";
		String pw = "34089243";
		String firstname,lastname,add,city,state,postal,country;
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();
		//System.out.println("Connecting to db...");
		
		ResultSet rst = stmt.executeQuery("select firstName, lastName, address, city, state, postalCode, country from customer where customerId = " + custId);
		if(rst.next())
		{
			//System.out.println(" if rst.next() ran");
			firstname = rst.getString(1);
			lastname = rst.getString(2);
			add = rst.getString(3);
			city = rst.getString(4);
			state = rst.getString(5);
			postal = rst.getString(6);
			country = rst.getString(7);
			ResultSet rst2;
			
			//System.out.println("at Date date = new Date now");
			Date date = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String theDate = format.format(date);
			
			//System.out.println("at insert into order summary");
			String sql = "insert into ordersummary(orderDate,shiptoAddress,shiptoCity,shiptoState,shiptoPostalCode,shiptoCountry,customerId) values (?,?,?,?,?,?,?)";
			PreparedStatement test = con.prepareStatement(sql);
			test.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
			test.setString(2, add);
			test.setString(3, city);
			test.setString(4, state);
			test.setString(5, postal);
			test.setString(6, country);
			test.setString(7, custId);
			test.execute();
			System.out.println("did insert into order summary");
			
			// Use retrieval of auto-generated keys.
			//System.out.println("do prepared statement");
			//PreparedStatement pstmt = con.prepareStatement("select orderId from ordersummary", Statement.RETURN_GENERATED_KEYS);			
			PreparedStatement pstmt = con.prepareStatement("select orderId from ordersummary order by orderId desc");
			ResultSet keys = pstmt.executeQuery();
			keys.next();
			int orderId = keys.getInt(1);
			System.out.println(orderId);
			
			String productId = "";
			String price= "";
			double pr = 0.0;
			int qty = 0;
			Double totalPrice = 0.0;
			
			int pid,qty2;
			double price2;
			String pname;
			
			double subtotal = 0;
			double ordertotal = 0;
			
			//System.out.println("at iterator");
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				 productId = (String) product.get(0);
		         price = (String) product.get(2);
				 pr = Double.parseDouble(price);
				 //System.out.println("after pr");
				 qty = ( (Integer)product.get(3)).intValue();
				 sql = String.format("insert into orderproduct values ("+orderId+","+productId+","+qty+","+pr+")");
				 stmt.execute(sql);
				 System.out.println("after execute sql");
				 
				 //rst2 = stmt.executeQuery("select productPrice from product where productId = " + productId);
				 /*if(rst.next())
				 {
					 totalPrice = totalPrice + rst.getDouble(1);
				 } */
				 
				 subtotal = qty*pr;
				 ordertotal += subtotal;
				 
		         
			}
			//System.out.println("finish while");
			stmt.execute("update ordersummary set totalAmount = " + totalPrice + " where orderId = " + orderId);
			out.println("<h1> Your Order Summary</h1>");
			rst2 = stmt.executeQuery("select product.productId, orderproduct.quantity, orderproduct.price, product.productName from orderproduct,product where orderproduct.productId = product.productId and orderId = " + orderId);
			out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
			while (rst2.next())
			{
				pid = rst2.getInt(1);
				qty2 = rst2.getInt(2);
				price2 = rst2.getDouble(3);
				pname = rst2.getString(4);
				double subt = qty2*price2;
				out.println("<tr><td>" + pid +"</td><td>" + pname + "</td><td align=\"center\">1</td><td align=\"right\">$" + price2 + "</td><td align=\"right\">$" + subt + "</td></tr></tr>");
			}
			out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td aling=\"right\">$" + ordertotal +"</td></tr>");
			out.println("</table>");
			out.println("<h1>Order completed.  Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: " + orderId +"</h1>");
			out.println("<h1>Shipping to customer: " + custId + "Name: " + firstname + lastname + "</h1>");
			out.println("\n");
			out.println("<h2><a href=\"shop.html\">Back to Main Page</a></h2>");
			
			productList.clear();
		}
		else
		{
			out.println("<th>Customer ID is incorrect!</th>");	
		}
		
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	
}


// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

