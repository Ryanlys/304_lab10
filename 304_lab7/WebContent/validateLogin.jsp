<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%! int admin = 2; %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null && admin == 1)
		response.sendRedirect("adminIndex.jsp");		// Successful login for admin
	else if(authenticatedUser != null && admin == 0)
	{
		response.sendRedirect("index.jsp"); //send to normie index
	}
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
		{
			return null;
		}
				
		if((username.length() == 0) || (password.length() == 0))
		{
			return null;
		}
				
		try 
		{
			getConnection();
			
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			retStr = null;
			
			Statement S = con.createStatement();
			ResultSet R = S.executeQuery("SELECT userid, password, admin FROM customer");
			
			while (R.next()){
				if(username.equals(R.getString("userid")) && password.equals(R.getString("password")))
				{
					retStr = username;
					if(R.getInt(3) == 0) // valid user but not admin
					{
						admin = 0;
					} else if (R.getInt(3) == 1)
					{
						admin = 1; //user is admin
					}
					session.setAttribute("authenticatedUser",retStr);
					session.setAttribute("admin",admin);

				}
					
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally {
			closeConnection();
		}	
		
		if(retStr != null)
		{	
			session.removeAttribute("loginMessage");
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

