<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<% 
	int signupStatus = -1;
	session = request.getSession(true);
	signupStatus = signUp(out,request,session);

	if (signupStatus == 0) {
		session.setAttribute("loginMessage","Your account has been created! Thanks for signing up with <i>Don't Leaf Me</i>! We're super thrilled to you here!");
		response.sendRedirect("login.jsp");		// Successful login for admin
	}
	else if (signupStatus == -1) {
		session.setAttribute("loginMessage","Unfortunately, someone else already has your preferred username so we couldn't sign you up. Try again with a different one.");
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
	}
	else if (signupStatus == 1) {
		session.setAttribute("loginMessage","Your passwords did not match... Please try again.");
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
	}
	else if (signupStatus == 2) {
		session.setAttribute("loginMessage","We couldn't sign you up as an admin because the provided admin credentials were invalid. Call your admin back, tell them they didn't put their login info correctly.");
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
	}
	else if (signupStatus == 3) {
		session.setAttribute("loginMessage","We couldn't sign you up as an admin because the provided admin credentials is not an admin. Please get a <i>real</i> admin.");
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
	}
	else { // signupStatus == -2
		session.setAttribute("pwdResetMessage","Whoops, we encountered an error on our end. Sign up was unsuccessful and we're truly sorry for that. Please try again, contact our developers, and provide them some coffee...");
		response.sendRedirect("signup.jsp");	
	}
%>

<%!
	int signUp(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException {
		String firstname = request.getParameter("firstName");
		String lastname = request.getParameter("lastName");

		String email = request.getParameter("email");
		String phonenum = request.getParameter("phoneNumber");

		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String postalcode = request.getParameter("postalCode").toUpperCase();
		String country = request.getParameter("country");

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String repeatPassword = request.getParameter("reenterPassword");

		String adminID = request.getParameter("adminID");
		String adminPassword = request.getParameter("adminPassword");

		int signupStatus = -2; // -2: General backend error | -1: user already exists | 0: success | 1: Passwords don't match | 2: Invalid admin credentials | 3: The admin is not an admin
		int admin = 0;

		try 
		{
			getConnection();
			Statement S = con.createStatement();

			// Check if another user with the same username already exists in db
			PreparedStatement query1 = con.prepareStatement("SELECT * FROM customer WHERE userid = ?");
			query1.setString(1, username);
			ResultSet rst1 = query1.executeQuery();
			
			if (rst1.next())
				return signupStatus;

			// Check if administrator info is valid, if administrator credentials are provided
			if (!adminID.equals("") || !adminPassword.equals("")) {
				PreparedStatement query2 = con.prepareStatement("SELECT userid, password, admin FROM customer WHERE userid = ? AND password = ?");
				query2.setString(1, adminID);
				query2.setString(2, adminPassword);
				ResultSet rst2 = query2.executeQuery();
				
				if (rst2.next()) {
					if (rst2.getInt("admin") != 1) {
						signupStatus = 3;
						return signupStatus;
					}
					else
						admin = 1;
				}
						
				else {
					signupStatus = 2;
					return signupStatus;
				}
			}

			if (!password.equals(repeatPassword))
				signupStatus = 1;
			else {
				PreparedStatement query3 = con.prepareStatement("INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				query3.setString(1, firstname);
				query3.setString(2, lastname);
				query3.setString(3, email);
				query3.setString(4, phonenum);
				query3.setString(5, address);
				query3.setString(6, city);
				query3.setString(7, state);
				query3.setString(8, postalcode);
				query3.setString(9, country);
				query3.setString(10, username);
				query3.setString(11, password);
				query3.setInt(12, admin);

				query3.executeUpdate();
				signupStatus = 0;
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally {
			closeConnection();
		}
		return signupStatus;
	}	
%>

