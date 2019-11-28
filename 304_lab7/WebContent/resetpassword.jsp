<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%! int admin = 2; %>

<% 
	int passwordReset = -1;
	session = request.getSession(true);
	passwordReset = resetPassword(out,request,session);

	if(passwordReset == 0) {
		session.setAttribute("loginMessage","Your password has been reset successfully.");
		response.sendRedirect("login.jsp");		// Successful login for admin
	}
	else if (passwordReset == -1) {
		session.setAttribute("pwdResetMessage","Our apologies but we couldn't find the matching credentials you provided us. We can't reset your password, please try again..");
		response.sendRedirect("resetAccount.jsp");		// Failed login - redirect back to login page with a message
	}
	else if (passwordReset == 1) {
		session.setAttribute("pwdResetMessage","We found the matching credentials but the new passwords you provided did not match. Please try again..");
		response.sendRedirect("resetAccount.jsp");		// Failed login - redirect back to login page with a message
	}
%>

<%!
	int resetPassword(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String lastname = request.getParameter("lastname");
		String postalCode = request.getParameter("postalcode").toUpperCase();
		String newPassword = request.getParameter("newPassword");
		String repeatNewPassword = request.getParameter("repeatNewPassword");
		int reset = -1; // -1: no matching account ; 0: success ; 1: passwords don't match
				
		try 
		{
			getConnection();
			Statement S = con.createStatement();

			PreparedStatement query1 = con.prepareStatement("SELECT userid, email, lastName, postalCode FROM customer WHERE userid = ? AND email = ? AND lastName = ? AND postalCode = ?");
			query1.setString(1, username);
			query1.setString(2, email);
			query1.setString(3, lastname);
			query1.setString(4, postalCode);

			ResultSet R = query1.executeQuery();
			
			if (R.next()) {
				if (newPassword.equals(repeatNewPassword)) {
					PreparedStatement query2 = con.prepareStatement("UPDATE customer SET password = ? WHERE userid = ?");
					query2.setString(1, newPassword);
					query2.setString(2, username);
					
					query2.executeUpdate();
					reset = 0;
				}
				else {
					reset = 1;
				}
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally {
			closeConnection();
		}
		return reset;
	}	
%>

