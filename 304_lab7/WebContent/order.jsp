<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>This Grocery Order Processing</title>
</head>
<body align="center">

<% 
	session = request.getSession(true);

	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String custId;

	String cardNumber = request.getParameter("cardNumber");
	int expMonth = Integer.parseInt(request.getParameter("expMonth"));
	int expYear = Integer.parseInt(request.getParameter("expYear"));
	String cvc = request.getParameter("cvc");
	String cardType = "";
	boolean validCard = true;

	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	// Determine if valid customer id was entered
	// Determine if there are products in the shopping cart
	// If either are not true, display an error message

	// Make connection
	if (productList.isEmpty())
	{
		session.setAttribute("checkoutMessage", "Your shopping cart is empty! Why you no buy some products ah?");
		response.sendRedirect("checkout.jsp");
	}
	else
	{
		// CHECK CREDIT CARD VALIDITY
		if (expMonth < 11 && expYear == 2019) {
			session.setAttribute("checkoutMessage", "Oops, it seems that your credit card has expired. Time to extend it--or please enter one that's not expired...");
			response.sendRedirect("checkout.jsp");
			validCard = false;
		}
		else {
			if (cardNumber.charAt(0) == '3') { // American Express
				cardType = "American Express";
				if (cardNumber.length() != 15 || cvc.length() != 4) {
					session.setAttribute("checkoutMessage", "Your American Express credit card is invalid. Please try again.");
					response.sendRedirect("checkout.jsp");
					validCard = false;
				}
			}
			else if (cardNumber.charAt(0) == '4') { // VISA
				cardType = "VISA";
				if (cardNumber.length() != 16 || cvc.length() != 3) {
					session.setAttribute("checkoutMessage", "Your VISA credit card is invalid. Please try again.");
					response.sendRedirect("checkout.jsp");
					validCard = false;
				}
			}
			else if (cardNumber.charAt(0) == '5') { // MasterCard
				cardType = "MasterCard";
				if (cardNumber.length() != 16 || (cardNumber.charAt(1) != '0' && cardNumber.charAt(1) != '1' && cardNumber.charAt(1) != '2' && cardNumber.charAt(1) != '3' && cardNumber.charAt(1) != '4' && cardNumber.charAt(1) != '5') || cvc.length() != 3) {
					session.setAttribute("checkoutMessage", "Your MasterCard credit card is invalid. Please try again.");
					response.sendRedirect("checkout.jsp");
					validCard = false;
				}
			}
			else { // Anything else other than AMEX, VISA, or MC
				session.setAttribute("checkoutMessage", "Our apologies, we do not recognize your card. We currently only support VISA / VISA Debit, MasterCard, or American Express");
				response.sendRedirect("checkout.jsp");
				validCard = false;
			}
		}

		if (validCard) {
			//System.out.println("cart is not empty");
			try
			{
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_nhendrad;";
				String uid = "nhendrad";
				String pw = "34089243";
				String firstname,lastname,add,city,state,postal,country;

				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				getConnection();
				Statement stmt = con.createStatement();

				PreparedStatement query1 = con.prepareStatement("SELECT * FROM customer WHERE userid = ? AND password = ?");
				query1.setString(1, username);
				query1.setString(2, password);
				ResultSet rst = query1.executeQuery();
				
				if(rst.next())
				{
					firstname = rst.getString("firstName");
					lastname = rst.getString("lastName");
					add = rst.getString("address");
					city = rst.getString("city");
					state = rst.getString("state");
					postal = rst.getString("postalCode");
					country = rst.getString("country");
					custId = rst.getString("customerId");

					ResultSet rst2;
					
					Date date = new Date();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					String theDate = format.format(date);
					
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
					
		
					PreparedStatement pstmt = con.prepareStatement("select orderId from ordersummary order by orderId desc");
					ResultSet keys = pstmt.executeQuery();
					keys.next();
					int orderId = keys.getInt(1);
					System.out.println(orderId); 
					
					String productId = "";
					String price= "";
					double pr = 0.0;
					int qty = 0;
					
					int pid,qty2;
					double price2;
					String pname;
					
					Double subtotal = new Double(0);
					Double ordertotal = new Double(0);
					
					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
					while (iterator.hasNext())
					{ 
						Map.Entry<String, ArrayList<Object>> entry = iterator.next();
						ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
						 productId = (String) product.get(0);
				         price = (String) product.get(2);
						 pr = Double.parseDouble(price);

						 qty = ( (Integer)product.get(3)).intValue();
						 sql = String.format("insert into orderproduct values ("+orderId+","+productId+","+qty+","+pr+")");
						 stmt.execute(sql);
						 System.out.println("after execute sql");
						 

						 subtotal = qty*pr;
						 ordertotal += subtotal;
					}

					PreparedStatement pst2 = con.prepareStatement("UPDATE ordersummary SET totalAmount = " + ordertotal + " where orderId = " + orderId);
					pst2.executeUpdate();

					out.println("<h1>Your Order Summary</h1>");
					rst2 = stmt.executeQuery("select product.productId, orderproduct.quantity, orderproduct.price, product.productName from orderproduct,product where orderproduct.productId = product.productId and orderId = " + orderId);
					out.println("<table align=\"center\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
					while (rst2.next())
					{
						pid = rst2.getInt(1);
						qty2 = rst2.getInt(2);
						price2 = rst2.getDouble(3);
						pname = rst2.getString(4);
						double subt = qty2*price2;
						out.println("<tr><td>" + pid +"</td><td>" + pname + "</td><td align=\"center\">1</td><td align=\"right\">" + price2 + "</td><td align=\"right\">" + currFormat.format(subt) + "</td></tr></tr>");
					}
					out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td aling=\"right\">" + currFormat.format(ordertotal) +"</td></tr>");
					out.println("</table>");
					out.println("<h2>Transaction Approved. Thank you for your purchase!</h2>");
					out.println("<h3>Your order reference number is: " + orderId +"</h3>");
					out.println("<h4>Shipping to CustomerID: " + custId + " | Name: " + firstname + " " + lastname + "</h4>");
					out.println("<br>----------------------------------------<br><h2>Payment status: Approved</h2>");
					out.println("<h3>Paid on " + cardType + " -" + cardNumber.substring(cardNumber.length()-4, cardNumber.length()) + "</h3>");
					out.println("----------------------------------------\n");
					out.println("<h2><a href=\"index.jsp\">Back to Main Page</a></h2>");

					session.removeAttribute("checkoutMessage");
					productList.clear();
				}
				else
				{
					session.setAttribute("checkoutMessage", "We couldn't find you on our database. Please re-enter your credentials or if you haven't, why don't you become a member? <a href=\"signup.jsp\">Sign up here!</a>");
					response.sendRedirect("checkout.jsp");
				}
				
				con.close();
			}
			catch (Exception e)
			{
				e.printStackTrace();
				out.println(e);
			}
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
