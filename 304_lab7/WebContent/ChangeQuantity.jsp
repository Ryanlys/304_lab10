<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
	// Get the current list of products
	if (session.getAttribute("authenticatedUser") != null) {

	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
	
	String id = request.getParameter("id");
	String quantity = request.getParameter("quantity");
	String price = request.getParameter("productPrice");
	String name = request.getParameter("productName");
	
	ArrayList<Object> product;
	
	if (productList.containsKey(id)) {
		// Remove item from cart
		productList.remove(id);

		// Re-add the item with the updated amount
		response.sendRedirect("addcart.jsp?id=" + id + "&name=" + name + "&price=" + price + "&quantity=" + quantity);
	}
}
%>